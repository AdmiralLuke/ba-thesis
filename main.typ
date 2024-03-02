#import "template/parcio-bib.typ": parcio-bib
#import "template/template.typ": *

#show: project.with(
  "TBD",
  (name: "Lukas Eichel", mail: "lukas.eichel@ovgu.de"),
  include "chapters/abstract.typ",
  thesis-type: "Bachelor",
  reviewers: ("Prof. Dr. rer. nat. habil. Gunter Saake", "Dr. David Broneske"),
  date: datetime(year: 2024, month: 07, day: 31),
)

#set page(margin: 2.5cm, footer: none)
#outline(depth: 3)

#set page(numbering: "1")
#counter(page).update(1)

// ----- ACTUAL CONTENT OF THESIS -----

#pagebreak()
#pagebreak()

// This wrapper function adds backrefs.
#parcio-bib(
  bibliography("bibliography/report.yml", style: "bibliography/apalike.csl"),
)

#pagebreak()
#pagebreak()

#include "chapters/appendix.typ"

#pagebreak()
#pagebreak()

#include "chapters/authorship.typ"