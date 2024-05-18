#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Background
This chapter will give an introduction and overview on different approaches to classify types of emotions with respect to their advantages and disadvantages. Furthermore it will explain the approaches and assumptions to recognize emotion in text, video and audio. Based on this common implementation techniques for supervised and unsupervised approaches are presented with a focus on convolution and transformer models since they are the leading architectures in deep learning. At the end, datasets are introduced which are the foundation for the later implementation and evaluation of the models.

== Emotion
There is no unambigious definition for the term 'emotion'. There are many different emotions, with different level of intensity. Considering the question of what an emotion is and where it comes from, William James discussed two different theories about the origin of them. Either there are seperate areas in the cerebrum or else they correspond to motory and sensory processes @521f3a6c-4f3b-3b5e-9103-90f85a1045d0. If they relie on the seperate areas, the research would be much easier. They could observate these regions while testing different actions and influences on the probants. The results should be quite similar between most people. However it is most likely the case, that emotion correspond to these motory and sensory processes. They will be different from human to human in intensity and execution, so researchers have to study the small similarieties and also the possible patterns and variations from the shown processes. In this case these factors and all brain activitys must be captured to set a prove for it. 
Many work in psychology add further aspects to the theory. In order to provide a framework, the following chapters will focus just on the given emotion and how to recognize it in written text, speech and facial expressions. These are the most common expressive features captured by emotion theorists, but there are many more like gestures or going into a medical direction the blood preassure and other factors might have an approach for determining the leading emotion.

In the other direction there are first approaches to simulate sentiments with computer or robots like animatronics. Learned patterns can be applied from a simple command to emotion features which are currently still very overacted.

@fig:em_arch presents that information like motory, sensory processes, their combination and the differentiation from semantic and syntatic context are categorized in high-level and low level information to process an emotion.

#include "figures/emotion_arch.typ"



High-level information are defined by the semantic of a situation which can be drawn from audiovisual processes for example the command "Show hatred". To show hate a certain emotional state has to be reached and must be reasoned by the situation. As a conclusion low-level information, for instance face expressions, gestures or other syntactic articulations can be observed from the person or system wich executes the given instruction. These patterns are analyized or learned and synthesized by the process before. 

On the other direction, these low-level expressive information can be combined to get the semantic of the emotional state. In addition there can be non-expressive data as a valid input. It describes the passive influence on a persons state like the weather or the setting of the environment. Most datasets won't cover this type of information. 

The mid-level builds patterns for the given input and combines different low-level signals to synthesize better reasioning for a high-level output.
For example a slightly faster speech rate and a tense articulation can be clustered together to get classified as an pleased look.


=== Emotion Classification<chap211>
There are different apporaches to classify the semantic high-level features. The most popular classification is the basic-emotion framework by Paul Ekman @AppEmo describing six different emotions: anger, disgust, fear, surprise, sadness and happiness. This arose from different facial expression, which Ekman categorized to the corresponding emotion.

Over the time different frameworks were built on this foundation to introduce for each basic emotion multiple detailled emotions. A common model is the Plutchik
wheel of emotion, which is commonly used to classify emotion in text. It offers eight types of basic emotion: joy, trust, fear, surprise and their opposites sadness, disgust, anger and anticipation @Kumar2022.


Visible in @fig:wheel_emo each emotion has multiple levels of intensity. For example, the enhanced level for disgust is loathing, a more moderate level is boredom. In total there are 24 different emotions. A variety of sentiments and their intensitys lead to a proper illustration of the real value.

#figure(
  scale(80%, reflow: true)[
  #image("figures/pl_wheel.png", width: 250pt)],
  caption: [Plutchik Wheel of Emotion @articleW.]
)<wheel_emo>

Although there will be a loss of detail, the content of this thesis will focus on the basic emotion from Paul Ekman. The wheel of emotion from Plutchik is suitable for emotion detection in text but most datasets in facial emotion recognition are focused on Ekmans emotion theory. As shown later in this thesis, many multimodal datasets relie on the work from Ekman. It is harder to distinguish all emotion from Plutchik in audio processing and face recognition. 

=== Emotion in Text

The most common approach to classify emotion from natural language text is to classify the semantic content from these sentences. In order to make it possible, two syntactical assumptions are needed. 

1. There is a function that is able to map words and sentences to their corresponding emotion.

