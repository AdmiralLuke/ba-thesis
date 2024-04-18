#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Background#todo()[use more synonyms for "word"]
_This chapter will give an introduction and overview on different approaches to classify types of emotions with respect to their advantages and disadvantages. Furthermore it will explain the approaches to recognize emotion in the mediums text, video and audio. Based on this common implementation techniques and architectures for Neural Networks are presented._

== Emotion
There is no unambigious definition for the term 'emotion'. There are many different emotion, with different level of intensity. While asking what an emotion is and where it comes from, William James discussed two different theories about the origin of them. Either there are seperate ares in the cerebrum or else they correspond to motory and sensory processes @521f3a6c-4f3b-3b5e-9103-90f85a1045d0.
Many work in psychology add further aspects to the latter. In order to provide a framework, the following chapters will focus just on the outputted emotion and how to recognize it. 

#include "figures/emotion_arch.typ"


As shown in @fig:em_arch , the motory and senory processes are considered as high-level information. This is defined as the semantic of the situation like the emotion state of the person, or an instruction to the computer to simulate a expression. The left side of the figure shows the latter.
However the right side explains that low-level expressive information, like a facial expression or a pitch change in the voice is needed to get the semantic of the emotional state. In addition there can be non-expressive data as a valid input. It describes the passive influence on a persons state like the weather or the setting of the environment. Most datasets won't cover this type of information. 

The mid-level patterns the given input and combines different low-level signals to get a better reasioning for an high-level output.
For example a slightly faster speech rate and a tense articulation can be clustered together to get classified as an angered expression.


=== Emotion Classification<chap211>
There are different apporaches to classify the semantic high-level features. The most popular classification is the basic-emotion framework by Paul Ekman @AppEmo describing six different emotions: anger, disgust, fear, surprise, sadness and happiness. This arose from different facial expression, which Ekman categorized to the corresponding emotion.

Over the time different frameworks were built on this foundation to introduce for each basic emotion multiple detailled emotions. A common model is the Plutchik
wheel of emotion, which is commonly used to classify emotion in text. It offers eight types of basic emotion: joy, trust, fear, surprise and their opposites sadness, disgust, anger and anticipation @Kumar2022.

#figure(
  image("figures/pl_wheel.png", width: 250pt),
  caption: [Plutchik Wheel of Emotion @articleW.]
)<wheel_emo>

Visible in @fig:wheel_emo each emotion has multiple level of intensity. For example the enhanced level for disgust is loathing, a more moderate level is boredom. In total there are 24 different emotion. #todo(inline: true)[Why can it be better to have more emotion variety?]

Although there will be a loss of detail, the content of this thesis will focus on the basic emotion from Paul Ekman. The wheel of emotion from Plutchik is suitable for emotion detection in text but most datasets in facial emotion recognition are focused on Ekmans emotion theory #todo()[Why I wont use the Wheel of Emotion]. 

=== Emotion in Text

The most common approach to classify emotion from natural language text, is to cluster the content from these sentences. In order to make it possible, two assumptions are needed. 

1. There is a function that is able to map words and sentences to their corresponding emotion.

This can be approached by training a deep neural network with a suitable dataset or a clustering algorithm that measures the similarity between words and sentences to match their corresponding emotion label. The function must be surjective, so a token won't be able to be labeled with more than one emotion at the time.



For a relieable result in training, the second assumption is important.

2. Words and sentences do not change their meaning over time.

This is also the flaw from emotion detection in text. For example the sentence "I'm glad to be here"  

#todo(inline: true)[
  briefly explain irony which can lead to different meanings for the same sentence
]

=== Emotion in Speech

#todo(inline: true)[
  show different chanings in audio diagrams
]

#include "figures/speech_class.typ"



=== Emotion in Facial Expression



#todo(inline: true)[talk about the facs system]

#pagebreak()

== Classification Approaches 

Over time many approaches to detect and classify emotion has been developed. There are severeral supervised architectures and unsupervised techniques which represent the current state of the art for emotion detection in text, audio and video. 

=== Classification in Text

#section[Word Embedding and Tokenization]

The most important part of all classification approaches is called word embedding. It represents words as real-valued vectors @Wang_Wang_Chen_Wang_Kuo_2019. It uses syntactic but also the semantic meaning of the words to get a useful vector. This technique is commonly used in natural language processing like information retrieval in text.

To generate such an embedding function $A$, a one-hot vector @karani2018introduction is needed. It represents every word in a space of words as an different vector. For example the sentence:

