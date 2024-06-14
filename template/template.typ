#import "@preview/drafting:0.1.1": margin-note, set-page-properties
#import "@preview/i-figured:0.2.4"
#import "@preview/tablex:0.0.8": *

#let ovgu-blue = rgb("#0068B4")
#let ovgu-darkgray = rgb("#606060")
#let ovgu-lightgray = rgb("#C0C0C0")
#let ovgu-orange = rgb("#F39100")
#let ovgu-purple = rgb("#7A003F")
#let ovgu-red = rgb("#D13F58")

#let large = 14.4pt
#let Large = 17.28pt
#let LARGE = 20.74pt
#let huge = 24.88pt

// TODO box (default: no inline).
#let todo(inline: false, body) = if inline {
  rect(
    fill: ovgu-orange,
    stroke: black + 0.5pt,
    radius: 0.25em,
    width: 100%,
    body,
  )
} else {
  set rect(fill: ovgu-orange)
  margin-note(stroke: ovgu-orange, body)
}

// Like \section* (unnumbered level 2 heading, does not appear in ToC).
#let section = heading.with(level: 2, outlined: false, numbering: none)
// Small inline heading.
#let inline-section(title) = smallcaps[*#text(font: "Libertinus Sans", title)*] 

// ----------------------
//   CUSTOM PARCIO TABLE
//  (uses tablex & nested tables)
// ----------------------
#let parcio-table(columns, rows, ..tablec) = {
  let header-data = tablec.pos().slice(0, columns)
  let rest = tablec.pos().slice(columns)
  
  table(
    columns: 1,
    stroke: none,
    style(
      styles => {
        let header = table(columns: columns, rows: 1, stroke: 0.5pt, align: center, ..header-data)
        let hw = measure(header, styles).width / columns
        
        header
        v(-1em)
        tablex(
          columns: (hw,) * columns,
          rows: rows - 1,
          stroke: 0.5pt,
          align: (x, y) =>
          (left, center, right).at(x),
          auto-hlines: false,
          hlinex(),
          ..rest,
          hlinex(),
        )
      },
    ),
  )
}

