#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import "@preview/subpar:0.1.0"
#import fletcher.shapes: diamond

= Background
This chapter will give an introduction and overview on different approaches to classify types of emotions with respect to their advantages and disadvantages. Furthermore, it will explain the approaches and assumptions to recognize emotion in text, video and audio. Based on this, common implementation techniques for supervised and unsupervised approaches are presented with a focus on convolution and transformer models as they are the leading architectures in deep learning. At the end, datasets are introduced which represent the foundation for the later implementation and evaluation of the models.

== Emotion
There is no unambigious definition for the term 'emotion'. There are many different emotions, with different levels of intensity. Considering the question of what an emotion is and where it comes from, William James discussed two different theories about their origins. Either there are separate areas in the cerebrum or else they correspond to motory and sensory processes @521f3a6c-4f3b-3b5e-9103-90f85a1045d0. If they originate from the separate areas, the research would be much easier. They could obsere these regions while testing different actions and influences on the test subjects. The results should be quite similar between most people. However, it is most likely the case, that emotions correspond to these motory and sensory processes. They will differ from human to human in intensity and execution, so researchers have to study the small similarities and, additionally, the possible patterns and variations from the shown processes. In this case these factors and all brain activities must be captured to start more research in this topic. 
Many works in psychology add further aspects to the theory. In order to provide a framework, the following chapters will focus just on the given emotion and how to recognize it in written text, speech and facial expressions. These are the most common expressive features captured by emotion theorists, but there are many more like gestures or when looking at the medical field. Blood pressure and other factors might have an approach for determining the leading emotion as well.

On the other hand there have been first approaches to simulate sentiments with computers or robot-like animatronics. Learned patterns can be applied from a simple command to emotion features which are currently still very overacted.

@fig:em_arch presents aforementioned information such as motory, sensory processes, their combination and the differentiation from semantic and syntatic context. They are categorized in high-level and low level information to process an emotion.

#include "figures/emotion_arch.typ"


High-level information is defined by the semantic of a situation which can be drawn from audiovisual processes, for example, the command "Show hatred". To show hate, a certain emotional state has to be reached and must be reasoned by the situation. As a conclusion low-level information, for instance, face expressions, gestures or other syntactic articulations can be observed from the person or system wich executes the given instruction. Before, these patterns are analyzed or learned and synthesized by the process. 

On the other hand, these low-level expressive information can be combined to get the semantic of the emotional state. In addition there can be non-expressive data as valid input. It describes the passive influence on a persons state like the weather or the environmental conditions. Most datasets will not cover this type of information. 

The mid-level builds patterns for the given input and combines different low-level signals to synthesize better reasoning for a high-level output.
For example a slightly faster speech rate and a tense articulation can be clustered together to get classified as a pleased look.


=== Emotion Classification<chap211>
Several apporaches to classify the semantic high-level features have been developed over time. The most popular classification is the basic-emotion framework by Paul Ekman @AppEmo describing six different emotions: anger, disgust, fear, surprise, sadness and happiness. These arose from various facial expressions, which Ekman categorized to the corresponding emotion.

Over time, diverse frameworks were built on this foundation to introduce for each basic emotion multiple detailled subcategories. A common model is the Plutchik
wheel of emotion, which is conventionally used to classify emotion in text. It offers eight types of basic emotion: joy, trust, fear, surprise and their opposites sadness, disgust, anger and anticipation @Kumar2022.


Visible in @fig:wheel_emo, each emotion has multiple levels of intensity. For example, the enhanced level for disgust is loathing, a more moderate level is boredom. In total there are 24 different emotions. A variety of sentiments and their intensities lead to a proper illustration of the real value.

#figure(
  scale(80%, reflow: true)[
  #image("figures/pl_wheel.svg", width: 250pt)],
  caption: [Plutchik Wheel of Emotion @articleW.]
)<wheel_emo>

Although there will be a loss of detail, the content of this thesis will focus on the basic emotion as defined by Paul Ekman. The wheel of emotion from Plutchik is suitable for emotion detection in text but most datasets in facial emotion recognition are focused on Ekmans emotion theory. As shown later in this thesis, many multimodal datasets are based on the work from Ekman. It is harder to distinguish all emotion from Plutchik in audio processing and face recognition. 

=== Emotion in Text

The most common approach for classifying emotion from natural language text is to classify the semantic content of these sentences. In order to make this possible, two syntactical assumptions are needed. 

1. There is a function that is able to map words and sentences to their corresponding emotion.

2. Words and sentences do not change their meaning over time.

The first assumption can be approached by training a deep neural network with a suitable dataset or a clustering algorithm that measures the similarity between words and sentences to match their corresponding emotion label. The function must be surjective, so a token will not be able to be labeled with more than one emotion at the time.
The second assumption is important for a reliable result in training but it is also the flaw of emotion detection in text. For example the sentence "I'm glad to be here",  expressions like irony, emphasis in the voice or gestures can change the proper meaning of the sentence. It could be interpreted as happiness or as disgust. To take this into consideration further observations of other expressive and non-expressive signals are needed.

