#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Design and Implementation

Given the six emotion from Ekman explained in @chap211 and a neutral label, the following chaper focus on the implementation of the different supervised model architectures for each modal. This will be done for the presented datasets MELD and CREMA-D which are both challenging different aspects of emotion detection. Furthermore the important preprocessing and feature extraction for each model are described. At least the bimodal and unimodal combination are implemented showing different types of feature combination or voting and scoring methods.   


== Unimodal Text Classification

As described in @class_text transformer models are quite suitable for text classifcation. Thus they need some sort of word embedding for preprocessing. Fortunatly already existing Large Language Models are capeable to process text as normal conversation input for giving a mostly correct answer to the prompted sentences. Also the most common models are also pretrained on very large datasets for example paper from scientific websites or collections of sources and articles like Wikipedia. Thus needing some adapations and further finetuning to the used datasets in this work, the following three state of the art pretrained networks are used for measurement and classifcation.  

*#smallcaps("Llama3")* @metaIntroducingMeta developed by Meta presents a generative deep-learning modal based transfomers. It consists of over 128 thousand known vocabularys from open sources in the internet. With more than four billion parameters it reaches and its well preprocessed dataset they show relieable results in text conversations. As a natural language understanding model similar to ChatGPT or other similar Llama provides contextual understanding in a chat like conversation with the user. In contrast to the most big architectures, Meta decided to publish their model open source with all the pretrained weights and different interfaces to run the product locally. 

*#smallcaps("Multi-EmoBERT")* @li2023multi was originally applied to detect fake news with the support of emotion classifcation. Thus it is more an architecture than a pretrained model, bringing the possibility to train and finetune the architecture with own text data. As already briefly explained in the background of text preprocessing BERT shows an bidirectional encoder with an underlying transformer developed by Google in 2018. The multiemotion aspect gives multiple labels and their probabilities for a given input leading into a higher variety and more options to choose the correct label. 

*#smallcaps("T5 Model")* @raffel2023exploring is a text based transformer model which settles on text-to-text transfer learning, following the idea from Llama 3 and equivalent also trained on open source crawled data from the internet. The advantage to the already presented architectures and implementations is an already given finetuning on sentiment and emotion detection reducing the effort for necessary preprocessing.

#section[Architecture Overwiev]
As said an emotion classifcation with text will only be done with already pretrained models thereore they will be considered as a black-box but with some options of finetuning.

#include "figures/text_flow.typ"

@fig:fig-text_flow shows sequence of the processing which can be adapted to the three shown transformer models. In general such models are needing an encoder with an tokenizer and decoder to understand the given natural language input furhter to output human understandable labels for the corresponding emotion. In between their given model architecture is given mostly with their adaption of a transfomer and already well trained resulting in a set of defined weights.

For finetuning theses models are offering in general two different methods which allows adding context to the architectures or weights. Some text-to-text models are trying to simulate human like chat conversations with contextual memory over a talk. Foremost it gives the opportunity to define tasks which will be fullfiled by the artifical opposite. Also it introduces a scope to feed in the available training data to the model by embedding it into the chat prompts and define the task to learn temporarily from it. This introduces the problems this given knowledge is just temporarily available in the scope of the current chat window and afterwards permanently deletet and must be repeated every time. Therefore the second method for finetuning shows a procedure to train on top of the current pretrained weights and the encode with an model specific interface. It offers a more relieable context injection in comparison to the prompt engineering method by giving more transparency about the learned content.



#section[Preprocessing and Prompt Engineering for LLM]

Fortunatly all of the three given models are implementing an own language understanding system. Therefore it is not necessary to prospone and train an own word embedding network. Mostly they relie on some variants from bag-of-words to encode the vocabulary tokens.

