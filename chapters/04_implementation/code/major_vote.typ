#import "../../../template/template.typ": *
#import "@preview/algorithmic:0.1.0"
#import algorithmic: algorithm


```python
def major_vote(L: list[int | float | str]) -> int | float | str:
    d = { } # dictionary for counting the elements
    for i, e in enumerate(L):
        if not e in d:
            d.update({e: 1})
        else:
            d[e] += 1
     # sort by value, highest value at pos 0
     return sorted(d, key= d.get, reverse=True)[0]
```