=== Emotion in Speech<chap:emo_speech>

Emotion in audio is in contrast to the classification in text mainly focused on the syntax from the recording. The actual signal input is represented as a waveform and sinoid functions. A single wave is defined by


$ g(t) := A sin(2π(omega t - phi)) $

A complete waveform as presented in @fig:fig-waveform and @fig:fig-waveformB consists of many different sinoid functions which are added and concatenated together @muller2015fundamentals[pp. 19-22].  

#figure(
  image("figures/audio/audio_1.svg"),
  caption: [Waveform of the first seconds of an audio recording]
)<fig-waveform>

#figure(
  image("figures/audio/audio_2.svg"),
  caption: [Enlargement of the first half second from @fig:fig-waveform]
)<fig-waveformB>




*#smallcaps("Frequency")* ($omega$) measures the pitch from the audio and especially from the voice. As shown in @tbl:speech_features multiple features can be extracted from the frequency or to be more precise the pitch. From a measured neutral foundation, changes like an average pitch, the range or other changes can be observed. For example a person who speaks in a much higher pitch --- with a wide variablity in the range and abrupt frequency changes on stressed syllables --- compared to the average person, will most likely feel anger.

*#smallcaps("Amplitude") ($A$)* shows the intensity and the loudness of the given audio. Furthermore it is also an important feature and easy to extract from speech with the help of an existing neutral foundation.

*#smallcaps("Phase") ($phi$)*  shifts $g(t)$ along the x-dimension. This parameter is not important in the feature measurement but has a significant role in audio decomposition which is described later.

Extracting features like speech rate, articulation or voice quality requires more observation. Speech rate can be measured with words per second, sentences per minute or other similar metrics. Normally when looking at waveforms, the intermissions between sentences or words can be retrieved. A higher rate is equivalent to more observed gaps in the same time of a normal speech speed. Articulation and voice quaility is hard to track without semantic knowledge. Therefore a combination of the already presented features is needed which can be done by pattern matching and comparison to the neutral foundation. 




#include "figures/speech_class.typ"



=== Emotion in Facial Expression<chap:facial-exp>

Besides his theory about the six basic emotions, Paul Ekman introduced a system to map different face expressions to their relating sentiments by combining changes in different areas of the expression field. This facial action coding system (FACS) is based on these movements which are called action units. There are 28 main actions which can be mapped to the six main emotion. In the course of this thesis, they will be used as the main features. #linebreak(justify: true)

#figure(
  [
    #grid(columns: 4, rows: 2, column-gutter: 55pt, row-gutter: 10pt,
    [#image("figures/audio/framed_NEU.png")], [#image("figures/audio/framed_SAD.png")], [#image("figures/audio/framed_FEA.png")], [#image("figures/audio/framed_DIS.png")],
    [Neutral], [Sad], [Fear], [Disgust]
    )
  ],
  caption: [Examples with their annoations from the CREMA-dataset @cao2014crema which show emotions based on facial expression features.]
)<fig:facials>

As visible in @fig:fig:facials, there are distinctive combinations of face features able to represent different emotion. For example, to observe disgust, the typical wrinkling of the nose, the contraction of the eyebrows and a lifting of the upper lip can be perceived. In addition to the movement of the eyebrows, sadness is marked through the downturned corners of the mouth. Thus a face and its expressions can be broken down into seperate regions. #linebreak(justify: true)

*Eyes (upper face):* The most action units to recognize emotion within facial expressions are defined by movement near the eyes. Eyebrows are seperated into an inner and outer part for a more detailed classifcation. Furthermore they can be raised or pulled together leading into four different states. Besides eyebrows, eyelids are another meaningful part in that area. They can be tensed, raised by opening the eyes wide and lowered by narrowing the eyes. In total this region plays an important role for every basic emotion by Ekman and a relevant part for most sentiments based on Plutchiks theory. #linebreak(justify: true)

*Nose:* This face region only impacts one basic emotion, disgust, shown in @fig:fig:facials. This is due to the limited range of movement of this part of the head. Thus this section of the face will not differ from the upper part of the face and the lower part described above due to its low occurrence.

*Mouth (lower face):* The cheeks and the chin are also correlated to this area for the following work in this thesis due to their tight connection to the lips and mouth by means of muscles. This leads to a total of 16 different action units due to the numerous possibilities, e.g. deforming the lips, opening and closing the mouth and the resulting movements in this area. #linebreak(justify: true)

In his research Ekman defined each action unit and their corresponding emotion in detail which can be looked up in his book about the basic FACS System @friesen1978facial.

Furthermore in 2002 @hager2002facial he updated his idea of the facial expression system and integrated more action units adding up to more than 40 possible features in total. This includes tilting and rotating the head and more details on the upper face like winking or blinking with the eyes.

