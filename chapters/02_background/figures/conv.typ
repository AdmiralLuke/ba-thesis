#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond
#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *
  let draw_grid(start, rows, cols, size) = {
      rect(start, (cols * size + start.at(0) , rows * size + start.at(1)), fill: white)

      for j in range(0, int(cols) ) {
        for i in range(0, int(rows)) {
          line((start.at(0), i * size + start.at(1)), (size * cols + start.at(0), i * size + start.at(1)))
        }
        line((j * size + start.at(0) ,start.at(1)), (j * size + start.at(0), size * rows + start.at(1)))
      }
      
  }

  rect(
        (-0.55, -1.5),
        (8.2, 4.),
        fill: rgb("#D0CEE2"),
        stroke: (dash: "dashed", paint: gray.darken(50%), thickness: 0.5pt),
  )


  content((3.85, 3.7), [#smallcaps("Convolution")])


  rect(
        (-3.5, -1.5),
        (-0.5, 4.),
        fill: gray.lighten(70%),
        stroke: (dash: "dashed", paint: gray.darken(50%), thickness: 0.5pt),
  )


  content((-1.95, 3.7), [#align(center)[#smallcaps("Input")]])
  

  rect(
        (13.2, -1.5),
        (8.2, 4.),
        fill: orange.lighten(70%),
        stroke: (dash: "dashed", paint: gray.darken(50%), thickness: 0.5pt),
  )

  content((10.8, 3.7), [#align(center)[#smallcaps("Linear Layer")]])

  content((-2, -1), [*Input: $s in V$*])

  content((-2, 1.3), "\"The\n  tree\n  is\n  green...\"")
  
  line((-1, 1.3), (-.2, 1.3), mark: (end: ">"))

  draw_grid((0,0), 5, 4, 0.45)
  draw_grid((0.25, 0.25), 5, 4, 0.45)
  draw_grid((0.5, 0.5), 5, 4, 0.45)

  content((1.35, -1), [*Region Matrices*])

 

  draw_grid((3.5, 0.65), 4, 3, 0.45)
  draw_grid((3.7, 0.4), 4, 3, 0.45)
  draw_grid((3.9, 0.15), 4, 3, 0.45)

  line((2.3, 2.75), (3.5, 2.45))
  line((2.3, 0.5), (3.9, 0.15))
  line((1.8, 0), (3.5, .65))
  line((2.3, 2.1), (3.9, 1.95))


  draw_grid((6.3, 0.4), 4, 3, 0.45)


  line((4.85, 2.45), (6.3, 2.2))
  line((5.25, 0.15), (6.3, 0.4))

  content((4.6, -1), [*Convolution*])
  content((7.05, -1), [*Pooling*])

  line((7.8, 1.3), (8.6, 1.3), mark: (end: ">"))

  draw_grid((8.8, -.2), 12, 1, 0.25)

  content((9, -1), [*Flatten*])

  draw_grid((10, 0.15), 5, 1, 0.45)

  line((9.05, -.2), (10, 0.15))
  line((9.05, 2.8), (10, 2.4))

  line((10.8, 1.3), (11.6, 1.3), mark: (end: ">"))

  content((12.3, 1.3), [[NEU]])

  content((12.3, -1), [*Output*])

})

#v(1em)