// ----------------------
//   ACTUAL TEMPLATE
// ----------------------
#let project(
  title,
  author,
  abstract,
  thesis-type: "Bachelor/Master",
  reviewers: (),
  date: datetime.today(),
  body,
) = {
  set document(title: title, author: author.name)
  set page("a4", margin: 2.5cm, number-align: right, numbering: "i", footer: [])
  set text(font: "Libertinus Serif", 12pt, lang: "en")
  set heading(numbering: "1.1.")
  set par(justify: true)
  set math.equation(numbering: "(1)")
  
  // Make URLs use monospaced font.
  show link: l => {
    if type(l.dest) == "string" {
      set text(font: "Inconsolata", 12pt * 0.95)
      l
    } else {
      l
    }
  }
  
  
  show figure: i-figured.show-figure.with(numbering: "1.1")
  show figure: f => {
    counter(figure.where(kind: "sub")).update(0)
    f
  }
  
  show figure: set block(spacing: 1.5em)
  
  // Add final period after fig-numbering (1.1 -> 1.1.).
  show figure.caption: c => {
    if c.kind != "sub" {
      grid(
        columns: 2,
        column-gutter: 4pt,
        align(top)[#c.supplement #c.counter.display(c.numbering).#c.separator],
        align(left, c.body),
      )
    } else {
      c
    }
  }
  
  // Create the "Chapter X." heading for every level 1 heading that is numbered.
  // Also resets figure counters so they stay chapter-specific.
  show heading.where(level: 1): h => {
    set text(huge)
    if h.numbering != none {
      pagebreak(weak: true)
      v(2.3cm)

      i-figured.reset-counters(h, return-orig-heading: false)
      if h.body == [Appendix] {
        counter(heading.where(level: 1)).update(1)
        [Appendix #counter(heading.where(level: 1)).display(h.numbering)]
      } else {
        [Chapter ] + counter(heading.where(level: 1)).display()
      }
      [\ #v(0.2em) #h.body]
    } else {
      v(2.3cm)
      h
    }
  }

  // show heading: i-figured.reset-counters
  
  show heading.where(level: 2): h => {
    if h.numbering != none {
      [#counter(heading).display()~~#h.body]
    } else {
      h
    }
  }
  
  // Make @heading automatically say "Chapter XYZ" instead of "Section XYZ",
  // unless we want to manually specify it.
  set ref(supplement: it => {
    if it.func() == heading {
      "Chapter"
    } else {
      it.supplement
    }
  })
  
  // Customize ToC to look like template.
  set outline(fill: repeat[~~.], indent: none)
  show outline: o => {
    show heading: pad.with(bottom: 1em)
    o
  }
  
  // Level 2 and deeper.
  show outline.entry: it => {
    let cc = it.body.children.first().text
    
    box(
      grid(
        columns: (auto, 1fr, auto),
        h(1.5em + ((it.level - 2) * 2.5em)) + link(it.element.location())[#cc#h(1em)#it.element.body],
        it.fill,
        box(width: 1.5em) + it.page,
      ),
    )
  }
  
  // Level 1 chapters get bold and no dots.
  show outline.entry.where(level: 1): it => {
    set text(font: "Libertinus Sans")
    let cc = if it.element.body == [Appendix] {
      "A." // hotfix
    } else if it.body.has("children") {
      it.body.children.first()
    } else {
      h(-0.5em)
    }
    
    v(0.1em)
    box(grid(
      columns: (auto, 1fr, auto),
      strong(link(it.element.location())[#cc #h(0.5em) #it.element.body]),
      h(1fr),
      strong(it.page),
    ))
  }
  
  // Applies a similar theme with the ovgu colors using the tmTheme format.
  // It is very limited; using Typst's own highlighting might be more expressive.
  set raw(syntaxes: ("clir.sublime-syntax", "arm.sublime-syntax"))
  show raw: set text(font: "Inconsolata")
  
  show raw.where(block: true): r => {
    set par(justify: false)
    show raw.line: l => {
      box(table(
        columns: (-1.25em, 100%),
        stroke: 0pt,
        inset: 0em,
        column-gutter: 1em,
        align: (x, y) => if x == 0 { right } else { left },
        text(fill: ovgu-darkgray, str(l.number)),
        l.body,
      ))
    }
    
    set align(left)
    rect(width: 100%, stroke: gray + 0.5pt, inset: 0.75em, r)
  }
  
  // TODO (make better): Custom subfigure counter ((a), (b), ...).
  show figure.where(kind: "sub"): f => {
    f.body
    v(-0.65em)
    counter(figure.where(kind: "sub")).display("(a)") + " " + f.caption
  }
  
  show heading: set text(font: "Libertinus Sans", Large)
  show heading: it => it + v(1em)
  
  set footnote.entry(separator: line(length: 40%, stroke: 0.5pt))
  set list(marker: (sym.bullet, "◦"))
  
  // STYLIZING TITLE PAGE AND ABSTRACT BEGINS HERE:
  // Can't import pdf yet (svg works).
  align(center)[
    #image(alt: "Blue OVGU logo", width: 90%, "Signet_FIN_3.svg")
    #text(Large, font: "Libertinus Serif")[Otto-von-Guericke-University Magdeburg] \ \
    #text(Large, font: "Libertinus Serif")[*Faculty of Computer Science*] \ \
    Department of Databases and Software Engineering
  ]
  
  v(2.75em)
  
  align(
    center,
  )[
    #text(huge, font: "Libertinus Serif")[
      #set par(justify: false)
      #title
    ]
    #v(2.5em)
    #text(LARGE, font: "Libertinus Sans")[
      *#thesis-type Thesis*
    ]
    #v(1.25em)
    
    Author: 
    #set text(LARGE)
    #show raw: set text(large * 0.95)
    #align(
      center,
    )[
      #author.name\
      #v(0.75em, weak: true)
    ]
    

    #v(3.35em)
    
    // first and second reviewer are required, supervisor is optional.
    #if reviewers.len() >= 2 {
      let first-reviewer = reviewers.first()
      let second-reviewer = reviewers.at(1)
      let supervisor = reviewers.at(2, default: none)
      
      [ 
        #align(center)[
        #text(12pt)[Examiner:] \
        #first-reviewer\ \
        #v(-1.5em)
        
        #text(12pt)[2nd Examiner and Supervisor:] \
        #second-reviewer\ \
        #v(-1.5em)
        
        #if supervisor != none [
          Supervisor:\
          #supervisor
        ]
        ]
      ]
    }

    #v(1.35em)
    #text(12pt)[
      Magdeburg, #date.display("[day].[month].[year]")
    ]
  ]
  
  show raw: set text(12pt * 0.95)
  pagebreak(to: "odd")
  set-page-properties(margin-left: 2.5cm, margin-right: 2.75cm)
  
  v(-8.5em)
  align(center + horizon)[
    #text(font: "Libertinus Sans", [*Abstract*])\ \
    #align(left, abstract)
  ]
  
  pagebreak()
  pagebreak()
  body
}