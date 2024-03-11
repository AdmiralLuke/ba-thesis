#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Background
_This chapter will give an introduction and overview on different approaches to classify types of emotions with respect to their advantages and disadvantages. Furthermore it will explain the approaches to recognize emotion in the mediums text, video and audio. Based on this common implementation techniques and architectures for Neural Networks are presented._

== Emotion
There is no unambigious definition for the term 'emotion'. While asking what an emotion is and where it comes from, William James discussed two different theories about the origin of them. Either there are seperate ares in the cerebrum or else they correspond to motory and sensory processes @521f3a6c-4f3b-3b5e-9103-90f85a1045d0.
Many work in psychology add further aspects to the latter. In order to provide a framework, the following chapters will focus just on the outputted emotion and how to recognize it. 

#include "figures/emotion_arch.typ"


As shown in the figure, the motory and senory processes are considered as high-level information. This is defined as the semantic of the situation like the emotion state of the person, or an instruction to the computer to simulate a expression. The left side of the picture shows the latter.
However the right side explains that low-level expressive information, like a facial expression or a pitch change in the voice is needed to get the semantic of the emotional state. In addition there can be non-expressive data as a valid input. It describes the passive influence on a persons state like the weather or the setting of the environment. Most datasets won't cover this type of information. \
The mid-level patterns the given input and combines different low-level signals to get a better reasioning for the high-level output.
For example a slightly faster speech rate and a tense articulation can be clustered together to get classified as an angered expression.


=== Emotion Classification
There are different apporaches to classify the semantic high-level features. The most popular classification is the basic-emotion framework by Paul Ekman @AppEmo

=== Emotion in Text
=== Emotion in Speech

#include "figures/speech_class.typ"

=== Emotion in Facial Expression
#todo(inline: true)[talk about the facs system]

== Attention in Deep Learning