#import "../../../template/template.typ": *
#import "@preview/algorithmic:0.1.0"
#import algorithmic: algorithm


```python
def choose_emotion(P, th):
    L = [ ] # list for output

    # loop through every possibility
    for e in P: 
          if P[e] >= th: # if matches the threshold
               L.append(e)

    # if none of the emotions reaches the threshold
    if  L.is_empty(): 
          return ["neutral"]
    return L
```