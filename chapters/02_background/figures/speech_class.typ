#import "../../../template/template.typ": *
#import "../../../packages/diagbox.typ": *

#figure(
  kind: table,
  caption: [Features of an audio with correlating emotion @GBV-233416889 @MURRAY2008107.],
)[
    #set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: 6,
      align: center + horizon,
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 or y == 1 {(top: 1pt)} else if y == 7 {(bottom: 1pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      bdiagbox(width: 6.275em, inset: 0.65em, line_stroke: silver.darken(10%) )[*Feature*][*Emotion*], [*Fear*], [*Anger*], [*Sadness*], [*Happiness*], [*Disgust*],
      [*Speech Rate*], [much faster], [slightly faster], [slightly slower], [faster or slower], [very much slower],
      [*Pitch Average*], [very much higher], [very much higher], [slightly lower], [much higher], [very much lower],
      [*Pitch Range*], [much wider], [much wider], [slightly narrower], [much wider], [slightly wider],
      [*Intensity*], [normal], [higher], [lower], [higher], [lower],
      [*Voice Quality*], [irregular voicing], [breathy chest tone], [resonant], [breathy blaring], [grubled chest tone], 
      [*Pitch Changes*], [normal], [abrupt on stressed syllables], [downward inflections], [smooth upward inflections], [wide downward terminal inflections],
      [*Articulation*], [precise], [tense], [slurring], [normal], [normal],
    )
]<speech_features>


/*

| **Intensity** | normal | higher | lower | higher | lower |
| **Voice Quality** | irregular voicing | breathy chest tone | resonant | breathy blaring | grumbled chest tone |
| **Pitch changes** | normal | abrupt on stressed syllables | downward inflections | smooth upward inflections | wide downward terminal inflections |
| **Articulation** | precise | tense | slurring | normal | normal |  

*/