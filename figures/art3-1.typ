#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#set page(
  height: 9.2cm, 
  width: 17.9cm,
  margin: 0.1cm
)
//#set page(fill: none)


#let f1 = (
  function: k => (k - 1)/(2*k - 1),
  stroke: (
    paint: blue,
    thickness: 1.6pt,
    dash: "solid"
  )
)
#let f2 = (
  function: k => 1/2,
  stroke: (
    paint: red,
    thickness: 1.6pt,
    dash: "dotted"
  )
)


#let domain = (2, 20)

#let plot-routine(f) = {
  plot.add(
    domain: domain,
    samples: 300,
    f.at("function"),
    style: (stroke: f.at("stroke"))
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
    x-label: $k$,         y-label: rotate(90deg)[$alpha$],
    {
      plot-routine(f1)
      plot-routine(f2)
    }
  )
})