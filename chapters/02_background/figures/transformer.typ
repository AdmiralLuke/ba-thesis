#import "../../../template/template.typ": *

#import "@preview/fletcher:0.4.4" as fletcher: diagram, node, edge
#import fletcher.shapes: house, hexagon
#set text(font: "Fira Sans")

#let blob(pos, label, tint: white, ..args) = node(
  pos, align(center, label),
  width: 27mm,
  fill: tint.lighten(80%),
  stroke: 1.5pt + black,
  corner-radius: 2pt,
  ..args,
)

#diagram(
  spacing: 8pt,
  cell-size: (8mm, 10mm),
  edge-stroke: 1pt,
  edge-corner-radius: 5pt,
  mark-scale: 70%,
  debug: 0,

  node(enclose: ((0.3, -3), (1.5, -7)), fill: gray.lighten(70%), stroke: 1.5pt + black.lighten(20%), corner-radius: 5pt, inset: 5pt),
  node((0.2, -4.7), text(gray.darken(60%))[Nx]),
  node((3.8, -4.9), text(gray.darken(60%))[Nx]),
  node(enclose: ((3.25, -3), (3.5, -9.7)), fill: gray.lighten(70%), stroke: 1.5pt + black.lighten(20%), corner-radius: 5pt),

  node((1, 0), [#text(gray.darken(60%))[Inputs]]),
  edge("-|>"),
  blob((1, -1), [Input \ Embedding], tint: red),
  edge("-|>"),
  node((1, -1.9), [+] , radius: 0.5em, stroke: 1pt),
  edge((1, -1.9), (0, -1.9), "-"),
  node((0.05, -1.9), [Positional \ Encoding]),
  edge((1, -2), (1, -3.4), "-|>"),
  edge((1, -2.6), (0.8, -2.6), (0.8, -3.4), "-|>"),
  edge((1, -2.6), (1.3, -2.6), (1.3, -3.4), "-|>"),
  
  blob((1, -3.5), [Multi-Head \ Attention], tint: orange),
  edge("-"),
  blob((1, -4.4), [Add & Norm], tint: yellow),
  edge((1, -2.5), (0.3, -2.5), (0.3, -4.4), (0.7, -4.4), "-|>"),
  edge("-|>"),
  blob((1, -5.8), [Feed \ Forward], tint: blue),
  edge("-"),
  blob((1, -6.7), [Add & Norm], tint: yellow),
  edge((1, -5), (0.3, -5), (0.3, -6.7), (1, -6.7), "-|>"),



  node((3, 0), [#text(gray.darken(60%))[#align(center)[Output \ (shifted right)]]]),
  edge("-|>"),
  blob((3, -1), [Output \ Embedding]), 
  edge("-|>"),
  node((3, -1.9), [+] , radius: 0.5em, stroke: 1pt),
  edge((3, -1.9), (4, -1.9), "-"),
  node((3.95, -1.9), [Positional \ Encoding]),
  edge((3, -2), (3, -3.4), "-|>"),
  edge((3, -2.6), (2.7, -2.6), (2.7, -3.4), "-|>"),
  edge((3, -2.6), (3.2, -2.6), (3.2, -3.4), "-|>"),
  
  blob((3, -3.7), [Masked \ Multi-Head \ Attention], tint: orange),
  edge("-"),
  blob((3, -4.7), [Add & Norm], tint: yellow),
  edge((3, -2.5), (3.7, -2.5), (3.7, -4.7), (3, -4.7), "-|>"),
  edge((3, -5), (3, -5.4), (3.2, -5.4), (3.2, -6),"-|>"),
  edge((1, -7), (1, -7.3), (2, -7.3), (2, -5.5), (3, -5.5), (3, -6), "-|>"),
  edge((1, -7), (1, -7.3), (2, -7.3), (2, -5.5), (2.7, -5.5), (2.7, -6), "-|>"),

  edge((3, -5.2), (3.7, -5.2), (3.7, -7.4), (3.3, -7.4), "-|>"),

  blob((3, -6.5), [Multi-Head \ Attention], tint: orange),
  edge("-"),
  blob((3, -7.4), [Add & Norm], tint: yellow),

  edge("-|>"),

  blob((3, -8.5), [Feed \ Forward], tint: blue),
  edge("-"),
  blob((3, -9.4), [Add & Norm], tint: yellow),
  edge((3, -7.75), (3.7, -7.75), (3.7, -9.4), (3, -9.4), "-|>"),
  edge("-|>"),
  blob((3, -10.5), [Linear], tint: purple.lighten(30%)),
  edge("-|>"),
  blob((3, -11.5), [Softmax], tint: green.darken(30%)),
  edge("-|>"),
  node((3, -12.5), [Output \ Probabilities]),

  

)

