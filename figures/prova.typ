#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart

#set page(height: 13cm, margin: 1cm)

// define functions (you can also pass inline `x => ...`)
#let f(x) = calc.sin(x)
#let g(x) = calc.cos(x) * 0.7 + 0.2

// a centered canvas with one plot containing two overlapping curves + legend
#align(center)[
  #cetz.canvas({
    //import cetz.plot
    //import cetz.palette

    plot.plot(
      size: (14, 8),                 // width x height in cm
      x-min: 0,
      x-max: 2 * calc.pi,
      y-min: -1.5,
      y-max: 1.5,
      x-label: $x$,
      y-label: $y$,
      legend: "south-east",          // position of the legend (many presets exist)
      {
        // sine curve (blue)
        plot.add(
          domain: (0, 2 * calc.pi),
          samples: 300,              // increase samples for a smooth curve
          x => f(x),
          label: $ sin x $ ,
          style: (stroke: (paint: blue, thickness: 1.6pt))
        )

        // cosine-like curve (red)
        plot.add(
          domain: (0, 2 * calc.pi),
          samples: 300,
          x => g(x),
          label: $ 0.7 cos x + 0.2 $ ,
          style: (stroke: (paint: red, thickness: 1.6pt))
        )

        // optional: add a filled area between curves (helper in cetz-plot)
        // plot.add-fill-between(domain: (0, 2 * calc.pi), f, g, style: (fill: rgb(205,205,255, 40%)))
      }
    )
  })
]