In all three cases the models consists of an encoder and decoder layer for the text-to-text understanding and their specific transformer based architectures to give them their expected user-oriented functionalities. Thus just input a sentence to retrieve the emotion label won't work well in the most cases due to the attemp to imitate real-world conversations. Looking at the results for the input sentence "I see that!" the models are showing the following responses in @tbl:tbl-text_answers. Llamas respones shows the conversation like answer leading to the need of some finetuning. Fortunatly the model has contextual memory which can be used to predefine a task with natural language for the architecture. In this case the chore with an example for better understanding is given and repeated after every prompt to refresh the contextual memory. Further as shown in @fig:fig-text_flow and explained before the train data can be embedded in the progression of the conversation to give the model a higher overwiev over the given data which can lead to an higher accuracy. 

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 7,
      columns: (auto, auto, auto),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Model], [Response], [Type of Response],
      hlinex(),
      [*Llama3*], [I'm glad I could share the excitement with you! It's always thrilling to spot a clever joke or play on words. If
you're ready for more, I've got a few more where that came from!], [Natural Language Conversation],
      [*Multi-EmoBERT*], [

        #grid(
          row-gutter: 5pt,
          column-gutter: 10pt,
          align: (right, left),
          columns: 2, 
          [anger:], [0.0098],
          [disgust:], [0.0050],
          [fear:], [0.0113],
          [joy:], [0.3621],
          [sadness:], [0.0121],
          [suprise:], [0.0564],
          [anticipation],
          [0.5360],
          [optimism], [0.4288],
          [pessimism], [0.0121],
          [trust], [0.0330]

        )
        ], [Probabilities for every emotion],
      [*T5 Model*], [joy], [emotion label],
      hlinex()

    )
],
caption: [Answers from the three text-to-text models without finetuning and context.]
)<tbl-text_answers>
 // further train for T5 is possible https://huggingface.co/docs/transformers/model_doc/t5

#pagebreak()

A possible prompt which is used later for the evalation is: 

#quote(block: true)[
"Giving the following seven emotion with their abbrevation: Anger (ANG), Disgust (DIS), Fear (FEA), Surprise (SUP), Sadness (SAD), Happiness (HAP), Neutral (NEU). I\'ll prompt you a sentence and you will answer with the corresponding emotion abbrevation. For example I\'ll ask: "My day is awesome" and you\'re answer would be "[HAP]". Don\'t forget the brackets. Sentences, or questions like "okay" or "lets go" are also sentences where you have to guess the emotion. Alright?"]

With this task the model outputs a more sensible answer in the right format for the same example sentence. This prompt can be changed slightly to feed in the contextual information about the training data without much effort. However as mentioned it is a bit more complicated with the Multi-EmoBert due to the lack of any context based chat functionality thus they already give the emotion label as a response. Looking back at @fig:fig-text_flow and the notes before there are possibilitys to train the architectures in particular the encoder and the weigts on top of their pretrained values with an own set of data. This opens up the opportunity to finetune the models and enhance the results. Simply the data from the training dataset has to be processed to the specific format which is already offered by an interface from the source code. Further an application of a threshold to validate the correct emotion label is necessary as it outputs all probabilities for every sentiment showing another variable factor which has impact on the accuracy. A lower value might increase the chance to include the correct emotion in the set of all sentiment which are guessed with an higher possibility. Thus the amount of false positive emotion must be considered aswell. With an higher threshold the possibilities to guess the correct label might be lower but also the magnitude for all missclassified labels is lower. If there aren't any classifcation which reached the minimum possibilitie, the sentence is tagged as neutral. All sentiment given by the model which are not part of Ekmans six basic emotion or neutral are ignored because they are based on the original training data and have much lower possibilities after retraining the model with an own dataset excluding these additional sentiments.

The T5 accepts both methods for finetuning thus prompt engineering don't seems to be mandatory due to the already labeled output. Thus the combination might show interesting results in comparison to the other two architectures with only one of the two finetuning methods. In comparison to the Multi-EmoBERT model it won't offer a direct interface for dataset conversion and an active method for training but it has an low-level connection which allows training like an normal model but with respect on to the pretrained weights. In addition the documentation gives some functions to enable regular training. As a PyTorch submodule it includes a loss function based on the cross entropy loss function to compare the resulting token values. Also the encoder and tokenizer part is able to recognize new tokens and adapt itself without any further external influences or preprocessing. 