In addition, a closer look into the various intensities of an action are presented and classified into 5 levels: trace (A), slight (B), marked or pronounced (C), severe or extreme (D) and maximum (E). Most common are slight or marked and pronounced, while the higher intensities are visible in films or other acted illustrations. Maximum intenseness is the most rare but can be found in theater or generally live action plays. The different letters are used as an indicator together with the numerated action unit for a better description and overview of all possible combinations. 


== Classification Approaches 

Over time many approaches to detect and classify emotion have been developed. There are several supervised architectures and unsupervised techniques which represent the current state of the art for emotion detection in text, audio and video. 

=== Classification in Text<class_text>

To classify emotions in text, multiple preprocessing steps are necessary due to the lack of numerical values. In the following section, some ideas for preprocessing are presented. Furthermore, a look into various classification methods will be taken. A special focus on the supervised methods is applied due to better comparability of already existing and pretrained deep learning models.

#section[Word Embedding and Tokenization]

The most important part of all classification approaches is called word embedding. It represents words as real-valued vectors @Wang_Wang_Chen_Wang_Kuo_2019. It should use the syntactic but also the semantic meaning of the words to get a useful vector. This technique is commonly used in natural language processing like information retrieval in text. 

A naive approach to generate such an embedding function would be a one-hot vector encoding @karani2018introduction. It represents every word in a space as a different vector. For example the sentence:

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
      #table(
      columns: 8,
      align: center + horizon,
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 {(top: 1pt)} else if y == 1 {(top: 1pt, bottom: 1pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      [*$w_i in V$*], [*$A(w_i)$*], [*$w_i in V$*], [*$A(w_i)$*], [*$w_i in V$*], [*$A(w_i)$*], [*$w_i in V$*], [*$A(w_i)$*],
      [the], [$vec(1, 0, 0, 0)$],
      [tree], [$vec(0, 1, 0, 0)$],
      [is], [$vec(0, 0, 1, 0)$],
      [green], [$vec(0, 0, 0, 1)$],
    )
]

To measure the similarity the cosine similarity is often used @karani2018introduction @Li2018. Similar words or synonyms should have a smaller angle between each other, compared to unsimilar words. 

#align(center)[
  $ #text[sim]\(w_1, w_2) = cos(theta) = frac(w_1 dot w_2, ||w_1|| ||w_2||) $
]

Because the one-hot vector embeds the input word by word without any context, there will not exists any similarity or dissimilarity between the words. This is also the reason why simple one-hot encoding is less used in practise. A semantic consideration will be more useful. 
#pagebreak()
*The #smallcaps[Continouous Bag-of-Words Model]*, shortly CBOW, is capable of taking the context of a word as an input to calculate an embedded vector with emphasis on syntax and semantic. It describes a neural network which mainly consists of three layers: the input layer, a hidden layer and the output layer @9673321. 

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


With unsupervised learning the model on the right of @fig:cbow is able to generate a new vector which represents the context of a word. Now, under consideration of the cosine similarity, words with a similar context have a quite smaller angle compared to those without any connection in semantics. In both architectures, the hidden layer acts like an arithmetic operator which combines the context to the outputted one-hot vector.


#grid(
  columns: (50%, 43%),
  column-gutter: 3em,
  include "figures/skip_gram.typ",
  [
    *The #smallcaps[Skip-Gram Model]* calculates an embedding in reverse from the idea of the CBOW-Model. 
    As the architecture shows in @fig:skipgram it tries to calculate the surrounding words with a given target term @rong2016word2vec. Therefore a training like the CBOW with contextual phrases is needed before it can work as a semantical decoder.
Both architectures are commonly used in different pre-trained word embedding networks, like Word2Vec from Google @mikolov2013efficient @7364114.
  ],)



*#smallcaps[Fast WordPiece Tokenization]* is an approach to tokenize sentences and words in an efficient way by splitting words into smaller subwords. It is used in a language understanding transformer model from Google which is called #smallcaps[Bert] @devlin2019bert.

The basic problem from other tokenization methods like the normal WordPiece Tokenization starts in the vocabulary tokenization in tries. Trie memory is a paradigm which is able to store strings efficiently where each edge of the data structure stores phonemes, the smallest linguistic unit that distinguishes meaning. Traversing a path consisting of multiple edges results in a word. As a result the structure does not have to store redundant parts of words @tries.

The tokenization has to search for the longest token at a position. Therefore it starts from the shortest substring and iterates over the input text while trie matching to match the longest prefix which matches a vocabulary token @song-etal-2021-fast. If the trie matching fails at the next character, the algorithm has to utilize backtracking because the longest vocabulary token may be several characters back.
This results in a time complexity of $O(n m)$ where $m$ is the maximum vocabulary token length and $n$ the input length.

