#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

#figure([
  #rect(inset: 0.7em)[
  #fletcher.diagram(
    debug: 0,
    cell-size: 60mm,
    node((0,0), "High-Level"),
    edge((0,0), "d", "<|-|>"),
    node((0, 1), "Low-Level"),
    node((0.54, 0.05), "\"Show hatred\""),
    node((1.065, 0.05), "\"Joe looks pleased\""),
    node((0.84, 0.3), "Reasoning and decision making", stroke: 0.5pt, width: 15.8em),
    edge((0.54, 0.1), (0.54, 0.25), "-|>"),
    edge((1.065, 0.1), (1.065, 0.3), "<|-"),

    node((0.84, 0.55), "Pattern analysis and synthesis", stroke: 0.5pt, width: 15.8em),

    node((0.54, 0.814), "Expressive \n   Signals"),
    node((1.065, 0.85), "Expressive and \nNon-expressive\n       Signals"),

    edge((0.54, 0.35), (0.54, 0.5), "-|>"),
    edge((1.065, 0.35), (1.065, 0.5), "<|-"),

    edge((0.54, 0.5), (0.54, 0.85), "-|>"),
    edge((1.065, 0.5), (1.065, 0.85), "<|-"),

    node((1.72, 0.43),"Emotional\n    state", shape: diamond, stroke: 0.5pt, height: 6em, width: 5em),

    edge((1.274, 0.55), (1.7, 0.55), "<|-|>"),
    edge((1.2, 0.3), (1.7, 0.3), "<|-|>")
  )
  ]
  ],
  caption: [Information flows from both high to low to high in a system that can express, recognize and "have" emotions @GBV-233416889.])<em_arch>