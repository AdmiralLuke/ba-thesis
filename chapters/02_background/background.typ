#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Background
_This chapter will give an introduction and overview on different approaches to classify types of emotions with respect to their advantages and disadvantages. Furthermore it will explain the approaches to recognize emotion in the mediums text, video and audio. Based on this common implementation techniques and architectures for Neural Networks are presented._

== Emotion
There is no unambigious definition for the term 'emotion'. There are many different emotion, with different level of intensity. While asking what an emotion is and where it comes from, William James discussed two different theories about the origin of them. Either there are seperate ares in the cerebrum or else they correspond to motory and sensory processes @521f3a6c-4f3b-3b5e-9103-90f85a1045d0.
Many work in psychology add further aspects to the latter. In order to provide a framework, the following chapters will focus just on the outputted emotion and how to recognize it. 

#include "figures/emotion_arch.typ"


As shown in the figure, the motory and senory processes are considered as high-level information. This is defined as the semantic of the situation like the emotion state of the person, or an instruction to the computer to simulate a expression. The left side of the figure shows the latter.
However the right side explains that low-level expressive information, like a facial expression or a pitch change in the voice is needed to get the semantic of the emotional state. In addition there can be non-expressive data as a valid input. It describes the passive influence on a persons state like the weather or the setting of the environment. Most datasets won't cover this type of information. 

The mid-level patterns the given input and combines different low-level signals to get a better reasioning for an high-level output.
For example a slightly faster speech rate and a tense articulation can be clustered together to get classified as an angered expression.


=== Emotion Classification<chap211>
There are different apporaches to classify the semantic high-level features. The most popular classification is the basic-emotion framework by Paul Ekman @AppEmo describing six different emotions: anger, disgust, fear, surprise, sadness and hapiness. This arose from different facial expression, which Ekman categorized to the corresponding emotion.

Over the time different frameworks were built on this foundation to introduce for each basic emotion multiple detailled emotions. A common model is the Plutchik
wheel of emotion, which is commonly used to classify emotion in text. It offers eight types of basic emotion: joy, trust, fear, surprise and their opposites sadness, disgust, anger and anticipation @Kumar2022.

#figure(
  image("figures/pl_wheel.png", width: 250pt),
  caption: [Plutchik Wheel of Emotion @articleW.]
)

For each emotion there are multiple level of intensity. For example the enhanced level for disgust is loathing, a more moderate level is boredom. In total there are 24 different emotion. #todo(inline: true)[Why can it be better to have more emotion variety?]

Although there will be a loss of detail, the content of this thesis will focus on the basic emotion from Paul Ekman. The wheel of emotion from Plutchik is suitable for emotion detection in text but most datasets in facial emotion recognition are focused on Ekmans emotion theory #todo()[Why I wont use the Wheel of Emotion]. 

=== Emotion in Text

The most common approach to classify emotion from natural language text, is to cluster the content from these sentences. In order to make it possible, two assumptions are needed. 

1. There is a function that is able to map words and sentences to their corresponding emotion.

This can be approached by training a deep neural network with a suitable dataset or a clustering algorithm that measures the similarity between words and sentences to match their corresponding emotion label. The function must be surjective, so a token won't be able to be labeled with more than one emotion at the time.



For a relieable result in training, the second assumption is important.

2. Words and sentences do not change their meaning over time.

This is also the flaw from emotion detection in text. For example the sentence "I'm glad to be here"  

=== Emotion in Speech

#lorem(100)

#include "figures/speech_class.typ"

#lorem(100)

=== Emotion in Facial Expression

#lorem(100)

#todo(inline: true)[talk about the facs system]

== Attention in Deep Learning

=== Attention in Text 

=== Attention in Audio 

=== Attention in Video and Images

== Datasets