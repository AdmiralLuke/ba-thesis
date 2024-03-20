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
    content((-9.8, 7.))[Input layer]
    content((-4.8, 7.))[Hidden layer]
    content((0.2, 7.))[Output layer]

    content((-10.5, 2.5))[$w_i$]
    content((-9.75, 4))[$dots.v$]
    content((-9.75, 1))[$dots.v$]
    content(((-10.75, -0.5)))[$w_i + n$]
    content((-10.75, 5.5))[$w_i - n$]

    
    // line((-10, 2.5), (.5, 2.5), stroke: red)
    rect((-10, 1.5), (-9.5, 3.5))

    // line((-10, 4), (.5, 4), stroke: red)
    // line((-10, 1), (.5, 1), stroke: red)

    rect((-10, 0.5), (-9.5, -1.5))
    rect((-10, 4.5), (-9.5, 6.5))
    

    line((-9.5, -1.5), (-5, 1))
    line((-9.5, .5), (-5, 4))

    line((-9.5, 1.5), (-5, 1))
    line((-9.5, 3.5), (-5, 4))

    line((-9.5, 4.5), (-5, 1))
    line((-9.5, 6.5), (-5, 4))

    // rect((-10, 0), (-9.5, 5))
    rect((-5, 1), (-4.5, 4))
    rect((0, 0), (0.5, 5))
    
    
    line((-4.5, 1), (0, 0))
    line((-4.5, 4), (0, 5))


    circle((-4.75, 3.5), radius: .2)
    circle((-4.75, 3), radius: .2)
    circle((-4.75, 1.5), radius: .2)

    circle((.25, 4.5), radius: .2)
    circle((.25, 4.0), radius: .2)
    circle((.25, 3.5), radius: .2)
    circle((.25, 2), radius: .2)
    circle((.25, 0.5), radius: .2)

    

    content((1, 4.55))[$y_1$]
    content((1, 4.05))[$y_2$]
    content((1, 3.55))[$y_3$]
    content((1, 2.05))[$y_k$]
    content((1, 0.55))[$y_V$]


    content((.25, 2.8))[$dots.v$]
    content((.25, 1.3))[$dots.v$]
    content((-4.75, 2.3))[$dots.v$]

    content((-5.35, 3.55))[$h_1$]
    content((-5.35, 3.05))[$h_2$]
    content((-5.35, 1.55))[$h_N$]

    line((-3, 3.5), (-2, 3), mark: (end: ">"))
    line((-3, 3), (-2, 3.5), mark: (end: ">"))
    content((-2.5, 2))[$W'_(N times V)$]

    content((-8.5, 2.5))[$W_(V times N)$]
    content((-8.5, 5))[$W_(V times N)$]
    content((-8.5, 0))[$W_(V times N)$]
  })
  
  ],
  caption: [CBOW architecture which takes word $w_i$ with $n$ words before and after as input. All words have size V @karani2018introduction.])<cbow_c>