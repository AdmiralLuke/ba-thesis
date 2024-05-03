#import "template/parcio-bib.typ": parcio-bib
#import "template/template.typ": *

#show: project.with(
  "Comparative Analysis of Multimodal Emotion Detection Approaches",
  (name: "Lukas Eichel", mail: "lukas.eichel@ovgu.de"),
  include "chapters/abstract.typ",
  thesis-type: "Bachelor",
  reviewers: ("Prof. Dr. rer. nat. habil. Gunter Saake", "Dr.-Ing. David Broneske"),
  date: datetime(year: 2024, month: 09, day: 13),
)

#set page(margin: 2.5cm, footer: none)
#outline(depth: 3)

#set page(numbering: "1")
#counter(page).update(1)

// ----- ACTUAL CONTENT OF THESIS -----
#include "chapters/01_introduction/intro.typ"
#include "chapters/02_background/background.typ"
#pagebreak()
#pagebreak()

// This wrapper function adds backrefs.
// ToDo: remove full: true

#bibliography("bibliography/sources.bib", style: "ieee")


#pagebreak()
#pagebreak()

#include "chapters/appendix.typ"

#pagebreak()
#pagebreak()

#include "chapters/authorship.typ"