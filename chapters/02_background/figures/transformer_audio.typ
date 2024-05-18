#import "../../../template/template.typ": *
#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *

  let arrow(start, end) = {
    line(start, end, mark: (end: ">"))
  }

  let arrow_armee(start, end, count, gap) = {
    for i in range(0, count) {
      arrow((start.at(0) + (i * gap), start.at(1)), (end.at(0) + (i * gap), end.at(1)))
    }
  }

  content((3.5, 10.6), [Output Label])
  arrow((3.5, 10), (3.5, 10.4))

  rect((1.7, 9.5), (5.3, 10))
  arrow((3.5, 9), (3.5, 9.5))
  content((3.5, 9.75), [Dense Layer])

  // 2end transformer

  rect((1.5, 8), (5.5, 9), radius: .1, fill: red.lighten(80%))
  arrow_armee((1.7, 7.5), (1.7, 8), 10, 0.4)
  content((3.5,8.5),text[#align(center)[Transformer]] )

  // avg pooling

  line((1, 6.5), (6,6.5))
  line((1.5, 7.5), (5.5, 7.5))
  line((1, 6.5), (1.5, 7.5))
  line((5.5, 7.5), (6, 6.5))
  arrow_armee((1.1,6), (1.1,6.5), 17, 0.3)
  content((3.5, 7), text[#align(center)[Average Pooling]])

  // first transformer layer

  rect((1, 5), (6, 6), radius: .1, fill: red.lighten(80%))
  arrow_armee((1.1,4.5), (1.1,5), 17, 0.3)
  content((3.5,5.5),text[#align(center)[Transformer]] )

  // front end
  content((3.5, 3.8), text[#align(center)[Front End + \ Patches]])
  line((1,4.5), (6, 4.5))
  line((0,3), (1, 4.5))
  line((7,3), (6,4.5))
  line((0,3), (7,3))
  

  // arrows ebene 1

  arrow_armee((0.5, 2), (0.5, 3), 13, 0.5)

})