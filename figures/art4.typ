#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#set page(
  height: 11.5cm, 
  width:  12cm,
  margin: 0.1cm
)
//#set page(fill: none)


#let f1 = (
  function: x => (1 - x)/3,
  stroke: (
    paint: blue,
    thickness: 1.6pt,
    dash: "solid"
  )
)


#let domain = (0, 2)

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
    size: (10, 10),
    x-min: domain.at(0),  x-max: domain.at(1),
    y-min: 0,             y-max: 1,
    x-label: $lambda$,    y-label: rotate(90deg)[$alpha$],
    {
      let f = f1
      plot.add(
        domain: domain,
        samples: 300,
        f.at("function"),
        style: (stroke: f.at("stroke")),
        hypograph: true
      )
    }
  )
})