Fast WordPiece Tokenization introduces so called failure links and pops. Failure pops are a list of longest-matching prefix tokens of a node in the trie, which can be removed in order until a failure link node is reached. The failure node is able to represent the missing suffix. This whole algorithm called #smallcaps[LinMaxMatch] has a time complexity of only $O(n)$.

#section[Supervised Classification Approaches] 

With a given word embedding and tokenization, supervised learning approaches are able to recognize emotion in text. Therefore an annotated dataset is needed, which has a reliable mapping from sentence or word to the corresponding emotion.

#include "figures/sup_basic.typ"

Most models use the architecture paradigm as shown in @fig:sup_basic. They mostly differ in the step of combining the feature vectors and the type of classification because it offers the biggest room to maneuver.
A preprocessing and feature extraction is always necessary for classification tasks. Sometimes a WordNet @fellbaum2005encyclopedia is integrated to get a better overview about synonyms or to paraphrase words.

*#smallcaps[Convolutional and Recurrent Neural Networks] \(CNN/RNN)* are an effective approach on sentiment analysis of text @liu2020text. Convolution consists of a kernel-function which downscales the input but keeps the important features. This technique is called #smallcaps[Pooling] and brings several benefits like less memory usage, less overfitting in training and a faster computation time.
Therefore multiple words or sentences of the space $V$ are combined to region matrices. On each region $L$ convolutional filters are applied to learn local $n$-gram features. 

#figure(
  scale(96%)[
    #include "figures/conv.typ"
  ],
  caption: [Simple Convolution based Neural Network to predict an emotion from a given subset of sentences]
)<conv>

@fig:conv shows such a network with the convolutional part. In common architectures multiple convolution and pooling layers are stacked together with an activation function like #smallcaps("ReLu") in between each block which improves the output by setting constraints to the convolution outputs. The constraint which is affected by #smallcaps("ReLu") is the prohibition of negative values by the function $f(x) = max(0,x)$.  This sequencing of the convolution blocks leads to a hierarchical decomposition of the given embedded region matrix. As a result multiple features can be found from each block and each convolution kernel which might result in a higher accuracy. At the end an ordinary decoder in form of a simple linear layer with an activation function like #smallcaps("SoftMax") is utilized to calculate the resulting emotion from the pooled and flattened vector. Normalization such as layer norm or batch norm between each layer can help to ensure better propagation and reduce numerical instability @NEURIPS2021_2578eb9c. #linebreak(justify: true)

Further optimizations to fundamental neural network architectures are gating mechanisms from recurrent networks and the bi-directional flow in the model forwarding architectures. They introduce new types of storage cells allowing for long term feature storage @medsker1999recurrent. In the context of emotion detection in text, it might store important context from previous sentences and words to differentiate between fill-words like "this", "with" and emotionally loaded words.
Commonly used are long short term memory cells (LSTM) @Graves2012 and gated recurrent units (GRU) @chung2014empirical which both try to prevent gradient vanishing which is a big problem in recurrent networks. It occurs while propagating backwards through time. Due to the load of multiplication steps, the gradient converges to 0. These two architectures differ mostly in their structure than in their functionality. In addition to the GRU cell, an LSTM has two more control gates which gives more possibilities to constrain and rule the memory inside the structure. In both cases they can improve learning features from context and time series. 

*#smallcaps[Transformers]* are a deep-learning architecture which is based on multi-head attention. #linebreak(justify: true)  

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
    The basic idea of attention solves a huge bottleneck in common neural network architectures because fixed input vector sizes may result in a large overhead. In the example of natural language processing, this could be a result from very large sentences. Attention mechanisms try to solve this issue by focusing the input on to specific parts e.g. training the input weights on important words or subsets from the given sentence. 

    The resulting transformers are currently setting a milestone in natural language processing and providing the basis for ChatGPT from OpenAI @openai2024gpt4 or other text understanding models, because of their scalability due to the attention mechanisms and their reliable results. @fig:transformer shows such a transformer architecture. An input sentence will be fed into the model where it first gets positionally encoded thus the position and the frequency for every word in the sentence is stored.
  ]
  
)
Now, the input vectors are passing through the first multi-head attention layer to lay the focus on important parts of the input. Nevertheless, the actual input and the weighted part are added and normalized together which results in the original sentence but with tagged highlights due to the attention. To learn the features for the output token, the input traverses through a feed forward network which consists of basic uni-directional layers. Likewise the input and the output are matched together with a residual connection. The same procedure is repeated but with an autoregressive addition of already calculated output. In contrast to the regular multi-head attention, a masking in this process is introduced which sets the weight for unknown or future tokens to negative values thus the model can learn realistic predictions only with already known tokens.
The output of the transformer architecture are probabilities for the next state. The already mentioned autoregressive implementation gives the possibilities to predict a long sequence of tokens.


In addition to the approaches with neural network architectures like transformers, other supervised methods like support vector machines, decision trees or naive bayes are used. These are not covered in this thesis as it exceeds the scope of this work and are a possible part for future work.

