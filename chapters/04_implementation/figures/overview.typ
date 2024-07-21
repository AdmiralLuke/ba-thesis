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

#figure(
  scale(90%)[
  #diagram(
    spacing: 8pt,
    cell-size: (8mm, 10mm),
    edge-stroke: 1pt,
    edge-corner-radius: 5pt,
    mark-scale: 70%,
    debug: 0,
    node-stroke: 1pt,
    node((-1.5,1.2), [Video], height: 25pt, corner-radius: 1pt, width: 50pt),
    edge("-|>"),
    node((0,1.2), [Video Detection], corner-radius: 2pt, extrude: (0, 3), width: 100pt, height: 30pt),
    node((-1.5,0), [Audio], height: 25pt, corner-radius: 1pt, width: 50pt),
    edge("-|>"),
    
    node((0,0), [Audio Detection], corner-radius: 2pt, extrude: (0, 3), width: 100pt, height: 30pt),
    node((-1.5,-1.2), [Text], height: 25pt, corner-radius: 1pt, width: 50pt),
    edge("-|>"),
    node((0,-1.2), [Text Detection], corner-radius: 2pt, extrude: (0, 3), width: 100pt, height: 30pt),
    edge((0, -1.2), (2.5,0), "-|>"),
    edge((0, 0), (2.5, 0), "-|>"),
    edge((0, 1.2), (2.5, 0), "-|>"), 
    node((2.5, 0), [Multimodal \ Fusion], height: 60pt, corner-radius: 3pt, extrude: (0, 3)),
    edge("-|>"),
    node((4.3,0), [Output], corner-radius: 10pt)

    
)],
caption: [Pipeline for multimodal emotion detection.]
)<fig-imp_overview>