2. Words and sentences do not change their meaning over time.

The first assumption can be approached by training a deep neural network with a suitable dataset or a clustering algorithm that measures the similarity between words and sentences to match their corresponding emotion label. The function must be surjective, so a token won't be able to be labeled with more than one emotion at the time.
The second assumptions is important for a relieable result in training but it is also the flaw from emotion detection in text. For example the sentence "I'm glad to be here".  Expressions like irony, emphasis in the voice or gestures can change the proper meaning of the sentence. It may can be interpreted as happiness or as disgust. To take this into consideration further observations of other expressive and non-expressive signals are needed.

=== Emotion in Speech<chap:emo_speech>

Emotion in audio is in contrast to the classification in text mainly focused on the syntax from the recording. The actual signal input is represented as a waveform and sinoid functions. A single wave is defined by


$ g(t) := A sin(2π(omega t - phi)) $

A complete waveform as presented in @fig:fig-waveform and @fig:fig-waveformB consists of many different sinoid functions which are added and concatinated together @muller2015fundamentals.  

#figure(
  image("figures/audio/audio_1.svg"),
  caption: [Waveform of the first seconds of a audio recording]
)<fig-waveform>

#figure(
  image("figures/audio/audio_2.svg"),
  caption: [Enlargement of the first half second from @fig:fig-waveform]
)<fig-waveformB>




*#smallcaps("Frequency")* ($omega$) measures the pitch from the audio and especially from the voice. As shown in @tbl:speech_features multiple features can be extracted from the frequency respectively the pitch. From a measured neutral foundation changes like an average pitch, the range or other changes can be observed. For example a person which speaks in a very much higher pitch, with a wide variablity in the range and changes the frequency aprupt on stressed syllables, then this person feels most likely anger.

*#smallcaps("Amplitude") ($A$)* shows the intensity and the loudness of the given audio. Furthermore it is also an important feature and easy to extract from speech with the help of an existing neutral foundation.

*#smallcaps("Phase") ($phi$)*  shifts $g(t)$ along the x-dimension. This parameter is not important in the feature measurement but has a significant role in audio decomposition which is described later.

Extracting features like speech rate, articulation or voice quality more observation is needed. Speech rate can be measured with words per second, sentences per minute or other similar metrics. Normally when looking at waveforms the intermissions betweens sentences or words can get retrieved. A higher rate is equivalent to more observed gaps in the same time of a normal speech speed. Articulation and voice quaility is hard to track without a semantic knowledge. Therefore a combination of the already presented features is needed which can be done by pattern matching and comparison to the neutral foundation. 




#include "figures/speech_class.typ"



=== Emotion in Facial Expression



#todo(inline: true)[talk about the facs system]

#pagebreak()

== Classification Approaches 

Over time many approaches to detect and classify emotion have been developed. There are severeral supervised architectures and unsupervised techniques which represent the current state of the art for emotion detection in text, audio and video. 

=== Classification in Text<class_text>

To classify emotions in text, several preprocessing is necessary due to the lack of numerical values. In the following some ideas for preprocessing are presented. Furhtermore, a look at the various classification methods will be taken. Here a special focus on the supervised methods is applied due to better comparability of already existing and pretrained deep learning models.

#section[Word Embedding and Tokenization]

The most important part of all classification approaches is called word embedding. It represents words as real-valued vectors @Wang_Wang_Chen_Wang_Kuo_2019. It shoud use syntactic but also the semantic meaning of the words to get a useful vector. This technique is commonly used in natural language processing like information retrieval in text. 

A naive approach to generate such an embedding function would be a one-hot vector encoding @karani2018introduction. It represents every word in a space as an different vector. For example the sentence:

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
    #grid( columns: (auto),
      tablex(
      header-rows: 4,
      header-columns: 2,
      columns: 8,
      align: center + horizon,
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [*$w_i in V$*], [*$A(w_i)$*], [*$w_i in V$*], [*$A(w_i)$*], [*$w_i in V$*], [*$A(w_i)$*], [*$w_i in V$*], [*$A(w_i)$*],
      [the], [$vec(1, 0, 0, 0)$],
      [tree], [$vec(0, 1, 0, 0)$],
      [is], [$vec(0, 0, 1, 0)$],
      [green], [$vec(0, 0, 0, 1)$],
      hlinex()
    )
    )
]

