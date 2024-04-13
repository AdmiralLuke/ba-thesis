#import "../../../template/template.typ": *

#figure(

  grid(
    columns: (50%, 50%),
    [
      #image("meld/meld.png")
    ],
    [ 
      #v(20pt)
      #stack(
        [#image("meld/frame.png")],

        [
          #v(10pt)
          ``JOY: \"You are a genius.\" (Chandler)``
        ]

      )
    ]
  ),
  caption: [Distribution and example of the emotion presented by the MELD dataset]
)<meld>