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
      rect((-1, -4), (13, 3.5), stroke: (dash: "dashed", paint: silver.darken(20%)))
      rect((-0.5, -0.5), (1.5, 3), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      rect((10.5, -0.5), (12.5, 3), fill: gray.lighten(90%), stroke:  (dash: "dashed",paint: gray.darken(20%), thickness: 0.5pt))
      rect((0, 0), (1, 2), fill: gray.lighten(70%), stroke: (paint: gray.lighten(50%)))
      
      
      rect((2,-.5), (10, 3), fill: orange.lighten(80%), stroke:  (dash: "dashed", paint: silver.darken(20%), thickness: 0.5pt))
      
      rect((11, 0), (12, 2), fill: gray.lighten(70%), stroke: (paint: gray.lighten(50%)))
      rect((3, -1), (9, -3.5), fill: blue.lighten(80%), stroke:  (dash: "dashed", paint: silver.darken(20%), thickness: 0.5pt))
      rect((2.5, 0), (3.5, 2), fill: orange.lighten(60%))
      line((3.5, 2), (4.5, -0.25), stroke: (dash: "dashed"))
      line((3.5, 2), (4.5, 2.25), stroke: (dash: "dashed"))
      line((3.5, 0), (4.5, -0.25), stroke: (dash: "dashed"))
      line((3.5, 0), (4.5, 2.25), stroke: (dash: "dashed"))
      
      rect((4.5, -0.25), (5,2.25), fill: orange.lighten(60%))

      arrow((1,1), (2.5, 1))

      rect((7, -0.25), (7.5, 2.25), fill: orange.lighten(60%))
      rect((8.5, 0), (9.5, 2), fill: orange.lighten(60%))
      line((7.5, 2.25), (8.5, 0), stroke: (dash: "dashed"))
      line((7.5, 2.25), (8.5, 2), stroke: (dash: "dashed"))
      line((7.5, -.25), (8.5, 0), stroke: (dash: "dashed"))
      line((7.5, -.25), (8.5, 2), stroke: (dash: "dashed"))
      line((5, 2.25), (5.75, .5))
      line((5, 2.25), (5.75, 1.5))
      line((5, -.25), (5.75, .5))
      line((5, -.25), (5.75, 1.5))
      rect((5.75, 0.5), (6.25, 1.5), fill: orange.lighten(60%))
      line((6.25, 1.5), (7, -.25))
      line((6.25, 1.5), (7, 2.25))
      line((6.25, .5), (7, -.25))
      line((6.25, .5), (7, 2.25))
      rect((3.5, -3.2), (5, -1.7), fill: blue.lighten(60%), stroke: (paint: blue.lighten(50%)))
      rect((6, -3.2), (8.5, -1.7), fill: blue.lighten(60%), stroke: (paint: blue.lighten(50%)))

      
      arrow((9.5, 1), (11,1))
      arrowW((6, -2.4), (5, -2.4))
      line((3.5, -2.4), (1.8, -2.4), stroke: (dash: "dashed"))
      arrowW((1.8, -2.4), (1.8, 1))

      line((6, -1.7), (2.5, 0), stroke: (dash: "dashed"))
      line((8.5, -1.7), (7.5, -.25), stroke: (dash: "dashed"))

      content((6, 2.7), [#smallcaps("Model-Architecture")])
      content((0.5, 2.7), [#smallcaps("Input")])
      content((11.5, 2.7), [#smallcaps("Output")])
      
      content((6, -1.3), t-rect(smallcaps("Context"), fill: blue.lighten(80%), inset: (y: 0pt)))
      content((0.5, 1), [#align(center)[#text(10pt)[I \ see \ that!]]])
      content((11.5, 1), [#text(9pt)[\[DIS\]]])
      content((4.25, -2.4), [#align(center)[NL \ Prompt]])
      content((3,1), [Encoder], angle: 90deg)
      content((4.7,1), [Input Layer], angle: 90deg)
      content((7.2, 1), [Output Layer], angle: 90deg)
      content((9, 1), [Decoder], angle: 90deg)
      content((7.2, -2.4), [#align(center)[Training \ Data]])

      // ---------------------

      rect((-1, -11), (9, -4.5), stroke: (dash: "dashed", paint: silver.darken(20%)))

      rect((-0.5, -8.5), (1.5, -5), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      rect((6.5, -8.5), (8.5, -5), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      rect((2, -8.5), (6, -5), fill: orange.lighten(80%), stroke:  (dash: "dashed", paint: silver.darken(20%), thickness: 0.5pt))
      
      content((0.5, -5.3), [#smallcaps("Input")])
      content((4, -5.3), [#smallcaps("Model")])
      content((7.45, -5.3), [#smallcaps("Output")])

      content((7.45, -7), [$vec(delim: "[", 0, 0, 0, 0, 0, 0, 1)$])
      arrow((0, -6), (1, -6))
      arrow((0.4, -5.8), (0.4, -8))
      cetz.decorations.wave(line((0.4,-6), (0.4,-7.7)), amplitude: .5, stroke: red)
      arrow((1, -6.9), (2.5, -6.9))

      content((1., -5.75), [#text(9pt)[Hz]], angle: 270deg)

      rect((2.5, -8.25), (3,-5.75), fill: orange.lighten(60%))

      // rect((2.5, 0), (3.5, 2), fill: orange.lighten(60%))
      
      rect((5, -8.25), (5.5, -5.75), fill: orange.lighten(60%))

      rect((3.75, -7.5), (4.25, -6.5), fill: orange.lighten(60%))

      line((3, -5.75), (3.75, .5 - 8))
      line((3, 2.25 - 8), (3.75, 1.5 - 8))
      line((3, -.25 - 8), (3.75, .5 - 8))
      line((3, -.25 - 8), (3.75, 1.5 - 8))

      line((4.25, 1.5 - 8), (5, -.25 - 8))
      line((4.25, 1.5 - 8), (5, 2.25 - 8))
      line((4.25, .5 - 8), (5, -.25 - 8))
      line((4.25, .5 - 8), (5, 2.25 - 8))
      
      
      content((2.7,1 - 8), [Input Layer], angle: 90deg)
      content((5.2, 1 - 8), [Output Layer], angle: 90deg)
      arrow((5.5, 1.1 - 8), (7,1.1 - 8))

      rect((0.5, -1 - 8), (3, -2.5 - 8), fill: green.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      content((1.75, -1.7 - 8), [#smallcaps("   Feature \nExtraction")])
      arrowW((1.4, 1.1 - 8), (1.4, -1 - 8))
      arrowW((2.1, -1 - 8), (2.1, 1.1- 8))

      // ------------------------

      rect((-1, -1 - 15), (12, 3.5 - 15), stroke: (dash: "dashed", paint: silver.darken(20%)))

      rect((-0.5, -0.5 - 15), (1.5, 3 - 15), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      rect((9.5, -0.5 - 15), (11.5, 3 - 15), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      rect((5,-.5 - 15), (9, 3 - 15), fill: orange.lighten(80%), stroke:  (dash: "dashed", paint: silver.darken(20%), thickness: 0.5pt))
      
      content((0.5, 2.7 - 15), [#smallcaps("Input")])
      content((7, 2.7 - 15), [#smallcaps("Model")])
      content((10.45, 2.7 - 15), [#smallcaps("Output")])

      content((10.45, 1 - 15), [$vec(delim: "[", 0, 0, 0, 0, 0, 0, 1)$])

      rect((-.2, .5 - 15), (1.2, 1.5 - 15), radius: 1.5pt, fill: gray.lighten(30%))    
      line((0.3, .7 - 15), (0.3, 1.3 - 15), (.8, 1 - 15), close: true, fill: white)


      rect((5.5, -0.25 - 15), (6,2.25 - 15), fill: orange.lighten(60%))

      // rect((2.5, 0), (3.5, 2), fill: orange.lighten(60%))
      
      rect((8, -0.25 - 15), (8.5, 2.25 - 15), fill: orange.lighten(60%))

      rect((6.75, 0.5 - 15), (7.25, 1.5 - 15), fill: orange.lighten(60%))

      line((6, 2.25 - 15), (6.75, .5 - 15))
      line((6, 2.25 - 15), (6.75, 1.5 - 15))
      line((6, -.25 - 15), (6.75, .5 - 15))
      line((6, -.25 - 15), (6.75, 1.5 - 15))

      line((7.25, 1.5 - 15), (8, -.25 - 15))
      line((7.25, 1.5 - 15), (8, 2.25 - 15))
      line((7.25, .5 - 15), (8, -.25 - 15))
      line((7.25, .5 - 15), (8, 2.25 - 15))
      
      
      content((5.7,1 - 15), [Input Layer], angle: 90deg)
      content((8.2, 1 - 15), [Output Layer], angle: 90deg)
      arrow((8.5, 1.1 - 15), (10,1.1 - 15))
      

      rect((2, .3 - 15), (4.5, 1.8 - 15), fill: green.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
      content((3.25, 0.9 - 15), [
        #align(center)[
          #smallcaps("Pre-") 
          #move(dy: -10pt)[
          #smallcaps("processing")]
      ]
      ])
      arrow((1.25, 1 - 15), (2 , 1 - 15))
      arrow((4.5, 1 - 15), (5.5, 1 - 15))
      
   }),
   caption: [Structural procedure for unimodal emotion classification.]
)<fig-all_flow>