#align(center)[
  _The tree is green._
]

will be first tokenized into a set of words $V$.

#align(center)[
  $V =  {$_the_, _tree_, _is_, _green_$}$  
]

The size of the set $|V| = 4$. As a result a mapping $w in V$ to a $|V|$-dimensional vector is needed.   

#align(center)[
  $A: V -> RR^(|V|)$
]

#figure(
  kind: table,
  caption: [Possible one-hot vector mapping for the sentence "The tree is green."],
)[
    #set text(hyphenate: false)
    #set par(justify: false)
    #grid( columns: (auto, auto),
      tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 2,
      align: center + horizon,
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [*$w_i in V$*], [*$A(w_i)$*],
      [the], [$vec(1, 0, 0, 0)$],
      [is], [$vec(0, 0, 1, 0)$],
      []
    ),
    tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 2,
      align: center + horizon,
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [*$w_i in V$*], [*$A(w_i)$*],
      [tree], [$vec(0, 1, 0, 0)$],
      [green], [$vec(0, 0, 0, 1)$],
      []
    )
    )
]

To measure the similarity the cosine similarity is often used @karani2018introduction @Li2018. Similar words or synonyms should have a smaller angle between each other, than unsimilar words. 

#align(center)[
  $#text[sim]\(w_1, w_2) = cos(theta) = frac(w_1 dot w_2, ||w_1|| ||w_2||)$
]

While the one-hot vector embeds it syntactically only, there won't be any similarity or dissimilarity between the words. Therefore a semantic consideration will be useful. 

*The #smallcaps[Continous Bag-of-Words Model]*, shortly CBOW is capable to take context of a word as an input to calculate an embedded vector with emphasis on syntax and semantic. It consists of a neural network which mainly constitutes of three layers: the input layer, a hidden layer and the output layer @9673321. 

\
#v(-3em)
#move(dy: -0em,)[
#figure(
  grid(columns: (25%, 10%, 25%),
    column-gutter: 4em,
    scale(60%)[
      #include "figures/cbow.typ"
    ],

    line(start: (0pt, 30pt), end: (0pt, 195pt))
    ,
    move(dx: 0pt, dy: -10pt)[
    #scale(60%)[
      #include "figures/cbow_c.typ"
    ]]
  ),
  gap: -2em,
  caption: [Left: Simple CBOW-architecture for a single word; Right: CBOW-architecture for multiple words. Words have length $k$ and are padded to size $V$ to match the dimension @karani2018introduction.]
)<cbow>
]

The architecture shown on the right side of @fig:cbow takes one one-hot vector $A(w_i)$ as an input expression. To get the context of the inputted term, phrases before and after are needed. Therefore an addition to the architecture is necessary.


With unspuervised learning the model on the right of @cbow is able to generate a new vector which represents the context of a word. Now, under consideration of the cosine similarity, words with a similar context have a quite smaller angle then without any connection in semantics. In both architectures, the hidden layer acts like an arithmetic operator which combines the context to the outputted one-hot vector.


#grid(
  columns: (50%, 43%),
  column-gutter: 3em,
  include "figures/skip_gram.typ",
  [
    *The #smallcaps[Skip-Gram Model]* calculates an embedding in reverse from the idea of the CBOW-Model. 
    As the architecture shows in @fig:skipgram it tries to calculate the surrounding words with a given target term. Therefore a training like the CBOW with contextual phrases is needed before it can work like a semantical decoder.
Both architectures are commonly used in different pre-trained word embedding networks, like Word2Vec from Google @mikolov2013efficient @7364114.
  ],)

#pagebreak()

*#smallcaps[Fast WordPiece Tokenization]* is an approach to tokenize sentences and words in an efficient way by splitting words into smaller subwords. It is used in a language understanding transformer model from Google which is called #smallcaps[Bert] @devlin2019bert.

The basic problem from other tokenization methods like the normal WordPiece Tokenization starts in the vocabulary tokenization in tries. Trie memory is a paradigma which is able to store strings efficiently where each edge of the data structure stores phonemes. Traversing a path consisting of multiple edges results in a word. As a result the structure does not have to store reduntant parts of words @tries.

The tokenization has to search for the longest token at a position. Therefore it starts from the shortest substring and iterates over the input text, while trie matching to match the longest prefix which matches a vocabulary token @song-etal-2021-fast. If the trie matching fails at the next character, the algorithm has to involve backtracking because the longest vocabulary token may be several characters back.
This results into a time complexity of $O(n m)$ where $m$ is the maximum vocabulary token length and $n$ the input length.