In summary, supervised methods follow the basic principle to learn features along a given target. Therefore enough training data is needed with the additional annotated labels. 

#pagebreak()

Finally even the differentiation between convolution, recurrent or transformer networks will not make any noticeable changes in measurements if the architectures and models are large enough @smith2023convnets. In literature this "bitter lesson" @sutton2019bitter is researched step by step and also shown for language models, convolution nets and transformers.


"Scaling Laws for Neural Network" @kaplan2020scaling shows the improvement of the loss, when a model has many parameters, a lot of computation time in training and a large dataset. Therefore this thesis will consider the transformer models as a focal point for later evaluation, because there are many large pretrained language models available which are able to recognize emotion and are trained and developed to satisfy almost all three factors. Language modeling performance improves smoothly as the model size, datasetset
size, and amount of computation used for training is increased. For optimal performance all three factors must be scaled
up in tandem. #linebreak(justify: true)

#section[Unsupervised Classification Approaches]

Many datasets do not include annotated targets or subsets of the data cannot be used as a prediction set. In unsupervised learning, the algorithms try to to extract patterns from this data which consists mostly of similarities or differences in the training set. 

A common unsupervised approach in natural language processing for extracting keywords or similarities from text is called #smallcaps("Latent Semantic Analysis").

*#smallcaps("Latent Semantic Analysis") (LSA)* @lsa is an information retrieval method in text based on singular value decomposition. 
The algorithm first transforms every word from a sentence into a matrix $M$.
This matrix can be dismantled into a diagonal matrix $S$ and two orthogonal matrices $U, V$ through


$ M =  U dot S dot V^T $


$S$ contains singular values which can be easily converted to eigenvalues. These are used to process a query on the vector space to find subsets of $M$ which fullfills the query by applying the cosine similarity. This whole method is quite expensive in computation time because of the necessary decomposition and dimension reductions @1102314.

There are many more unsupervised approaches for emotion detection and information retrieval in text @agrawal2012unsupervised @gollapalli2020ester but they will not be part of the following comparisons and benchmarks
as they also exceed the scope of this thesis. Furthermore, no significant improvements and differences are expected in comparison to the presented unsupervised approaches and also the shown supervised classification methods due to the scaling laws for neural networks.


=== Classification in Audio<chap-class_audio> 

Similar to classification in text as shown in @class_text there are some approaches to supervised and unsupervised methods. First of all an encoding for the audio is necessary to ensure the extraction of the necessary features. 



#section[Fourier Transformation]

To break up the audio signal into multiple atomic sinusodial functions, a fourier transformation and analysis can be applied. For each frequency $omega in RR$ from the given signal, the transformation yields a coefficient $d_omega$ and a phase $phi_omega$ from which a sinusodial oscillation can be retrieved. Looking back at the equation from @chap:emo_speech a normalization with regard to their amplitude is collected by assuming $A = sqrt(2)$. 


$ g(t) := A sin(2π(omega t - phi)) $

For each frequency and phase the normalized function $cos_(omega, phi)(t): RR -> RR$ is given by: 
$ cos_(omega, phi)(t) = sqrt(2) cos(2pi(omega t - phi)) $

Due to the idea of approximating the original audio function with sinusodial waves, a first approach to the fourier transformation can be obtained by maximizing the similarity between both signals.

$ d_omega &:= max_(phi in [0,1)) &(integral_(t in RR) f(t) cos_(omega, phi)(t)dif t) 
\
phi_omega &:= "argmax"_(phi in [0,1)) &(integral_(t in RR) f(t) cos_(omega, phi)(t)dif t) $

Bringing this into the context with polar coordinates and the additional idea to store both values $d_w$ and $phi_omega$ into a single complex value. This results in the common fourier transformation form given by:

$ hat(f)(omega) &= integral_(t in RR) f(t)exp(-2pi i omega t)dif t
\
&= integral_(t in RR)f(t)cos(-2 pi omega t) dif t + i integral_(t in RR)f(t)sin(-2 pi omega t) dif t  
$

These equations are however only suitable for non-discrete signal-processing and must be adapted to a discrete fourier transformation. A sampling period $T$ is introduced to sample the signal in multiple time steps. An approximation for $hat(f)(omega)$ is obtained #linebreak(justify: true)

$ hat(f)(omega) approx sum_(n in ZZ) T(f(n T))exp(-2 pi i omega n) $

with a time complexity of $O(N^2)$ where $N$ denotes the length from the given signal @muller2015fundamentals[pp. 39-50]. 
Thus $N$ can get quite large certain optimizations had to be developed for efficient usage in bigger datasets. 
For example the fast fourier transformation, with a complexity of $O(N log N)$, uses a divide and conquer algorithm to split the signal, calculate the fourier transformation and reassemble it @park2020fast.
Also common is the short time fourier transformation which divides the audio into windows with a given size $n$ and a hop size to determine the step size of the sliding window @muller2015fundamentals[pp. 51-54] @durak2003short. 


