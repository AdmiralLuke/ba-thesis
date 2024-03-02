#let _cite-pages(cc) = locate(
  loc => {
    let cite-group = (:)
    let citations = query(ref, loc).filter(r => r.has("citation") and r.element == none)
     
    for c in citations {
      if str(c.target) not in cite-group.keys() {
        cite-group.insert(str(c.target), (c.location(),))
      } else {
        cite-group.at(str(c.target)).push(c.location())
      }
    }
    
    let locs = cite-group.at(str(cc.target)).map(l => link(l, str(counter(page).at(l).first()))).dedup(key: l => l.body)
    
    text(rgb("#606060"))[
      #if locs.len() == 1 [
        (Cited on page #locs.first())
      ] else if locs.len() == 2 [
        (Cited on pages #locs.at(0) and #locs.at(1))
      ] else [
        #let loc-str = locs.join(", ", last: " and ")
        (Cited on pages #loc-str)
      ]
    ]
  },
)

#let parcio-bib(bib) = {
  show grid: g => locate(
    loc => {
      let bib-dict = yaml.decode(read("../" + bib.path.first()))
      let citations = query(ref, loc).filter(r => r.has("citation") and r.element == none).dedup(key: x => x.target).sorted(key: x => {
        let authors = if type(bib-dict.at(str(x.target)).author) == str {
          lower(bib-dict.at(str(x.target)).author)
        } else {
          lower(bib-dict.at(str(x.target)).author.join(","))
        }
        
        authors
      })
      
      for (i, c) in g.children.enumerate() [
        #if calc.odd(i) {
          c + " " + box(_cite-pages(citations.at(int(i / 2)))) + v(0.25em)
        } else {
          c
        }
      ]
    },
  )
  
  bib
}