Fast WordPiece Tokenization introduces so called failure links and pops. Failure pops are a list of longest-matching prefix tokens of a node in the trie, which can be removed in order until a failure link node is reached. The failure node is able to represent the missing suffix. This whole algorithm called #smallcaps[LinMaxMatch] has a time complexity of only $O(n)$.

#section[Supervised Approaches] 

With a given word embedding and tokenization supervised learning approaches are able to recognize emotion in text. Therefore an annotated dataset is needed, which has a relieable mapping from sentence or word to the corresponding emotion.

#include "figures/sup_basic.typ"

Most models are using the architecture paradigma shown in @fig:sup_basic . They mostly differ in the step of combining the feature vectors ant the type of classification because it offers the biggest room to maneuver.
A preprocessing and feature extraction is always necessary. Sometimes a WordNet @fellbaum2005encyclopedia is integrated to get a better overview about synonyms or to paraphrase words.

*#smallcaps[Convolutional and Recurrent Neural Networks] \(CNN/RNN)* are an effective approach on sentiment analysis of text @liu2020text. Convulation consists of a kernel-funciton which downscales the input but keeps the important features. This technique is called #smallcaps[Pooling] and brings several benefits like less memory usage, less overfitting in training and a faster computation time.
Herefore multiple words or sentences of the space $V$ are combined to region matrices. On each region $L$ convolutional filters are applied to lern local $n$-gram features. 

#figure(
  include "figures/conv.typ",
  caption: [Simple Comvolution based Neural Network to predict an emotion from a given subset of sentences]
)<conv>

@fig:conv shows such network with the convolutional part. In common architectures multiple convolution and pooling layers are stacked together with an activation function in between of each block. This subsequency leads to a hierarchical decomposition of the given embedded region matrix. As a result multiple features can be found from each block and each convolution kernel which might result in an higher accuracy. At the end an ordinary decoder in form of a simple linear layer with an activation function like #smallcaps("SoftMax") is utilized to calculate the resulting emotion from the pooled and flattened vector. 


#todo(inline: true)[ToDo]


*#smallcaps[Transormers]*

#todo(inline: true)["Write about an Idea"]


#todo(inline: true)["SVM, ... Neben den neuronalen Netzen..."]

There are also some approaches with Naive-Bayes Networks like ...#todo[find some nb]. These aren't covered in this thesis and relay to future work.

#section[Unsupervised Approaches]

=== Classification in Audio 

=== Classification in Images and Videos

#pagebreak()

== Datasets

For the multimodal analysis and the supervised approaches in learning a dataset consisting of at minimum video with audio is needed. From this state the text transcription can be retrieved during preprocessing. During this thesis, two different datasets are used which fulfill the requierments.
The following datasets are based on the Ekman emotion model with some changes.

*CREMA-D* (Crowd-sourced Emotional Multimodal Actors Dataset) @cao2014crema consists of 7.442 clips from 91 different actors with their facial and vocal expression. It covers every of Ekmans emotions: _Anger (ANG), Disgust (DIS),Fear (FEA), Happy (HAP), Neutral (NEU), Sad (SAD)_

with the exception of _surprise (SUP)_ , because it may can relate to any other emotion with a rapid onset. Additionaly there are a few annotation to the intensity of the sentiment, but it is only a small percentage regarding the amount of data. Therefore it wont't be used for futher evaluation in this thesis.

They recorded twelve different sentence for each type of emotion like "Don't forget a jacket." or "I wonder what this is about." which are semantically neutral connotated. This snippets are between 50 to 80 frames long while it is recorded in 30 frames per second.


#include "figures/cremad.typ"

As shown in @cremad the distribution of labels uniformly distributed with the exception of neutral. This won't leed to any problem, because the actual sentiments shown in the visuell data are very strongly acted so there are clear features available.

*MELD* (Multimodal EmotionLines Dataset) @poria2018meld is a annotated collection of short sequences from the series "Friends". In difference to the CREMA dataset or most other multimodal datasets for sentiment analysis like IEMOCAP @busso2008iemocap the given data has many multi-party conversation where there are more then one participant active and present in the most parts. This leeds to a more complex and challenging feature extraction but approximates more closely the reality.

#include "figures/meld.typ"

@meld shows the uneven distribution of the different sentiments, which can lead to an imbalanced training. Nevertheless it is a quite large dataset with 13.708 annotations which includes in addition to the emotion, the character as the speaking person which can be used to analyize the different features depending on gender or age. 