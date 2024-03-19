#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

#figure([
  
  #fletcher.diagram(
    cell-size: 60mm,
    node((0,0), "High-Level")
  )
  ],
  caption: [Information flows from both high to low to high in a system that can express, recognize and "have" emotions @GBV-233416889.])<em_arch>