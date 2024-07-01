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

    rect((-1, -3), (9, 3.5), stroke: (dash: "dashed", paint: silver.darken(20%)))

    rect((-0.5, -0.5), (1.5, 3), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
    rect((6.5, -0.5), (8.5, 3), fill: gray.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
    rect((2,-.5), (6, 3), fill: orange.lighten(80%), stroke:  (dash: "dashed", paint: silver.darken(20%), thickness: 0.5pt))
    
    content((0.5, 2.7), [#smallcaps("Input")])
    content((4, 2.7), [#smallcaps("Model")])
    content((7.45, 2.7), [#smallcaps("Output")])

    content((7.45, 1), [$vec(delim: "[", 0, 0, 0, 0, 0, 0, 1)$])
    arrow((0, 2), (1, 2))
    arrow((0.4, 2.2), (0.4, 0))
    cetz.decorations.wave(line((0.4,2), (0.4,0.3)), amplitude: .5, stroke: red)
    arrow((1, 1.1), (2.5, 1.1))

    content((1., 2.25), [#text(9pt)[Hz]], angle: 270deg)

    rect((2.5, -0.25), (3,2.25), fill: orange.lighten(60%))

    // rect((2.5, 0), (3.5, 2), fill: orange.lighten(60%))
    
    rect((5, -0.25), (5.5, 2.25), fill: orange.lighten(60%))

    rect((3.75, 0.5), (4.25, 1.5), fill: orange.lighten(60%))

    line((3, 2.25), (3.75, .5))
    line((3, 2.25), (3.75, 1.5))
    line((3, -.25), (3.75, .5))
    line((3, -.25), (3.75, 1.5))

    line((4.25, 1.5), (5, -.25))
    line((4.25, 1.5), (5, 2.25))
    line((4.25, .5), (5, -.25))
    line((4.25, .5), (5, 2.25))
    
    
    content((2.7,1), [Input Layer], angle: 90deg)
    content((5.2, 1), [Output Layer], angle: 90deg)
    arrow((5.5, 1.1), (7,1.1))

    rect((0.5, -1), (3, -2.5), fill: green.lighten(90%), stroke:  (dash: "dashed", paint: gray.darken(20%), thickness: 0.5pt))
    content((1.75, -1.7), [#smallcaps("   Feature \nExtraction")])
    arrowW((1.4, 1.1), (1.4, -1))
    arrowW((2.1, -1), (2.1, 1.1))
   }),
   caption: [Structural procedure for emotion classification in audio with a possible pre-training feature extraction.]
   
   )<fig-audio_flow>