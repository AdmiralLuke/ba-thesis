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
    node((0,0), [Video-File \ 1280px x 720px], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node((1.6, 0), [Face \ Detection], corner-radius: 1pt, height: 50pt),
    edge("-|>"),
    node((3.6, 0), [Active \ Speaker \ Recognition], corner-radius: 1pt, height: 50pt),
    edge((3.6,0), (3.6 ,0), `for all faces`, "--|>", bend: 130deg),
    edge("-|>"),
    node((5.3, 0), [Crop on \ Face], corner-radius: 1pt, height: 50pt),
    edge("-|>"),
    node((6.9, 0), [Downscale \ and \ Resize], corner-radius: 1pt, height: 50pt),
    edge("-|>"),
    node((8.1,0), [Video-File \ 200px x 200px], corner-radius: 2pt, extrude: (0, 3)),
)],
caption: [Preprocessing pipeline for videos.]
)<fig-audio_preprocessing>