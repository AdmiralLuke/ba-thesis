#import "../../../template/template.typ": *
#import "@preview/algorithmic:0.1.0"
#import algorithmic: algorithm


```python
# Define initial task
message = [
     {
          'role': 'user'
          'message': "Giving the following seven emotion..."
     }
]

# Context generation
for sentence, emotion in train_set:
     message.append(
          {
              'role': 'user',
              'content': sentence + " " + emotion + "\n"
          })

# test the data with a copy of the context
for sentence, emotion in test_set:
      prompt = message.copy().append(
          {
            'role': 'user'
            'content': "The prompt is: " + sentence 
          })

     response = ollama.chat(model='llama3', messages=prompt) # results
```