To measure the similarity the cosine similarity is often used @karani2018introduction @Li2018. Similar words or synonyms should have a smaller angle between each other, than unsimilar words. 

#align(center)[
  $#text[sim]\(w_1, w_2) = cos(theta) = frac(w_1 dot w_2, ||w_1|| ||w_2||)$
]

While the one-hot vector embeds it word by word only without any context, there won't be any similarity or dissimilarity between the words. This is also the reason why simple one-hot enocding is less used in practise. A semantic consideration will be more useful. 
#pagebreak()
*The #smallcaps[Continous Bag-of-Words Model]*, shortly CBOW is capable to take the context of a word as an input to calculate an embedded vector with emphasis on syntax and semantic. It consists of a neural network which mainly consists of three layers: the input layer, a hidden layer and the output layer @9673321. 

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


With unspuervised learning the model on the right of @cbow is able to generate a new vector which represents the context of a word. Now, under consideration of the cosine similarity, words with a similar context have a quite smaller angle compared to without any connection in semantics. In both architectures, the hidden layer acts like an arithmetic operator which combines the context to the outputted one-hot vector.


#grid(
  columns: (50%, 43%),
  column-gutter: 3em,
  include "figures/skip_gram.typ",
  [
    *The #smallcaps[Skip-Gram Model]* calculates an embedding in reverse from the idea of the CBOW-Model. 
    As the architecture shows in @fig:skipgram it tries to calculate the surrounding words with a given target term @rong2016word2vec. Therefore a training like the CBOW with contextual phrases is needed before it can work like a semantical decoder.
Both architectures are commonly used in different pre-trained word embedding networks, like Word2Vec from Google @mikolov2013efficient @7364114.
  ],)



*#smallcaps[Fast WordPiece Tokenization]* is an approach to tokenize sentences and words in an efficient way by splitting words into smaller subwords. It is used in a language understanding transformer model from Google which is called #smallcaps[Bert] @devlin2019bert.

The basic problem from other tokenization methods like the normal WordPiece Tokenization starts in the vocabulary tokenization in tries. Trie memory is a paradigma which is able to store strings efficiently where each edge of the data structure stores phonemes. Traversing a path consisting of multiple edges results in a word. As a result the structure does not have to store reduntant parts of words @tries.

The tokenization has to search for the longest token at a position. Therefore it starts from the shortest substring and iterates over the input text, while trie matching to match the longest prefix which matches a vocabulary token @song-etal-2021-fast. If the trie matching fails at the next character, the algorithm has to involve backtracking because the longest vocabulary token may be several characters back.
This results into a time complexity of $O(n m)$ where $m$ is the maximum vocabulary token length and $n$ the input length.

Fast WordPiece Tokenization introduces so called failure links and pops. Failure pops are a list of longest-matching prefix tokens of a node in the trie, which can be removed in order until a failure link node is reached. The failure node is able to represent the missing suffix. This whole algorithm called #smallcaps[LinMaxMatch] has a time complexity of only $O(n)$.

#section[Supervised Classification Approaches] 

With a given word embedding and tokenization supervised learning approaches are able to recognize emotion in text. Therefore an annotated dataset is needed, which has a relieable mapping from sentence or word to the corresponding emotion.

#include "figures/sup_basic.typ"

Most models are using the architecture paradigma shown in @fig:sup_basic . They mostly differ in the step of combining the feature vectors ant the type of classification because it offers the biggest room to maneuver.
A preprocessing and feature extraction is always necessary. Sometimes a WordNet @fellbaum2005encyclopedia is integrated to get a better overview about synonyms or to paraphrase words.

*#smallcaps[Convolutional and Recurrent Neural Networks] \(CNN/RNN)* are an effective approach on sentiment analysis of text @liu2020text. Convolution consists of a kernel-funciton which downscales the input but keeps the important features. This technique is called #smallcaps[Pooling] and brings several benefits like less memory usage, less overfitting in training and a faster computation time.
Herefore multiple words or sentences of the space $V$ are combined to region matrices. On each region $L$ convolutional filters are applied to lern local $n$-gram features. 

#figure(
  include "figures/conv.typ",
  caption: [Simple Convolution based Neural Network to predict an emotion from a given subset of sentences]
)<conv>

