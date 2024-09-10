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

#set page(numbering: "1", footer: context {
  if calc.odd(counter(page).get().first()) {
    align(right, counter(page).display("1"))
  } else {
    align(left, counter(page).display("1"))
  }
})
#counter(page).update(1)

#empty-page

// ----- ACTUAL CONTENT OF THESIS -----
#include "chapters/01_introduction/intro.typ"
#include "chapters/02_background/background.typ"
#include "chapters/03_related_work/related_work.typ"
#include "chapters/04_implementation/implementation.typ"
#empty-page
#include "chapters/05_results/results.typ"
#empty-page
#include "chapters/06_evaluation/evaluation.typ"
#include "chapters/07_further_work/further_work.typ"

#empty-page
#empty-page

// This wrapper function adds backrefs.
// ToDo: remove full: true

// #bibliography("bibliography/sources.bib", style: "ieee")

#bibliography("bibliography/sources.bib", style: "bibliography/ieee-no-et-al.csl")


// #pagebreak()
// #pagebreak()

// #include "chapters/appendix.typ"

#pagebreak()
#pagebreak()

#include "chapters/authorship.typ"