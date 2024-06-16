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

@fig:fig-text_flow shows sequence of the processing which can be adapted to the three shown transformer models. However as mentioned it is a bit more complicated with the Multi-EmoBert model due to its need to get trained on the specific datasets.

Starting with the finetuned T5-model there is not much room for any preprocessing or further optimizations. Also in addition to the flowchart in @fig:fig-text_flow some kind of prompt engineering or data injection is not easily possible without the need to retrain the whole model regarding the lack of training data from the original used dataset.   

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