@fig:conv shows such network with the convolutional part. In common architectures multiple convolution and pooling layers are stacked together with an activation function like #smallcaps("ReLu") in between of each block which improves the output by setting constraints to the convolution outputs. The constraint which is effected by #smallcaps("ReLu") is the prohibition of negative values by the function $f(x) = max(0,x)$.  This subsequency of the convolution blocks leads to a hierarchical decomposition of the given embedded region matrix. As a result multiple features can be found from each block and each convolution kernel which might result in a higher accuracy. At the end an ordinary decoder in form of a simple linear layer with an activation function like #smallcaps("SoftMax") is utilized to calculate the resulting emotion from the pooled and flattened vector. Normalization like layer norm or batch norm between each layer can help to ensure better propagation and reduce numerical instability @NEURIPS2021_2578eb9c.

Another optimizations to fundamental neural network architectures are gating mechanisms from reccurent networks and the bi-directional flow in the model forwarding architectures. They introduce new types of storage cells which allows to store long term features @medsker1999recurrent. In the context of emotion detection in text, it might store important context from sentences and words before to differ between fill-words like "this", "with" and emotionally loaded words.
Commonly used are long short term memory cells (LSTM) @Graves2012 and gated recurrent units (GRU) @chung2014empirical which both try to prevent gradient vanishing which is a big problem in recurrent networks. It occurs while propagating backwards through time. Due to many multiplication steps, the gradient converges to 0. These two architectures differ mostly in their structure than in their functionality. Additionaly to the GRU cell, an LSTM has two more control gates which gives more possibilieys to constrain and rule the memory inside the structure. In both cases they can improve learning features from context and time series. 

*#smallcaps[Transormers]* are an deep-learning architecture which is based on multi-head attention. #linebreak(justify: true)  

#grid(
  column-gutter: 30pt,
  columns: (45%, auto),
  [
   #figure(
      gap: 60pt,
      scale(60%, reflow: true)[
        
      #include "figures/transformer.typ"],
      caption: [Common transformer model architecture with multi-head attention @vaswani2023attention.]
    )<transformer>

  ],
  [ 
    The basic idea of attention solves a huge bottleneck in common neural network architectures because fixed input vector sizes may result in a large overhead. In the example of natural language processing this could be a result from very large sentences. Attention mechanisms try to solve this issue by focusing the input on to specific parts e.g. training the input weights on important words or subsets from the given sentence. 

    The resulting transformers are currently setting a milestone in natural language processing and providing the fundaments for ChatGPT from OpenAI @openai2024gpt4 or other text understanding models, because of their scalability due to the attention mechanisms and their relieable results. @fig:transformer shows such a transformer architecture. An input sentence will be fed into the model where it first gets positional encoded thus the position and the frequency for every word in the sentence is stored.
  ]
  
)
Now the input vectors are passing through the first multi-head attention layer to lay the focus on important parts of the input. Neverless the actual input and the weighted part are added and normalized together which results in the original sentence but with tagged highlights due to the attention. To learn the features for the output token, the input traverses through a feed forward network which consists of basic uni-directional layers. Likewise the input and the output are matched together with a residual connection. The same proceding is repeated but with an autoregressive addition of already calculated output. But in contrast to the regular multi-head attention a masking in this process is introduced which sets the weight for unknown or respectively future tokens to negative values thus the model can learn realistic predictions only with already known tokens.
The output of the transformer architecture are probabilities for the next state. The already mentioned autoregressive implementation gives the possibilities to predict a long sequence of tokens.


In addition to the approaches with neural network architectures like transformers, other supervised methods like support vector machines, decision trees or naive bayes are used. These aren't covered in this thesis as it exceeds the scope of this work and are a possible part for future work.

In summary supervised methods follow the basic principle to learn features along a given target. Therefore enough training data is needed with the additional annotated labels. 

#pagebreak()

At the end even the differentiation between convolution, reccurent or transformer networks won't make any noticible changes in measurements if the architectures and models are large enough @smith2023convnets. In literature this "bitter lesson" @sutton2019bitter is researched step by step and also shown for language models, convolution nets and transformer.


"Scaling Laws for Neural Network" @kaplan2020scaling shows the improvement of the loss, when a model has many parameters, much computation time in training and a large dataset. Therefore this thesis will consider the transformer models as a focal point for later evaluation, because there are many large pretrained language models available which are able to recognize emotion and are trained and developed to satisfy almost all three factors. Language modeling performance improves smoothly as the model size, datasetset
size, and amount of compute used for training is increased. For optimal performance all three factors must be scaled
up in tandem.