#section[Supervised Classification Approaches]
Analogous to @class_text the supervised classification approaches follow the same structure. Recurrent- and convolution-based networks are the most common approach @wang2022learning @kong2020panns to classify features from audio after retrieving the fourier representation for every signal and can also be applied to emotion. Continuing from the already presented fourier transformation and analysis, these supervised classification methods refer to the feature extraction from spectograms @COSTA201728 @spectograms which is the visual representation of the given signal and a lightweight implementation for these networks. #linebreak(justify: true)

In research, the first transformer based audio classification are presented @verma2021audio. The idea is an amalgamation of the idea from convolution architectures and the common transformer model.

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
    Therefore it inputs the raw audio data without any preprocessing besides padding to the right length. As shown in @fig:fig:trans_audio the model first divides the signal into multiple fixed-length patches to feed them into a front-end layer. The patches describe very short sequences of the audio and show the resolution in which the work will subsequently be carried out. It consists of a few dense layers which process the raw audio to multiple feature vectors. These are suitable for learning in the common transformer architecture. Furthermore they are chained together with an average pooling layer, giving the convolution-like downscaling and compressing effect. This step can be repeated multiple times until the required output shape is nearly matched. At the end a decoder layer in form of some dense layers is applied to predict the resulting label. Equivalent to the already introduced convolution networks, activation functions like #smallcaps("ReLu") or #smallcaps("softmax") can be interposed between all existing layers
  ]
)


for more stability. Nonetheless the bitter lesson from the previous chapter also applies here. For this reason and because of the already large scope of this thesis, further considerations about other supervised approaches like SVM or decision trees, are not made.

#section[Unsupervised Classification Approaches]

Unfortunately unsupervised audio information retrieval approaches are quite rare. There are a few methods which use k-means to learn from local audio features @wulfing2012unsupervised. Thus they are not really suitable for emotion detection due to their low capability of detecting global features.
However in spite of that there are some methods to collect local features which can assist the supervised deep learning method @unsupervisedmusic. #linebreak(justify: false)

=== Classification in Images and Videos

Relating to the previous classification methods, the foundation for emotion detection in images and videos is quite similar. However, there exists much research to optimize the supervised and unsupervised strategies regarding the input size and computation time. In addition, video has interesting advantages and disadvantages as compared to images, which is necessary for the following methods and optimizations. The disadvantages of video mostly arise from the additional dimension time, which is introduced through videos as a time series while they can be dissected into single images. 

#section[Supervised Classification Approaches]

As always, convolution models are the most common architectures for deep learning on images and videos @9012507. While images can be flattened to a one-dimensional vector to process it with simple convolution filters, layers or even with recurrent and simple linear models, video processing and learning arrives with a bigger challenge. Fortunately kernels for convolution are able to have $n$-dimensional shapes though this leads to more expensive computation and memory consumption. The same issue occurs naturally with video transformers @10041724. These follow logically the already presented architectures in text and audio classification as they transfer the researched benefits from transformer models to the vision domain. Nevertheless they scale quadratically with respect to the input length. Thus further optimizations on the input, which will be presented in the following sections, are helpful and even necessary. #linebreak(justify: true)

*#smallcaps("Slicing")* offers different options to reduce the input size from the video with a variety of selection methods @fabianmaster. 

#set list(indent: 2em)
#grid(
  columns: 1,
  gutter: 1em,
  [- *Time Exclusive Slicing:* As the most simple approach, time exclusive slicing picks one or more single frames out of the given video, resulting into a more compact version like a flip book. This selection can be done randomly or with a fixed selection of the frame indices @texclusiveslice.],
  [- *Spatial Exclusive Slicing:* This method divides each frame into a grid of spatial patches. Then it chooses one of the grids (mostly the center) and picks the same patch over the full time dimension.],
  [- *Cubicles:* Cubicles or tubelets @arnab2021vivit are extracted by choosing spatial patches in combination with its temporal neighbours. This is similar to spatial exclusive slicing but with more variety in the chosen grid positions.],
  [- *Shards:* This method  @Akbari2021VATTTF is a combination of spatial exclusive slicing, cubicles and time exclusive slicing in which spatial patches are chosen from random or fixed and indexed frames.]
) 


Overall these options reduce the input size of the input video to a fraction of the original size on the basis of the assumption that there are unnecessary parts in each frame like the corners and that videos with more frames per second include more redundancy, such as very small changes and movements between each time step. Furthermore the basic spatial exclusive slicing is not well suited due to its inability of removing the described redundancy. In general spatial patching can be challenging, if the person in the video is moving or the main actors are in different positions in each data sample. #linebreak(justify: true)

