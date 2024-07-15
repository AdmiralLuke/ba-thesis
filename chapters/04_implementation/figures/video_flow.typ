#import "../../../template/template.typ": *


#import "@preview/cetz:0.2.2"

#let t-rect = rect

#figure(
   cetz.canvas({
    import cetz.draw: *
    let arrow(start, end) = {
        line(start, end, mark: (end: ">"))
      }
    let arrowW(start, end) = {
      line(start, end, mark: (end: ">"), stroke: (dash: "dashed"))
    }

    rect((-1, -1), (12, 3.5), stroke: (dash: "dashed", paint: silver.darken(20%)))

    rect((-0.5, -0.5), (1.5, 3), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
    rect((9.5, -0.5), (11.5, 3), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
    rect((5,-.5), (9, 3), fill: orange.lighten(80%), stroke:  (dash: "dashed", paint: silver.darken(20%), thickness: 0.5pt))
    
    content((0.5, 2.7), [#smallcaps("Input")])
    content((7, 2.7), [#smallcaps("Model")])
    content((10.45, 2.7), [#smallcaps("Output")])

    content((10.45, 1), [$vec(delim: "[", 0, 0, 0, 0, 0, 0, 1)$])

    rect((-.2, .5), (1.2, 1.5), radius: 1.5pt, fill: gray.lighten(30%))    
    line((0.3, .7), (0.3, 1.3), (.8, 1), close: true, fill: white)


    rect((5.5, -0.25), (6,2.25), fill: orange.lighten(60%))

    // rect((2.5, 0), (3.5, 2), fill: orange.lighten(60%))
    
    rect((8, -0.25), (8.5, 2.25), fill: orange.lighten(60%))

    rect((6.75, 0.5), (7.25, 1.5), fill: orange.lighten(60%))

    line((6, 2.25), (6.75, .5))
    line((6, 2.25), (6.75, 1.5))
    line((6, -.25), (6.75, .5))
    line((6, -.25), (6.75, 1.5))

    line((7.25, 1.5), (8, -.25))
    line((7.25, 1.5), (8, 2.25))
    line((7.25, .5), (8, -.25))
    line((7.25, .5), (8, 2.25))
    
    
    content((5.7,1), [Input Layer], angle: 90deg)
    content((8.2, 1), [Output Layer], angle: 90deg)
    arrow((8.5, 1.1), (10,1.1))
    

    rect((2, .3), (4.5, 1.8), fill: green.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
    content((3.25, 0.9), [
      #align(center)[
        #smallcaps("Pre-") 
        #move(dy: -10pt)[
        #smallcaps("processing")]
    ]
    ])
    arrow((1.25, 1), (2 , 1))
    arrow((4.5, 1), (5.5, 1))
   }),
   caption: [Structural procedure for emotion classification in video.]
   
   )<fig-video_flow>