#section[Unsupervised Classification Approaches]

Many datasets do not include annotated targets or subsets of the data can't be used as a prediction set. In unsupervised learning, the algorithms are trying to extract patterns from this data which are mostly similarities or differences in the training set. 

A common unsupervised approach in natural language processing for extracting keywords or similarieties from text is called #smallcaps("Latent Semantic Analysis").

*#smallcaps("Latent Semantic Analysis") (LSA)* @lsa is an information retrieval method in text based on singular value decomposition. 
The algorithm first transforms every word from a sentence into a matrix $M$.
This matrix can be dismantled into a diagonal matrix $S$ and two orthogonal matrices $U, V$ through


$ M =  U dot S dot V^T $


$S$ contains singular values which can be easily converted to eigenvalues. These are used to process a query on the vector space to find subsets of $M$ which fullfills the query by applying the cosine similarity. This whole method is quite expensive in computation time because of the necessary decomposition and dimension reductions @1102314.

There are many more unsupervised approaches for emotion detection and information retrieval in text @agrawal2012unsupervised @gollapalli2020ester but they won't be part of the following comparisons and benchmarks s
as they also exceed the scope of this thesis. Furthermore, no significant improves and diffferences are expectet in comparison to the presented unsupervised approaches and also the shown supervised classification methods due to the scaling laws for neural networks.


=== Classification in Audio 

Similar to classification in text as shown in @class_text there are some approaches to suppervised and unsupervised methods out there. First of all an encoding for the audio is necessary to ensure the extraction of the necessary features. 



#section[Fourier Transformation]

To break up the audio signal into multiple atomic sinoid functions, a fourier transformation and analysis can be applied. For each frequency $omega in RR$ from the given signal, the transformation yields a coefficient $d_omega$ and a phase $phi_omega$ from which a sinusodial oscillation can be retrieved. Looking back at the equation from @chap:emo_speech a normalization with regard to their amplitude is collected by assuming $A = sqrt(2)$. 

$ g(t) := A sin(2π(omega t - phi)) $

For each frequency and phase the normalized function $cos_(omega, phi)(t): RR -> RR$ is given by: 
$ cos_(omega, phi)(t) = sqrt(2) cos(2pi(omega t - phi)) $

Due to the idea of approximating the original audio function with sinoid waves, a first approach to the fourier transformation can be obtained by maximizing the similarity between both signals.

$ d_omega &:= max_(phi in [0,1)) &(integral_(t in RR) f(t) cos_(omega, phi)(t)d t) 
\
phi_omega &:= "argmax"_(phi in [0,1)) &(integral_(t in RR) f(t) cos_(omega, phi)(t)d t) $

Bringing this into the context with polar coordinates and the additional idea to store both values $d_w$ and $phi_omega$ into a single complex value. This results in the common fourier transformation form given by:

$ hat(f)(omega) &= integral_(t in RR) f(t)exp(-2pi i omega t)d t
\
&= integral_(t in RR)f(t)cos(-2 pi omega t) d t + i integral_(t in RR)f(t)sin(-2 pi omega t) d t  
$

These equations are however only suitable for non-discrete signal-processing and must be adaptet to adaptet to a discrete fourier transformation. A sampling period $T$ is introduced to sample the signal in mutiple time steps. An approximation for $hat(f)(omega)$ is obtained #linebreak(justify: true)

$ hat(f)(omega) approx sum_(n in ZZ) T(f(n T))exp(-2 pi i omega n) $

with a time complexity of $O(N^2)$ where $N$ notates the length from the given signal @muller2015fundamentals. 
#linebreak(justify: true)
Thus $N$ can get quite large some approvements are implemented. 
For example the fast fourier transformation with a complexity of $O(N log N)$, uses a divide and conquer algorithm to split the signal, calculates the fourier transformation and reassembles it @park2020fast.
Also common is the short time fourier transformation which divides the audio into windows with a given size $n$ and a hop size to determine the step size of the sliding window @muller2015fundamentals @durak2003short. #linebreak(justify: true) 


