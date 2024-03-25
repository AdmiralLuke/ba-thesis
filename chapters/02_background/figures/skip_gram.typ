#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond
#import "@preview/cetz:0.2.2"

#figure(scale(65%, reflow: true)[
  #cetz.canvas({
  import cetz.draw: *
    content((-9.8, 7.))[Input layer]
    content((-4.8, 7.))[Hidden layer]
    content((0.2, 7.))[Output layer]

    content((-10.5 + 11.5, 2.5))[$w_i$]
    content((-9.75 + 10, 4))[$dots.v$]
    content((-9.75 + 10, 1))[$dots.v$]
    content(((-10.75 + 12, -0.5)))[$w_i + n$]
    content((-10.75 + 12, 5.5))[$w_i - n$]

    
    
    rect((-10 + 10, 1.5), (-9.5 + 10, 3.5))

    // line((-10, 2.5), (.5, 2.5), stroke: red)
    // line((-10, 4), (.5, 4), stroke: red)
    // line((-10, 1), (.5, 1), stroke: red)

    rect((-10 + 10, 0.5), (-9.5 + 10, -1.5))
    rect((-10 + 10, 4.5), (-9.5 + 10, 6.5))
    

    
    line((-4.5, 1), (0, -1.5))
    line((0, .5), (-4.5, 4))

    line((0, 1.5), (-4.5, 1))
    line((0, 3.5), (-4.5, 4))

    line((-0, 4.5), (-4.5, 1))
    line((-0, 6.5), (-4.5, 4))

    // rect((-10, 0), (-9.5, 5))
    rect((-5, 1), (-4.5, 4))
    rect((0 - 10, 0), (0.5 - 10, 5))
    
    
    line((-5, 1), (-9.5, 0))
    line((-5, 4), (-9.5, 5))


    circle((-4.75, 3.5), radius: .2)
    circle((-4.75, 3), radius: .2)
    circle((-4.75, 1.5), radius: .2)

    circle((.25 - 10, 4.5), radius: .2)
    circle((.25 - 10, 4.0), radius: .2)
    circle((.25 - 10, 3.5), radius: .2)
    circle((.25 - 10, 2), radius: .2)
    circle((.25 - 10, 0.5), radius: .2)

    

    content((1 - 11.5, 4.55))[$x_1$]
    content((1 - 11.5, 4.05))[$x_2$]
    content((1 - 11.5, 3.55))[$x_3$]
    content((1 - 11.5, 2.05))[$x_k$]
    content((1 - 11.5, 0.55))[$x_V$]


    content((.25 - 10, 2.8))[$dots.v$]
    content((.25 - 10, 1.3))[$dots.v$]
    content((-4.75, 2.3))[$dots.v$]

    content((-5.35, 3.55))[$h_1$]
    content((-5.35, 3.05))[$h_2$]
    content((-5.35, 1.55))[$h_N$]

    line((-8, 3.5), (-7, 3), mark: (end: ">"))
    line((-8, 3), (-7, 3.5), mark: (end: ">"))
    content((-7.5, 2))[$W'_(V times N)$]

    content((-1.5, 2.5))[$W_(N times V)$]
    content((-1.5, 5))[$W_(N times V)$]
    content((-1.5, 0))[$W_(N times V)$]
  })
  ],
  gap: .9em,
  caption: [Skip-Gram Model. All words have size V (after padding) @mikolov2013efficient.],
  /*placement: bottom,*/)<skipgram>