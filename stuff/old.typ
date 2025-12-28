
#let math-env(header, ..args) = {
  c.step()
  let name = none
  let body = none
  let nargs = args.pos().len()
  if nargs == 2 {
    name = args.pos().at(0)
    body = args.pos().at(1)
  }
  else if nargs == 1 {
    body = args.pos().at(0)
  }
  block[
    // global section counter in the left margin (use local counter besides the header)
    //#h(-2em) (#context c.display())
    *#header #context c.display().*
    #{
      if name != none [
        $space$ (#emph(name))
        // 
        /*#align(end)[
          #block(above:lead, width:100%-3em)[
            #set align(start)
            #body]
        ]*/
        \ #body
      ]
      else [
        #body
      ]
    }
  ]
}

#let definition   = math-env.with("Definition")
#let theorem      = math-env.with("Theorem")
#let proposition  = math-env.with("Proposition")
#let lemma        = math-env.with("Lemma")
#let remark       = math-env.with("Remark")
#let problem      = math-env.with("Problem")
#let example      = math-env.with("Example")
#let proof(body) = block[
  _Proof_
  #body
]



// --- STYLE FUNCTIONS ---

#let classic-style(name, clabel, title, body,
                   stroke: 1pt + gray,
                   inset : 6pt,
                   radius: 4pt,
) = block(
  stroke: stroke, inset: inset, radius: radius
)[
  #text(strong(name)) 
  //#if clabel != none { label(clabel) }
  #if title != none { text(" (" + title + ")") } else { [] }
  #text(":") #linebreak()
  #body
]

#let box-style(name, label, title, body, 
               fill  : luma(240),
               inset : 8pt,
               radius: 6pt,
) = block(
  fill: fill, inset: inset, radius: radius,
)[
  #if label != none { label(label) }
  #text(strong(name)) #if title != none { " — " + title } else { [] }
  #linebreak()
  #body
]

// --- ENVIRONMENT FACTORY ---

#let math-env(name, style, ..args) = {
  let pos = args.pos()
  let label = none
  let title = none
  let body  = none

  if pos.len() == 3 {
    (label, title, body) = (pos.at(0), pos.at(1), pos.at(2))
  } else if pos.len() == 2 {
    (title, body) = (pos.at(0), pos.at(1))
  } else if pos.len() == 1 {
    body = pos.at(0)
  } else {
    panic("Usage: #name[title][body] or #name[body]")
  }

  style(name, label, title, body)
}


// --- SPECIFIC ENVIRONMENTS ---

#let theorem    = math-env.with("Theorem", classic-style)
#let definition = math-env.with("Definition", 
                    box-style.with(fill: aqua))

// --- USAGE ---

#theorem("mvt")[Mean Value Theorem][
  If f is continuous on $[a,b]$ and differentiable on $(a,b)$, then there exists $c$ in $(a,b)$ such that $f'(c) = (f(b)-f(a))/(b-a)$.
]

#definition[Continuity][
  A function $f$ is continuous at $x_0$ if … \
  As for //@mvt
]
