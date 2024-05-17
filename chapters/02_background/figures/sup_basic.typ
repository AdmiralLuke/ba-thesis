#import "../../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond


#let xnode(pos, label, ..args) = {
    node(pos, align(center, label), width: 10em, height: 5em, ..args)
}

#figure(
  fletcher.diagram(
    cell-size: 60mm,
    xnode((0,0), "Input",  stroke: 0.5pt, height: 7em, corner-radius: 5pt, width: 5em),
    edge("-|>"),
    xnode((0.5,0), "Preprocessing\n(Tokenization, ...)", stroke: 0.5pt, height: 5em, corner-radius: 5pt, width: 10em),
    edge("-|>"),
    xnode((0.5,0.4), "Feature Extraction\n(Word Embedding, ...)", stroke: 0.5pt, height: 5em, corner-radius: 5pt, width: 10em),
    edge("-|>"),
    xnode((1.15, 0.4), "Feature Vector\nCombination", stroke: 0.5pt, height: 5em, corner-radius: 5pt, width: 10em),
    edge("-|>"),
    xnode((1.15, 0), "Classification", stroke: 0.5pt, height: 5em, corner-radius: 5pt, width: 10em),
    edge("-|>"),
    xnode((1.65,0), "Emotion\nOutput",  stroke: 0.5pt, height: 7em, corner-radius: 5pt, width: 5em),
  ),
  caption: [Deep Learning Assisted Semantic Text Analysis]
)<sup_basic>