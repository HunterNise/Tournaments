// refactoring of the package great-theorems
//  https://github.com/jbirnick/typst-great-theorems/blob/master/lib.typ

#let mathblock(
    blocktitle: none, 
    counter: none, 
    numbering: "1.1", 
    prefix: auto, 
    titlix: title => [(#title)], 
    suffix: none, 
    bodyfmt: body => body,
    ..global_block_args
  ) = {
  // check if blocktitle was provided
  if blocktitle == none {
    panic("You have created a `mathblock` without a `blocktitle`. Please provide a `blocktitle` like \"Theorem\" or \"Lemma\" or \"Proof\".")
  }

  // set the default prefix behaviour
  if prefix == auto {
    if counter == none {
      prefix = [*#blocktitle.*]
    } else {
      prefix = (counter) => [*#blocktitle #counter.*]
    }
  }

  // check consistency of `counter` and `prefix`
  if counter == none and type(prefix) == function {
    panic("You have created a `mathblock` without a `counter` but with a `prefix` that accepts a counter. This is inconsistent. If you want a counter, then provide it with the `counter` argument (see documentation). If you don't want a counter, then you need to set a `prefix` that doesn't depend on a counter (see documentation).")
  } else if counter != none and type(prefix) != function {
    panic("You have created a `mathblock` with a `counter` but with a `prefix` that doesn't depend on a counter. This is inconsistent. If you don't want a counter, then remove the `counter` argument. If you want a counter, then set a prefix that depends on a counter (see documentation).")
  }

  // wrap native counter to a uniform interface
  if counter != none and type(counter) != dictionary {
    counter = (
      step   : (..args) => { counter.step(..args) },
      get    : (..args) => { counter.get(..args) },
      at     : (..args) => { counter.at(..args) },
      display: (..args) => { counter.display(..args) },
    )
  }

  // return the environment for the user
  // single unified figure kind; behaviour depends on whether `counter` was provided
  return (
    title: none, 
    number: auto, 
    numbering: numbering, 
    prefix: prefix, 
    titlix: titlix, 
    suffix: suffix, 
    bodyfmt: bodyfmt, 
    ..local_block_args, 
    body
  ) => {
    figure(
      kind: "great-theorem", 
      supplement: blocktitle, 
      outlined: false
    )[#block(width: 100%, ..global_block_args.named(), ..local_block_args.named())[ 
      // if we have a counter, step it (unless user supplied an explicit number)
      #if counter != none [
        #if number == auto [
          // normal automatic numbering
          #(counter.step)()
          #{number = context (counter.display)(numbering)}
          // store a function that can compute the final numbering from a location
          #metadata((loc) => { std.numbering(numbering, ..((counter.at)(loc))) })
          #label("great-theorems:numberfunc")
        ] else [
          // user provided a manual number; store it so refs still work
          #metadata((loc) => number)
          #label("great-theorems:numberfunc")
        ]
        // show prefix that depends on the computed number
        #prefix(number)
      ] else [
        // uncounted blocks simply use the prefix as-is
        #prefix
      ]

      // optional title and the body
      #if title != none [#titlix(title)]
      #bodyfmt(body)
      #suffix
      #parbreak()
    ]]
  }
}

#let proofblock(
    blocktitle: "Proof", 
    prefix: text(style: "oblique", [Proof.]), 
    prefix_with_of: of => text(style: "oblique", [Proof of #of.]), 
    suffix: [#h(1fr) $square$], 
    bodyfmt: body => body, 
    ..global_block_args
  ) = {
  // return the environment for the user (now using the unified figure kind)
  return (
    of: none, 
    prefix: prefix, 
    prefix_with_of: prefix_with_of, 
    suffix: suffix, 
    bodyfmt: bodyfmt, 
    ..local_block_args, 
    body
  ) => {
    if type(of) == label {
      of = ref(of)
    }

    figure(
      kind: "great-theorem", 
      supplement: blocktitle, 
      outlined: false
    )[#block(width: 100%, ..global_block_args.named(), ..local_block_args.named())[ 
      #if of != none [#prefix_with_of(of)] else [#prefix]
      #bodyfmt(body)
      #suffix
      #parbreak()
    ]]
  }
}

#let great-theorems-init(body) = {
  // layout behaviour for the unified figure kind
  show figure.where(kind: "great-theorem"): set align(start)
  show figure.where(kind: "great-theorem"): set block(breakable: true)
  show figure.where(kind: "great-theorem"): fig => fig.body

  // override references: detect whether the target figure has a number label
  show ref: it => {
    if it.element != none and it.element.func() == figure and it.element.kind == "great-theorem" {
      // prefer an explicit supplement from the citation, otherwise fall back to the figure's supplement
      let supplement = if it.citation.supplement != none { it.citation.supplement } else { it.element.supplement }

      // try to find the internal number-function label placed by counted blocks
      let data = query(selector(label("great-theorems:numberfunc")).after(it.target)).first()
      // if we found a label, it's a counted block: call the stored function to compute the final number
      if data != none {
        let numberfunc = data.value
        link(it.target, [#supplement #numberfunc(data.location())])
      } else {
        // no label => uncounted block: just show the supplement
        link(it.target, [#supplement])
      }
    } else {
      // not one of our special figures: leave the ref alone
      it
    }
  }

  body
}