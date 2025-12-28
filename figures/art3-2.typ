#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#set page(
  height: 9.2cm, 
  width: 17.9cm,
  margin: 0.1cm
)
//#set page(fill: none)


#let f1 = (
  function: n => 1/3,
  label: "RSEBR",
  color: blue
)
#let f2 = (
  function: n => 1 - 2/(n - 1),
  label: "CR",
  color: red
)
#let f3 = (
  function: n => 1 - 2/n,
  label: "TCR",
  color: teal
)
#let f4 = (
  function: n => 1/2 - 1/(n * (n - 1)),
  label: "ICR",
  color: yellow
)
#let f5 = (
  function: n => 1/2 - (n - 2)/(n * (n - 1)),
  label: "RVCR",
  color: lime
)


#let domain = (2, 20)

#let plot-routine(f) = {
  plot.add(
    domain: domain,
    samples: 300,
    f.at("function"),
    label: f.at("label"),
    style: (stroke: (paint: f.at("color"), thickness: 1.6pt))
  )
}


#cetz.canvas({
  // cetz.draw.set-style(axes: (
  //   y: (label: (angle: 10deg))
  // ))

  plot.plot(
    size: (14, 8),
    x-min: domain.at(0),  x-max: domain.at(1),
    y-min: 0,             y-max: 1,
    x-label: $n$,         y-label: rotate(90deg)[$alpha$],
    legend: "east",
    {
      plot-routine(f1)
      plot-routine(f2)
      plot-routine(f3)
      plot-routine(f4)
      plot-routine(f5)

      plot.add-fill-between(
        domain: domain, 
        x => 1/3, 
        x => 0, 
        style: (fill: gray)
      )
    }
  )
})