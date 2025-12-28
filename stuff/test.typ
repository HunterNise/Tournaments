#import "/template/template.typ": *
#show: math-envs-init


= Test

#definition[ciao][#lorem(20)]
#theorem[#lorem(20)]
#proof[#lorem(25)]
#theorem[important][$1 = 1$]
#proof[#lorem(10) $ 1=1 $]

#set heading(numbering: "1.")
= Another test

#theorem(label: "mvt")[Mean Value Theorem][
  If f is continuous on $[a,b]$ and differentiable on $(a,b)$, then there exists $c$ in $(a,b)$ such that $f'(c) = (f(b)-f(a))/(b-a)$.
] //<mvt>

#definition[Continuity][
  A function $f$ is continuous at $x_0$ if … \
  As for @mvt ...
]

#linebreak()

#{
  let a = [from]
  let b = [*world*]
  [hello ]
  a + [ the ] + b
}

#if 1 < 2 [
  This is shown
] else [
  This is not.
]

#align(end)[
  #block(above:lead, width:100%-2em)[
    #set align(start)
    #lorem(30)
  ]
]

#set heading(numbering: "1.")
= Eccoci <qui>
Vai su @qui

= Riprovo <qua>
Vai #link(<qua>)[qua]

#show link: it => {
  set text(blue)
  underline(it)
}

= Header <my-header1>
Please see #link(<my-header1>)[My Header] \
This is #text(fill: blue)[#underline[not a link]].

#set heading(numbering: none)
= Header <my-header>
Please see #link(<my-header>)[My Header]

#show link: underline

https://example.com \

#link("https://example.com") \
#link("https://example.com")[See example.com]

#let blue-underline(it) = underline({
  set text(blue)
  it
})

#theorem[long theorem][#lorem(100)]

#show link: blue-underline

#show ref: it => {
  if it.element.numbering == none {
    // Use your custom scheme
    link(it.target, it.element.body)
  } else {
    // Default `ref`
    it
  }
}

= The Header
<my-header2>

= Another header
<another-header>

Please see #link(<my-header2>)[This heading] for more details.

Or, check out @another-header


#figure(
  caption: [Timing results],
)[#table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  )] <table>

@table

#line(length: 100%)

#let vector(x) = math.arrow(x)
#show "x": $vector(x)$
x

questo è bold:
#{
  show "y": $bold(y)$
  $x + y$
}

#theorem[
  #show "y": $bold(y)$
  $x + y$
]

questo no: #h(1.5em)
$x + y$

#let bolt = box(width: 75pt, height: 150pt, stroke: black)[
  #polygon(
    fill: black,
    (97.0%, 6.3%),
    (63.6%, 6.3%),
    (15.2%, 54.7%),
    (52.7%, 50.0%),
    (20.0%, 80.0%),
    (5.5%, 69.1%),
    (4.2%, 95.3%),
    (62.4%, 85.3%),
    (27.9%, 83.1%),
    (89.7%, 38.8%),
    (41.2%, 45.0%)
  )
]

This is absurd: #bolt \
$x+y$ #absurd \u{26A1} \u{1F5F2}


//#if not not-defined [ciao]

#let flag = state("flag", true)
#context flag.get()
#type(context flag.get())
//#if (context flag.get() == true) [ciao]

#let s = state("coso", true);
#context if  s.get()  {1} else {2};
#s.update(false);
#context if s.get() {1} else {2};