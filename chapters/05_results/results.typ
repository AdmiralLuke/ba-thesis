#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Evaluation

== Setup

=== Precision Under Recall

== Results

#section("Unimodal Results")

#figure(
kind: table,
align(center)[
    #set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: (30%, 30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Model], [CREMA-D], [MELD],
      hlinex(),
      [Llama 3], [-], [34.87%],
      [Multi-EmoBert], [-], [],
      [T5], [-], [], 
      hlinex()
    )
],
caption: [Accuracy for unimodal emotion classification in text.]
)<fig-accs_text>

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: (30%, 30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Model], [CREMA-D], [MELD],
      hlinex(),
      [Convolution], [-], [30.57%],
      [Transformer], [], [], 
      hlinex()
    )
],
caption: [Accuracy for unimodal emotion classification in audio.]
)<fig-accs_audio>