#pagebreak() // gz6eju7rju476hz7rju47eu66et5

== Unimodal Audio Classification

In contrast to text classification there aren't many pretained and large networks available thus many different architecture and model types exists as described and shown in @chap-class_audio. Fortunatly multiple feature extraction methods and tools are useable bringing a large range of different information on the basis of fourier transformation. Furthermore an own encoder and decoder mechanisms must be implemented for audio understanding and reliable labeling.

#section[Preprocessing and Feature Extraction]

OpenSmile features a variety of valuable information from an audio segment giving a good overview about necessary components which are useful for the corresponding set of emotions.

*#smallcaps("Loudness")* describes the volume of an audio and is able to describe firmly to sets of emotion as already presented. In general louder voices leading to more agressive emotion while calmer audios are representing harmonious or more melancholic sentiments of a person.

*#smallcaps("Alpha Ratio")* shows the relation between frequency above and below 1000Hz. In support of loudness the ratio analyizes vocal volumes and not only the volume of the audio sample itself. Also some information about timbre from the data can be obtained. 

*#smallcaps("Hammarberg Index")* @hammarberg1980perceptual can be briefly described as the intensity difference between the maximum intensity of the signal in a lower frequency set and the maximum intensity in higher frequency thus giving an energy distribution measurement for the given audio. As well as loudness the energy index normally can be mapped similarly to different sets of emotion.

*#smallcaps("Slope")* measures how fast a given audio signal tries to reach high frequencys leading to different possible assumptions about pitch changes and pitch ranges which are important for several types of emotion.

*#smallcaps("MFCC")* (Mel Frequency Cepstral Coefficients) are a compact representation of frequencys where different pitches are visible. They are often use for speach synthesis and other detection methods due to their high information value.

*#smallcaps("Jitter")* is a loss measurement while working with digital audio signals and shows if there is noise in the data while comparing frequencys and oscillations.

*#smallcaps("Frequencys")* are a low-level measurement for the feature extraction. While MFCC are giving a compact overwiev the direct frequencys showing raw information about the audio. Thus as already described earlier they are important for all kinds of audio classifcation and their information retrieval.

More features are also present resulting in a matrix with 20 different types of information which can be processed by different network architectures. Further these layers are including redundancy in different formats and representation for better learning and feature extraction within the models. A comparison of the subset of traits from the audio shows the changes in their data.  

@fig:fig-audio_features shows the presented excerpt from all features which are extracted by OpenSmile.