#section[Supervised Classification Approaches]
Analog to @class_text the supervised classification approaches follow the same structure. Recurrent- and convolution-based networks are the most common approach @wang2022learning @kong2020panns to classify features from audio, after retrieving the fourier representation for every signal and can also be applied to emotion. Continuing from the already presented fourier transformation and analysis, these supervised classification methods refer to the feature extraction from spectograms @COSTA201728 @spectograms which is the visual representation of the given signal and a lightweight implementation for these networks.

 Meanwhile the first transformer based audio classification are presented @verma2021audio. The idea is an amalgamation of the idea from convolution architectures and the common transformer model.

#grid(
  columns: (45%, auto),
  [
    #figure(
    [
    #include "figures/transformer_audio.typ"
    #move(dy: -25pt, dx: -5pt)[
      #image("figures/audio/audio_1.svg", width: 240pt)
    ]],
    gap: -15pt,
    caption: [Audio transformer model ])<fig:trans_audio>
  ],
  [
    Therefore it inputs the raw audio data without any preprocessing besides from padding to the right length. As shown in @fig:fig:trans_audio the model first divides the signal into multiple fix-length patches to feed them into a front-end layer. The patches describe very short sequences of the audio and show the resolution in which the work will subsequently be carried out. It consists of some dense layers which processes the raw audio to multiple feature vectors. These are suitable for learning in the common transformer architecture. These are chained together with average pooling layer, giving the convolution like downscaling and compressing effect. This step can be repeated multiple times until the required output shape is nearly matched. At the end a decoder layer in form of some dense layers are applied to predict the resulting label. Equivalent to the already introduced convolution networks, activation functions like ReLu or softmax can be interposed between all existing layers for more stability.
  ]
)


Nonetheless the bitter lesson from the previous chapter also applies here. Therefore and because of the already large scope of this thesis, further considerations about other supervised approaches like SVM or decision trees, are not made. #linebreak(justify: true) 

#section[Unsupervised Classification Approaches]

Unfortunatly unsupervised audio information retrieval approaches are quite rare. There are a few methods which uses k-means to learn from local audio features @wulfing2012unsupervised. Thus they are not really suitable for emotion detection due to their low capability of detecting global features.
But in spite of that there are some methods to collect local features which can assist the supervised deep learning method @unsupervisedmusic.

=== Classification in Images and Videos

#pagebreak()

== Datasets

For the multimodal analysis and the supervised approaches in learning a dataset consisting of at minimum video with audio is needed. From this state the text transcription can be retrieved during preprocessing. During this thesis, two different datasets are used which fulfill the requierments.
The following datasets are based on the Ekman emotion model with some changes.

*CREMA-D* (Crowd-sourced Emotional Multimodal Actors Dataset) @cao2014crema consists of 7.442 clips from 91 different actors with their facial and vocal expression. It covers every of Ekmans emotions: _Anger (ANG), Disgust (DIS), Fear (FEA), Happy (HAP), Neutral (NEU), Sad (SAD)_

with the exception of _surprise (SUP)_ , because it may can relate to any other emotion with a rapid onset. Additionaly there are a few annotation to the intensity of the sentiment, but it is only a small percentage regarding the amount of data. Therefore it wont't be used for futher evaluation in this thesis.

They recorded twelve different sentence for each type of emotion like "Don't forget a jacket." or "I wonder what this is about." which are semantically neutral connotated. These snippets are between 50 to 80 frames long while it is recorded in 30 frames per second.


#include "figures/cremad.typ"

As shown in @fig:cremad the distribution of labels is uniformly distributed with the exception of neutral. This won't leed to any problem, because the actual sentiments shown in the visuell data are very strongly acted so there are clear features available.

*MELD* (Multimodal EmotionLines Dataset) @poria2018meld is an annotated collection of short sequences from the series "Friends". In difference to the CREMA dataset or most other multimodal datasets for sentiment analysis like IEMOCAP @busso2008iemocap the given data has many multi-party conversation where there are more then one participant active and present in the most parts. This leads to a more complex and challenging feature extraction but approximates more closely the reality.

#include "figures/meld.typ"

@fig:meld shows the uneven distribution of the different sentiments, which can lead to an imbalanced training. Nevertheless it is a quite large dataset with 13.708 annotations which includes in addition to the emotion, the character as the speaking person which can be used to analyize the different features depending on gender or age. 

