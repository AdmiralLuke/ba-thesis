#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond
#import "@preview/cetz:0.2.2"

#figure([
  #cetz.canvas({
  import cetz.draw: *
    content((-9.8, 5.5))[Input layer]
    content((-4.8, 5.5))[Hidden layer]
    content((0.2, 5.5))[Output layer]
    rect((-10, 0), (-9.5, 5))
    rect((-5, 1), (-4.5, 4))
    rect((0, 0), (0.5, 5))
    
    line((-9.5, 0), (-5, 1))
    line((-9.5, 5), (-5, 4))
    line((-4.5, 1), (0, 0))
    line((-4.5, 4), (0, 5))

    circle((-9.75, 4.5), radius: .2)
    circle((-9.75, 4.0), radius: .2)
    circle((-9.75, 3.5), radius: .2)
    circle((-9.75, 2), radius: .2)
    circle((-9.75, 0.5), radius: .2)

    circle((-4.75, 3.5), radius: .2)
    circle((-4.75, 3), radius: .2)
    circle((-4.75, 1.5), radius: .2)

    circle((.25, 4.5), radius: .2)
    circle((.25, 4.0), radius: .2)
    circle((.25, 3.5), radius: .2)
    circle((.25, 2), radius: .2)
    circle((.25, 0.5), radius: .2)

    content((-10.4, 4.55))[$x_1$]
    content((-10.4, 4.05))[$x_2$]
    content((-10.4, 3.55))[$x_3$]
    content((-10.4, 2.05))[$x_k$]
    content((-10.4, 0.55))[$x_V$]

    content((1, 4.55))[$y_1$]
    content((1, 4.05))[$y_2$]
    content((1, 3.55))[$y_3$]
    content((1, 2.05))[$y_k$]
    content((1, 0.55))[$y_V$]

    content((-9.75, 2.8))[$dots.v$]
    content((-9.75, 1.3))[$dots.v$]
    content((.25, 2.8))[$dots.v$]
    content((.25, 1.3))[$dots.v$]
    content((-4.75, 2.3))[$dots.v$]

    content((-5.35, 3.55))[$h_1$]
    content((-5.35, 3.05))[$h_2$]
    content((-5.35, 1.55))[$h_N$]

    line((-8, 3.5), (-7, 3), mark: (end: ">"))
    line((-8, 3), (-7, 3.5), mark: (end: ">"))
    content((-7.5, 2))[$W_(V times N)$]

    line((-3, 3.5), (-2, 3), mark: (end: ">"))
    line((-3, 3), (-2, 3.5), mark: (end: ">"))
    content((-2.5, 2))[$W'_(N times V)$]
  })
  
  ],
  caption: [Simple CBOW architecture which takes one word $x = A(w)$ as input. The word has the length $k$ but is padded to length $V$ to match the one-hot vector dimension  @karani2018introduction.])<cbow>