#figure(
  gap: 20pt,
  grid(
    columns: 3,
    column-gutter: -20pt,
    row-gutter:5pt,
    rows: 2,
      stack(
        [#image("figures/audio_features/loudness.svg")],
        [(a) Loudness]
      ),
      stack(
        [#image("figures/audio_features/alpha.svg")],
        [(b) Alpha Ratio]
      ),
      stack(
        [#image("figures/audio_features/hammarberg.svg")],
        [(c) Hammarberg Index]
      ),
      stack(
        [#image("figures/audio_features/slope.svg")],
        [(d) Slope]
      ),
      stack(
        [#image("figures/audio_features/mfcc.svg")],
        [(e) MFCC]
      ),
      stack(
        [#image("figures/audio_features/freguency.svg")],
        [(e) Frequency]
      ) 
  ),
    caption: [Cutout from the different OpenSmile features in comparison between all anger and neutral audio samples from CREMA-D.]
)<fig-audio_features>

To retrieve this overwiev all audio data for each emotion from the CREMA-D dataset are added together and the average was drawn to retrieve an average signal and to compute these features with OpenSmile. Visible in the loudness-plot (a) the red lines shows the visualization of anger. It is in general higher than the neutral plot which is connotated by the blue color. Furthermore the subfigure shows that fourious emotion are starting much louder in the main than the baseline data. This is underlined by looking at the average drawn out of the signals. Here also the main loudness from anger is much higher as from neutral emotion. As shown later it is also the highest difference between the averages leading to the assumotion that loudness is a quite important factor and feature for the differentiation between these two emotions. Similarly a look on the alpha ration (b) shows an higher average from anger in comparison to neutral. As already explained this ratio shows also some information about the voice volume and the timbre which further supports the theory about the importance of loudness for this comparison. Interestingly the high amount of negative values of the alpha ratio are showing that there is more energy in the lower frequencys than in the higher frequencys. In this case lower frequencys are the range between 50Hz and 1000Hz. To compare these values a male voice has generally a mean of 111.8Hz and 161.3Hz for females @BERG2017257e13 showing the reason for this distribution and values in the ratio and is also supported by the distribution of frequencys (e). Even though it looks unequally distributed, the average for both anger and neutral is nearly the same. The very small difference might show a contrast between the sentiments like loudness or other high-level information due to its low-level representation where the most features are obtained from. More likely are small numerical issues for example instability in calculation of the averages or the difference can be canceled out with much more data. For this overwiev the CREMA-D dataset just offerend round about 1000 samples for neutral and slightly more than 1200 samples for anger out of the training set. #linebreak(justify: true)  

Normally expecting from the Hammarberg index anger must show more energy than the neutral emotion as already described in the alpha ratio. Thus visualized in (c) from the overwiev figure the average from neutral is a little bit but visibly higher than the calculated value from the other sentiment. This may result from different reasions related to the recorded voice quality and timbre. Sometimes more detailled voiced audios with less noise. Also a softer timbre might lead to these results. Finally the vocal pith could have an influence and can result to these small yet existing and a bit unexpected difference. 

Furhtermore interesting is the MFCC plot (e) which shows the difference from anger and neutral emotion by subtracting each MFCC value stream from the other. Each colored cuboid represents the intensity of the mel coefficient measured in decibel. Transparent areas are showing that there is no difference between both values. Reddish parts describing that the mel coefficient for the anger emotion is higher than the coefficient for neutral. On the contrary bluish colored cuboids representing higher values for neutral voices. Looking back at the resulting plot in @fig:fig-audio_features there is a high difference in the low frequency are in the range of 0Hz to 150Hz. As already described this is the interval where the average pitch for male voices lies showing the more active and relevant parts of the plot. This shows that anger voices are having a much higher mel coefficient than the neutral audios meaning that there is much more energy in the recording like loudness in opposite to the baseline. In the higher freguencys the mel coefficient in the neutral emotion is sometimes more present thus there is not many activity by the acting voice in the signal. The values might occur due to noise or compression artifacts in the recording data. While hearing into the audio samples a constant white noise can be observed which encourage this assumption. In a few times this sound could be the same in both audio categories leading to the colorless areas in the presented plot. #linebreak(justify: true) 

Lastly from the cutout the slope shows similarly to the Hammarberg index and alpha ration a small but observeable difference between anger and neutral. These information about the pitch range and change shows that there are some importances within emotion classifcation and that there exists trainable features for the neural network architectures. Negative values are are usually an indication of pauses between words and sentences which can be important for measuring the pace of the speaking person or other information like spoken words per minutes.

Overall there are many more observeable features extracted by OpenSmile which are covering many aspects from audio signals. There are also differences visible between each emotion and the baseline neutral thus some of these are quite small but in some ways like short patterns existing. Also as already shown there are some redundancies within the choice of extracted features which will not be a problem and might result in better training. All feature combination which are earlier shown in @tbl:speech_features are available and measured by OpenSmile and also shown in the given cutout from @fig:fig-audio_features. In every plot and feature there are many zero values visible. Generally they exists at the end of the signal series due to padding with zeros and are the reason for the sudden constant progression of the time series. A neural network wouldn't have any problems with these padded values and normally only tries to learn from the non-zero features.

#section[Model Architectures]

As already presented there exists a lot of different architectures which are able to learn and train from audio data. Most commonly they have some kind of recurrent and bidirectional neurons or in general some context understanding which is important for time series training. 

#include "figures/audio_flow.typ"

== Unimodal Video Classification

#section[Preprocessing Methods] 

#section[Model Architectures]


== Bimodal Classification

#section[Scoring Methods]

#section[Feature Combination Methods]

== Trimodal Classification

#section[Architecture]