Further methods for input optimizations regarding the idea of tracking movements are presented like utilizing temporal difference images @fabianmaster. It follows that deep learning architectures only learn features from the moving parts of a face and that non-moving parts might be unnecessary. According to Ekman and the presented action units from @chap:facial-exp this hypothesis has a good foundation. With time exclusive slicing they picked frames both randomly and with a fixed distance between the time steps and subtracted the frames from each other to create a temporal difference image for each video. Each of them shows the moving action units which were present in the data sample before. Thus it shows the action units which are normally learned by the first layers from an architecture. 

#figure(
  image("figures/fabianmaster.svg"),
  caption: [
    An overwiev of the preprocessing pipeline @fabianmaster.
  ]
)<fabsmasterpipeline>

This optimization method is shown by @fig:fabsmasterpipeline where the resulting temporal image shows only the moving parts from the video. Thus it may save some computation time but mostly it is able to save memory cost due to the reduction from 30--120 frames per input to only one temporal frame.

A similar, yet different approach is called optical flow @8358488, where for each video the moving parts and how they change is calculated and represented as multiple feature vectors. Here a video is represented mathematically by $I(x, y, t)$ where $t$ denotes the time dimension as the single frames. The coordinates $x$ and $y$ belong to points defined in advance at which the movement is then tracked. These can be for instance the corners of the mouth, parts of the eyebrows or the eyelids. More points can be used to get a more precise resolution but also a larger input sequence. An appropriate amount would be between 20 and 30 to capture all 26 basic action units and some more details. The resulting optical flow while tracking is denoted by

$ frac(dif t, dif x) = I_x u + I_y v + I_t = 0 $

where $(u, v)$ represent the direction where the pixel at $(x, y)$ is moving to. The resulting flow matrices can be used for a convolution deep learning architecture to determine the corresponding emotion. 
All in all there are exists many approaches to reduce the problem with high usage of memory and computation time. If these aspects can be ignored a simple 3D convolution network will cover the time dimension and can be adapted to the structure of a video @conv3dvideo.

#pagebreak()

#section[Unsupervised Classification Approaches]

The challenge for unsupervised classification is the feature extraction from the video which needs some kind of tracking like optical flow. Thus it has to determine which action unit is activated leading to a combination of information which then are mapped to an emotion, as presented in @chap:facial-exp. The already shown preprocessing possibilities from supervised approaches showcase a first look about possible feature extraction, which can also be helpful for unlabeled datasets. 

*#smallcaps("Appearance-based Approaches")* follow the idea that different facial regions are defined by unique colours and textures. In general it is approached by mapping a coordinate grid absolute to a frontal picture of a head @activeimagelabeling or relative to fixed marks @4293201. Each face region is divided into non-overlapping patches and blocks. Each block is represented as a single feature vector and contains one facial landmark which can be clustered to an action unit afterwards. However, it observes the moving parts by colour, texture and the position in the frontal face it is sensitive to changes of light and even smaller changes of the head position. Therefore it is a suitable method for testing and methodological improvements but is not quite suitable for real life application due to these sensitivities. #linebreak(justify: true)

*#smallcaps("Geometry-based Approaches")* are not well researched due to the difficulty to extracting and obtaining facial point locations @7990582. However, somewhat similar to the appearance-based approaches, the idea for geometric feature extraction involves looking for changes in the static face but moreso for deplacement of the same point location due to muscular changes. In combination with the aforementioned approach, it can result in improved performance independent of lighting and outer conditions.

*#smallcaps("Motion-based Approaches")* are based on dense motion rather than the discrete motion from facial landmark points as presented in geometry-based approaches. Image substraction, as one subset, which was already shown during input minimisation for supervised approaches can also be used together with a combination of basic clustering algorithms like k-means @1398371. Also the presented optical flow method is capeable of being used for unsupervised learning adapting it to quadtree decomposition for matching the important moving parts. #linebreak(justify: true)

In general these feature extraction approaches use k-means with an alignment to time series. Often used is dynamic time warping, which is a distance metric and useful for time series with different lengths. Thus it has a drawback due to not always satisfying the triangle inequality which is usually an important property of these metrics. Further optimizations lead to a method called dynamic time alignnment kernels @NIPS2001_a869ccbc  defined by #linebreak(justify: true)

$ tau = max_Q sum^l_(c = 1) frac(1, n_x + n_y) (q_(1c) - q_(1c - 1) + q_(2c) - q_(2c - 1))kappa_(q_(1c) q_(2c)) $

where $kappa_(q_(1c) q_(2c))$ represents the kernel similarity between single frames from two video inputs. A possible kernel could be $kappa_(q_(1c) q_(2c))(x_i, y_i) = exp(frac(1, 2 sigma^2) norm(x_i - y_i)^2_2)$ with $sigma^2$ as the average distance to the 10% of its nearest neighbours  @5539966. Clustering the features is not limited to k-means but is the most common approach. Generally, the research in time series clustering has developed over the last years bringing different metrics and algorithms to the front and can be adapted with little to no effort @WARRENLIAO20051857. 


