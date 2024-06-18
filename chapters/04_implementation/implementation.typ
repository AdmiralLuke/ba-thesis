#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Design and Implementation

The following chaper focus on the implementation of the different supervised model architectures for each modal. This will be done for the presented datasets MELD and CREMA-D which are both challenging different aspects of emotion detection. Furthermore the important preprocessing and feature extraction for each model are described. At least the bimodal and unimodal combination are implemented showing different types of feature combination or voting and scoring methods.   


== Unimodal Text Classification

As described in @class_text transformer models are quite suitable for text classifcation. Thus they need some sort of word embedding for preprocessing. Fortunatly already existing Large Language Models are capeable to process text as normal conversation input for giving a mostly correct answer to the prompted sentences. Also the most common models are also pretrained on very large datasets for example paper from scientific websites or collections of sources and articles like Wikipedia. Thus needing some adapations to the used datasets in this work, the following three leading pretrained networks are used for measurement and classifcation.  #linebreak(justify: true)

*#smallcaps("Llama3")* @metaIntroducingMeta developed by Meta presents a generative deep-learning modal based transfomers. It consists of over 128 thousand known vocabularys from open sources in the internet. With more than four billion parameters it reaches and its well preprocessed dataset they show relieable results in text conversations. As a natural language understanding model similar to ChatGPT or other similar Llama provides contextual understanding in a chat like conversation with the user. In contrast to the most big architectures, Meta decided to publish their model open source with all the pretrained weights and different interfaces to run the product locally. 

*#smallcaps("Multi-EmoBERT")* @li2023multi was originally applied to detect fake news with the support of emotion classifcation. Thus it is more an architecture than a pretrained model, bringing the possibility to train and finetune the architecture with own text data. As already briefly explained in the background of text preprocessing BERT shows an bidirectional encoder with an underlying transformer developed by Google in 2018. The multiemotion aspect gives multiple labels and their probabilities for a given input leading into a higher variety and more options to choose the correct label. 

*#smallcaps("T5 Model")* @raffel2023exploring is a text based transformer model which settles on text-to-text transfer learning, following the idea from Llama 3 and equivalent also trained on open source crawled data from the internet. The advantage to the already presented architectures and implementations is an already given finetuning on sentiment and emotion detection reducing the effort for necessary preprocessing but also giving less degress of fredoom for manual training on the datasets or some kind prompt engineering as Llama is offering. 

#section[Preprocessing and Prompt Engineering for LLM]

Fortunatly all of the three given models are implementing an own language understanding system. Therefore it is not necessary to implement and train an own word embedding network. Mostly they relie on some variants from bag-of-words to encode the vocabulary tokens.

#include "figures/text_flow.typ"

@fig:fig-text_flow shows sequence of the processing which can be adapted to the three shown transformer models. In all three cases the models consists of an encoder and decoder layer for the text-to-text understanding and their specific transformer based architectures to give them their expected user-oriented functionalities. Thus just input a sentence to retrieve the emotion label won't work well in the most cases due to the attemp to imitate real-world conversations. Looking at the results for the input sentence "I see that!" the models are showing the following responses:
#set list(indent: 2em)
#grid(
  columns: 2,
  gutter: 1em,
  [- *LLama3:*], [I'm glad I could share the excitement with you! It's always thrilling to spot a clever joke or play on words. If
you're ready for more, I've got a few more where that came from!],
  [- *Multi-EmoBERT:*], [lorem upsmu],
  [- *T5-Model*:], [lorem ipsum]
) // further train for T5 is possible https://huggingface.co/docs/transformers/model_doc/t5

Llamas respones shows the conversation like answer leading to the need of some finetuning. Fortunatly the model has contextual memory which can be used to predefine a task with natural language for the architecture. In this case the chore with an example for better understanding is given and repeated after every prompt to refresh the contextual memory. Further as shown in @fig:fig-text_flow the train data can be embedded in the progression of the conversation to give the model a higher overwiev over the given data which can lead to an higher accuracy. A possible prompt which is used later for the evalation is: 

"Giving the following seven emotion with their abbrevation: Anger (ANG), Disgust (DIS), Fear (FEA), Surprise (SUP), Sadness (SAD), Happiness (HAP), Neutral (NEU). I\'ll prompt you a sentence and you will answer with the corresponding emotion abbrevation. For example I\'ll ask: "My day is awesome" and you\'re answer would be "[HAP]". Don\'t forget the brackets. Sentences, or questions like "okay" or "lets go" are also sentences where you have to guess the emotion. Alright?" 

Whis this task the model outputs a more sensible answer in the right format for the same example sentence. This prompt can be changed slightly to feed in the contextual information about the training data without much effort. However as mentioned it is a bit more complicated with the Multi-EmoBert and T5 model due to the lack of any context based chat functionality. Looking back at @fig:fig-text_flow there are possibilitys to train the architectures in particular the encoder and the weigts on top of their pretrained values with an own set of data. This opens up the opportunity to finetune the models and enhance the results. 

 

== Unimodal Audio Classification

#section[Preprocessing and Feature Extraction]

#section[Model Architectures]

== Unimodal Video Classification

#section[Preprocessing Methods] 

#section[Model Architectures]


== Bimodal Classification

#section[Scoring Methods]

#section[Feature Combination Methods]

== Trimodal Classification

#section[Architecture]

