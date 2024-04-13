#import "../../../template/template.typ": *

#figure(

  grid(
    columns: (50%, 50%),
    [
      #image("cremad/cremad.png")
    ],
    [ 
      #v(35pt)
      #stack(
        grid(
          columns: (33%, 33%, 33%),
          column-gutter: 10pt,
          [
            #image("cremad/01.png")
          ],
          [
            #image("cremad/02.png")
          ],
          [
            #image("cremad/03.png")
          ]
        ),
        [
          #v(10pt)
          ``FEA: \"It's eleven o'clock.\"``
        ]

      )
    ]
  ),
  caption: [Distribution and example of the emotion presented by the CREMA dataset]
)<cremad>