== Datasets<chap-datasets>

For the multimodal analysis and the supervised approaches in learning, a dataset consisting of at minimum video with audio is needed. From this state the text transcription can be retrieved during preprocessing. During this thesis, two different datasets are used which fulfill these requirements.
The following datasets are based on the Ekman emotion model with some changes.

*CREMA-D* (Crowd-sourced Emotional Multimodal Actors Dataset) @cao2014crema consists of 7,442 clips with 91 different actors featuring their facial and vocal expressions. It covers every of Ekmans emotions: _Anger (ANG), Disgust (DIS), Fear (FEA), Happy (HAP), Neutral (NEU), Sad (SAD)_
with the exception of _surprise (SUP)_, because it can relate to any other emotion with a rapid onset. additionally there are a few annotations to the intensity of the sentiment, but it is only a small percentage regarding the amount of data. Therefore it will not be used for further evaluation in this thesis.

The actors recorded twelve different sentences for each type of emotion such as "Don't forget a jacket." or "I wonder what this is about." which have a semantically neutral connotation. These snippets are between 50 to 80 frames long with a framerate of about 30 frames per second. 


#include "figures/cremad.typ"

As shown in @fig:cremad the distribution of labels is uniformly distributed with the exception of neutral. This won't leed to any problem, because the actual sentiments shown in the visuell data are very strongly acted so there are clear features available.

*MELD* (Multimodal EmotionLines Dataset) @poria2018meld is an annotated collection of short sequences from the series "Friends". In difference to the CREMA dataset or most other multimodal datasets for sentiment analysis like IEMOCAP @busso2008iemocap the given data has many multi-party conversations where there is more then one participant active and present in most parts. This leads to a more complex and challenging feature extraction but approximates more closely to reality.

#include "figures/meld.typ"

@fig:meld shows the uneven distribution of the different sentiments, which can lead to an imbalanced training. Nevertheless it is a quite large dataset with 13,708 annotations which includes in addition to the emotion, the character as the speaking person which can be used to analyze the different features depending on gender or age. 

#section("Data Statistics and Analysis")

Looking at the data distribution presented by the violin plots in @fig:fig_dis-full, a clear pattern emerges when focussing on the length distribution of text, audio and video. Wider areas along the x-axis are generally showing a higher occurence of the length. Further the range is shown by the y-axis. The CREMA-D dataset includes many shorter sequences with little to no scattering leading to an average of about 2.5 seconds of content. In contrast the MELD dataset includes a variety of different length of up to or more than five seconds of material thus showing a mostly similar average of time. In conclusion CREMA propagates the lack of variety in sentences as shown in (a) through the video (c) and audio (b) content due to their limitation of only twelve different sentences. With the greater real-world applicability of MELD, it features a high variety of different content lengths, which could lead to an increase in the need for more data preprocessing like padding and a larger model architecture depending on the input size. #linebreak(justify: true)

#set par(justify: true)

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: -45pt,
    [
      #stack(
        [#image("figures/data/text_vio.svg")],
        [(a) Text]
      )
    ],
    [
      #stack(
        [#image("figures/data/audio_vio.svg")],
        [(b) Audio]
      )
    ],
    [
      #stack(
        [#image("figures/data/video_vio.svg")],
        [(c) Video]
      )
    ]
  ),
  caption: [Distribution of the different modal lengths for each dataset.]
)<fig_dis-full>

#pagebreak()


#section("Challenges")
As oreviously described before, the datasets bring about different challenges and requirements for the model architectures. One such challenge or obstacle, which will be important for the later evaluation, stems from the CREMA-D dataset. It consists of the twelve sentence which are acted in each emotion. Therefore it is not possible to predict any reliable label for the emotion detection in text. A general challenge for the MELD data is the imbalance between each label. As the neutral emotion is by far the most common annoation the models will mostly predict only this category, achieving a high accuracy regardless. Furthermore, due to the imbalance in the actual data sizes and as before explained with @fig:fig_dis-full, the MELD dataset covers a high range of different input lengths for each modal. Due to this reason, some adaptation to the maximum input length for both datasets is needed, or alternatively, some kind of input compression such that in the end all data entries have the same length for training. Another big challenge which will be discussed further in Chapter 4 is the non-scientific recording of the videos from MELD. As they stem from a television series the main acting person, where the model has to detect and retrieve the corresponding emotion, is not always at the same position in the video snippets. Additionally, background characters visible in the data samples could be interpreted as important by the learning model. Generally speaking, there are many unnecessary details in the MELD videos which are obstructive for correct learning. The last and biggest challenge can, yet again, be found only within the MELD dataset. It is highly imbalanced with over 50% of the labels being neutral and only small occurences of disgust and fear. Therefore a good training would be complicated as the model will mostly predict neutral and reaches a high accuracy without looking at the features.


