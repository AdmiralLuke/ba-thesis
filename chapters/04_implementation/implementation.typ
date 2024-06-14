#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Design and Implementation

The following chaper focus on the implementation of the different supervised model architectures for each modal. This will be done for the presented datasets MELD and CREMA-D which are both challenging different aspects of emotion detection. Furthermore the important preprocessing and feature extraction for each model are described. At least the bimodal and unimodal combination are implemented showing different types of feature combination or voting and scoring methods.   


== Unimodal Text Classification

As described in @class_text transformer models are quite suitable for text classifcation. Thus they need some sort of word embedding for preprocessing. Fortunatly already existing Large Language Models are capeable to process text as normal conversation input for giving a mostly correct answer to the prompted sentences. Also the most common models are also pretrained on very large datasets for example paper from scientific websites or collections of sources and articles like Wikipedia. Thus needing some adapations to the used datasets in this work, the following three leading pretrained networks are used for measurement and classifcation. #linebreak(justify: true)

*#smallcaps("Llama3")* @metaIntroducingMeta developed by Meta presents a generative deep-learning modal based transfomers. It consists of over 128 thousand known vocabularys from open sources in the internet. With more than four billion parameters it reaches and its well preprocessed dataset they show relieable results in text conversations.

*#smallcaps("Multi-EmoBERT")* @li2023multi was originally applied to detect fake news with the support of emotion classifcation. Thus it is more an architecture than a pretrained model, bringing the possibility to train and finetune the BERT with own text data.

#section[Preprocessing and Prompt Engineering for LLM]

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

