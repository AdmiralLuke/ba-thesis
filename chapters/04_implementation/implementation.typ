#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Design and Implementation

Given the six emotion from Ekman explained in @chap211 and a neutral label, the subsequent chapter focuses on the implementation of the different supervised model architectures for each modal. This will be done for the presented datasets MELD and CREMA-D which are both challenging various aspects of emotion detection. Furthermore the important preprocessing and feature extraction for each model are described. At least the bimodal and unimodal combination are implemented showing different types of feature combination or voting and scoring methods. @fig:fig-imp_overview shows an overview about the presented implementation goal. In the following each component of this architecture will be described and discussed. 

#include "figures/overview.typ"


== Unimodal Text Classification

As described in @class_text transformer models are quite suitable for text classification. However they need some sort of word embedding for preprocessing. Fortunately already existing Large Language Models are capeable to process text as normal conversation input for giving a mostly correct answer to the prompted sentences. The most common models are also pretrained on very large datasets, for example papers from scientific websites or collections of sources and articles like Wikipedia. Thus needing some adapations and further finetuning to the used datasets in this work, the following three state-of-the-art pretrained networks are used for measurement and classification.  

*#smallcaps("Llama3")* @metaIntroducingMeta developed by Meta presents a generative deep-learning modal based transformers. It consists of over 128 thousand known vocabularies from open sources in the internet. With more than four billion parameters and its well preprocessed dataset they show reliable results in text conversations. As a natural language understanding model similar to ChatGPT or other various models, Llama provides contextual understanding in a chat like conversation with the user. In contrast to the most big architectures, Meta decided to publish their model open source with all the pretrained weights and different interfaces to run the product locally. 

*#smallcaps("Multi-EmoBERT")* @li2023multi was originally applied to detect fake news with the support of emotion classification. Thus it is more an architecture than a pretrained model, bringing the possibility to train and finetune the architecture with own text data. As already briefly explained in the background of text preprocessing BERT is a bidirectional encoder with an underlying transformer developed by Google in 2018. The multiemotion aspect gives multiple labels and their probabilities for a given input leading into a higher variety and more options to choose the correct label. 

*#smallcaps("T5 Model")* @raffel2023exploring is a text based transformer model which settles on text-to-text transfer learning, following the idea from Llama 3 and equivalent also trained on open source crawled data from the internet. The advantage to the already presented architectures and implementations is an already existing open source finetuning on sentiment and emotion detection reducing the effort for necessary preprocessing.

#section[Architecture Overview]
As said an emotion classification with text will only be done with already pretrained models therefore they will be considered as a black-box but with some options of finetuning.

#include "figures/text_flow.typ"

@fig:fig-text_flow shows the sequence of the processing which can be adapted to the three shown transformer models. In general such models require an encoder with a tokenizer and decoder to understand the given natural language input further to output human understandable labels for the corresponding emotion. In between, their model architecture is given mostly by their adaption of a transformer and is already well trained which already results in a set of pre-defined weights. For finetuning these models are offering fundamentally two different methods, prompt engineering and post-training tasks, which allows adding context to the architectures or weights. Some text-to-text models are trying to simulate human-like chat conversations with contextual memory over a talk. Foremost it gives the opportunity to define tasks which will be fulfilled by the artificial opposite. Also it introduces a scope to feed in the available training data to the model by embedding it into the chat prompts and define the task to learn for a limited period of time from it. This introduces the problem that the given knowledge is just temporarily available in the scope of the current chat window and afterwards permanently deleted so it must be repeated every time. Therefore the second method for finetuning shows a procedure to train on top of the current pretrained weights and the encode layer with a model specific interface. It offers a more reliable context injection in comparison to the prompt engineering method by giving more transparency about the learned content.



=== Preprocessing and Prompt Engineering for LLM


#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: (auto, auto, auto),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 or y == 1 { (top: 1pt) } else if y == 3 { (bottom: 1pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      
      [Model], [Response], [Type of Response],
      
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
    )
],
caption: [Answers to the prompt "I see that!" from the three text-to-text models without finetuning and any context.]
)<tbl-text_answers>
 // further train for T5 is possible https://huggingface.co/docs/transformers/model_doc/t5

Fortunately all of the three given models are implementing an own language understanding system. Therefore it is not necessary to postpone and train an own word embedding network. Mostly they rely on some variants from bag-of-words to encode the vocabulary tokens. In all three cases the models consist of an encoder and a decoder layer for the text-to-text understanding and their specific transformer based architectures to give them their expected user-oriented functionalities. Thus just input a sentence to retrieve the emotion label won't work well in most cases due to the attempt to imitate real-world conversations. Looking at the results for the input sentence "I see that!" the models are showing the listed responses showed in @tbl:tbl-text_answers. 

#section("Llama 3")

Llamas response shows the conversation like answer leading to the need of some finetuning. Fortunatley the model has contextual memory which can be used to predefine a task with natural language for the architecture. In this case the chore with an example for better understanding is given and repeated after every prompt to refresh the contextual memory. Further as shown in @fig:fig-text_flow and explained before the train data can be embedded in the progression of the conversation to give the model a higher overview about the given data which can lead to a higher accuracy. 

With this task the model outputs a more sensible answer in the right format for the same example sentence. This prompt can be changed slightly to feed in the contextual information about the training data without much effort as shown in the following @lst:code-llama.

#figure(
  include "code/llama.typ",
 caption: [Short overwie of the prompt input to the Llama model with its contextual feed.],
 outlined: true 
)<code-llama>

A possible prompt which is used later for the evaluation is: 

#quote(block: true)[
"Giving the following seven emotion with their abbrevation: Anger (ANG), Disgust (DIS), Fear (FEA), Surprise (SUP), Sadness (SAD), Happiness (HAP), Neutral (NEU). I\'ll prompt you a sentence and you will answer with the corresponding emotion abbrevation. For example I\'ll ask: "My day is awesome" and you\'re answer would be "[HAP]". Don\'t forget the brackets. Sentences, or questions like "okay" or "lets go" are also sentences where you have to guess the emotion. Alright?"]

#section("Multi-EmoBert")

 However as mentioned it is a bit more complicated with the Multi-EmoBert due to the lack of any context based chat functionality thus they already give an emotion label as a response. Looking back at @fig:fig-text_flow and the notes before there are possibilities to train the architectures in particular the encoder and the weights on top of their pretrained values with an own set of data. This opens up the opportunity to finetune the models and enhance the results. Simply the data from the training dataset has to be processed to the specific format which is already offered by an interface from the source code. Further an application of a threshold to validate the correct emotion label is necessary as it outputs all probabilities for every sentiment showing another variable factor as shown in @lst:code-emo_acc which has impact on the accuracy. A lower value might increase the chance to include the correct emotion in the set of all sentiments which are guessed with a higher possibility. Thus the amount of false positive emotion detections must be considered as well. With a higher threshold the possibilities to guess the correct label might be lower but also the magnitude for all misclassified labels is lower. If there are not any classifications which reached the minimum possibility, the sentence is tagged as neutral. All sentiments given by the model which are not part of Ekmans six basic emotions or neutral are ignored because they are based on the original training data and have much lower possibilities after retraining the model with an own dataset excluding these additional sentiments.


#figure(
  include "code/emo_bert.typ",
 caption: [Simple algorithm for choosing all emotions from the possibility-space $P$ with an threshold $"th"$.],
 outlined: true 
)<code-emo_acc>



#section("T5")

The T5 accepts both methods for finetuning thus prompt engineering does not seems to be mandatory due to the already labeled output. However the combination might show interesting results in comparison to the other two architectures with only one of the two finetuning methods. In comparison to the Multi-EmoBERT model the T5 will not offer a direct interface for dataset conversion and an active method for training but it has an low-level connection through the PyTorch library from python, which allows training like a regular self-implemented model but with respect to the pretrained weights. In addition the documentation gives some functions to enable regular training. As a PyTorch submodule it includes a loss function based on the cross entropy loss function to compare the resulting token values. Also the encoder and tokenizer part is able to recognize new tokens and adapt itself without any further external influences or preprocessing. 



 // gz6eju7rju476hz7rju47eu66et5

== Unimodal Audio Classification

In contrast to text classification there aren't many pretained and large networks available. Thus many different architecture and model types are existing as described and shown in @chap-class_audio. Fortunatly multiple feature extraction methods and tools are useable bringing a large range of different information on the basis of fourier transformation. Furthermore an own encoder and decoder mechanism must be implemented for audio understanding and reliable labeling.

#section[Preprocessing and Feature Extraction]

OpenSmile extracts a variety of valuable information from an audio segment giving a good overview about necessary components which are useful for the corresponding set of emotions. With the knowledge from @tbl:speech_features a small cutout of all extracted features is presented in the following. This excerpt shows the significant types of information which are mostly supported by similar features.

*#smallcaps("Loudness")* describes the volume of an audio and is able to describe firmly two different sets of emotion, calmer sentiments like sadness or neutral and more powerful ones like anger or happiness. In general louder voices lead to the assignment of a to more agressive emotion while calmer audios are representing harmonious or more melancholic sentiments of a person.

*#smallcaps("Alpha Ratio")* shows the relation between frequency above and below 1000 Hz. In support of loudness, this ratio analyzes vocal volumes and not only the volume of the audio sample itself. Also some information about timbre from the data can be obtained. 

*#smallcaps("Hammarberg Index")* @hammarberg1980perceptual can be briefly described as the intensity difference between the maximum intensity of the signal in a lower frequency set and the maximum intensity in higher frequency thus giving an energy distribution measurement for the given audio. Similar to loudness the energy index normally can be mapped similarly to the two sets of emotion.

*#smallcaps("Slope")* measures how fast a given audio signal tries to reach high frequencies leading to different possible assumptions about pitch changes and pitch ranges which are important for several types of emotion like fear or disgust, as shown earlier in @tbl:speech_features.

*#smallcaps("MFCC")* (Mel Frequency Cepstral Coefficients) are a compact representation of frequencies where different pitches are visible. They are often used for speech synthesis and other detection methods due to their high information value. In general features like the speech rate which is important for emotion as for example fear or sadness can be obtained.

*#smallcaps("Jitter")* is a loss measurement while working with digital audio signals and shows if there is noise in the data while comparing frequencies and oscillations. However it is in this case not necessary for emotion detection, nevertheless it is generally helpful for noise detection in this signal processing.

*#smallcaps("Frequencies")* are a low-level information source for the feature extraction. While MFCC are giving a compact overview, these extracted frequencies show raw information about the audio. Thus as already described earlier they are important for all kinds of audio classification and their information retrieval.

More features are also present resulting in a matrix with 20 different types of information which can be processed by the various network architectures. Further these layers are including redundancy in multiple formats and representation for better learning and feature extraction within the models. A comparison of the subset of traits from the audio shows the changes in their data.   @fig:fig-audio_features visualizes the presented excerpt of the features which are extracted by OpenSmile.

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
        [#image("figures/audio_features/freguency.svg")],
        [(c) Frequency]
      ),
      stack(
        [#image("figures/audio_features/hammarberg.svg")],
        [(d) Hammarberg index]
      ),
      stack(
        [#image("figures/audio_features/mfcc.svg")],
        [(e) MFCC]
      ),
      stack(
        [#image("figures/audio_features/slope.svg")],
        [(f) Slope]
      ) 
  ),
    caption: [Cutout from the different OpenSmile features in comparison between all anger and neutral audio samples from CREMA-D.]
)<fig-audio_features>

Each plot shows the changes of the metrics as a time series for the more powerful emotion anger and the neutral baseline. To retrieve this overview all audio data for each of the two emotions from the CREMA-D dataset are added together and the average was drawn to retrieve an average signal and to compute these features with OpenSmile. Visible in the loudness-plot the red lines show the visualization of anger. It is in general higher than the neutral plot which is connotated by the blue color. Furthermore the subfigure shows that furious emotions are starting much louder in the main than the baseline data. This is underlined by looking at the average drawn out of the signals. Here also the main loudness from anger is much higher in contrast to neutral emotions. As shown later it is also the highest difference between the averages leading to the assumption that loudness is a quite important factor and feature for the differentiation between these two emotions. Similarly a look on the alpha ratio (b) shows a higher average from anger in comparison to neutral. As already explained this ratio shows also some information about the voice volume and the timbre which further supports the theory about the importance of loudness for this comparison. Interestingly the high amount of negative values of the alpha ratio are showing that there is more energy in the lower frequencies than in the higher frequencies. In this case lower frequencies are the range between 50Hz and 1000Hz. To compare these values a male voice has generally a mean of 111.8Hz and 161.3Hz for females @BERG2017257e13 showing the reason for this distribution and values in the ratio and is also supported by the distribution of frequencies (c). Even though it looks unequally distributed, the average for both anger and neutral is nearly the same. The very small difference might show a contrast between the sentiments like loudness or other high-level information due to its low-level representation where the most features are obtained from. More likely are small numerical issues for example instability in calculation of the averages or the difference can be canceled out with much more data. For this overview the CREMA-D dataset just offered round about 1000 samples for neutral and slightly more than 1200 samples for anger out of the training set. #linebreak(justify: true)  

Normally expecting from the Hammarberg index anger must show more energy than the neutral emotion as already described in the alpha ratio. Thus visualized in (d) from the overview figure the average from neutral is a little bit but visibly higher than the calculated value from the other sentiment. This may result from different reasions related to the recorded voice quality and timbre. Sometimes also from more detailed audios with less noise. Also a softer timbre might lead to these results. Finally the vocal pitch could have an influence and can result to these small yet existing and a bit unexpected difference. 

Furthermore interesting is the MFCC plot (e) which shows the difference from anger and neutral emotion by subtracting each MFCC value stream from the other. Each colored cuboid represents the intensity of the mel coefficient measured in decibel. Transparent areas are showing that there is no difference between both values. Reddish parts describe that the mel coefficient for the anger emotion is higher than the coefficient for neutral. On the contrary bluish colored cuboids are representing higher values for neutral voices. Looking back at the resulting plot in @fig:fig-audio_features there is a high difference in the low frequency ranging from 0Hz to 150Hz. As already described this is the interval where the average pitch for male voices lies showing the more active and relevant parts of the plot. This shows that anger voices have a much higher mel coefficients than the neutral audios meaning that there is much more energy in the recording like loudness in opposite to the baseline. In the higher frequencies the mel coefficient in the neutral emotion is sometimes more present thus there is not many activity by the acting voice in the signal. The values might occur due to noise or compression artifacts in the recording data. While hearing into the audio samples a constant white noise can be observed which encourages this assumption. In a few times this sound could be the same in both audio categories leading to the colorless areas in the presented plot. #linebreak(justify: true) 

At last from the cutout the slope (f), shows similarly to the Hammarberg index and alpha ratio a small but observeable difference between anger and neutral. These information about the pitch range and change shows that there are some importances within emotion classification and that there exists trainable features for the neural network architectures. Negative values are usually an indication of pauses between words and sentences which can be important for measuring the pace of the speaking person or other information like spoken words per minutes.

Overall there are many more observeable features extracted by OpenSmile which are covering many aspects from audio signals. There are also differences visible between each emotion and the baseline neutral. However,  some of these are quite small but in some ways short patterns exist. Also as already shown there are some redundancies within the choice of extracted features which will not be a problem and might result in better training. All feature combination which are earlier shown in @tbl:speech_features are available and measured by OpenSmile and also shown in the given cutout from @fig:fig-audio_features. Loudness shows changes in the intensity, MFCC is important for the speech rate and articulation. With the alpha ratio the voice quality can be observed and slope shows features for the pitch average, range and other corresponding changes. In every plot and feature there are many zero values visible. Generally they exists at the end of the signal series due to padding with zeros and are the reason for the sudden constant progression of the time series. A neural network wouldn't have any problems with these padded values and normally only tries to learn from the non-zero features.

#section[Model Architectures]

As already presented there exists a lot of different architectures which are able to learn and train from audio data. 

#include "figures/audio_flow.typ"

Most commonly they have some kind of recurrent and bidirectional neurons or in general some context understanding which is important for time series training. Similar to @fig:fig-text_flow which shows an abstract visualization of the text to emotion processing pipeline, @fig:fig-audio_flow presents a small overview about the necessary components for the detection in audio signals. Starting with the input it is possible to train from it without any external feature extraction. Thus only the audio transformer which was presented earlier is currently capable enough for reliable results.
 In general the convolution based architecture mostly needs a predefined feature extraction for better and faster learning results. These two models are the main models implemented in this thesis for emotion understanding in audio. Each architecture will output the calculated logits which are representing the possibilities for each label to be correct. These are afterwards used to map them on to one-hot vectors showing the corresponding emotion as positive (1) and negative (0). This might also allow multi-label classification but is not introduced further in this thesis due to the limitation of the scope. For the optimization task of the models the cross-entropy loss is used for each to calculate the error between the resulting and softmaxed logits with the given one-hot vector target. @tbl:tbl-audio_params shows as an important overview the amount of trainable parameters for each model. Generally the three presented text models are implementing round about 4 billion parameters or more each, however they are already mostly pretrained. Both audio architectures are well comparable and within a reasonable range to these models allowing less noise due to higher model differences. #linebreak(justify: true)

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: (30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 or y == 1 { (top: 1pt)} else if y == 2 {(bottom: 1pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      [Architecture], [Trainable Parameters],
      [Convolution], [2.176.474.377],
      [Audio Transformer], [1.394.574.473], 
    )
],
caption: [Amount of trainable parameters for both implementations.]
)<tbl-audio_params>


== Unimodal Video Classification

Due to the feature extraction methods in audio emotion classification which output multiple matrices with their corresponding values the detection in videos won't differ much from each other. Thus as already discussed the problem with the additional time dimension within the videos is still existing and needs some preprocessing for improvements and optimizations to reduce the computation time while preventing any avoidable loss in training and evaluation. 



#section[Preprocessing Methods]

As already discussed earlier there are several methods and ideas for preprocessing the video samples before feeding them into the networks. The simplest idea but most expensive in computation time would be to just use the full length with all available frames. The CREMA-D dataset would support this idea without much performance issues as its highest amount of frames in a video is 125 and an average of 75 frames but looking at the MELD dataset shows the significant difference with more than 200 single images in one video. A possible way which is also easy to implement would be to just extract important parts of the videos to represent all most significant features and movements of the speaking person. In general this is hard to track and measure without any further extraction or classification of the material. Thus an easier way is to pick every n-th frame out of the given videos instead of every frame. This will reduce the memory costs by the given picking constant and reasons by assume that a video with about 60 frames per second must include a bunch of redundant information which are skippable. Due to the different lengths of the videos, this idea will generate different amount of important cutouts. Therefore padding with zeros would be important and in the average case there will be as many frames as the longest video divided by the constant would have, leading especially within the MELD dataset to many zero values due to the inbalanced distribution of the lengths. Adapting to this problem a further development would consist of a fixed amount of picked frames with different distances and intervals between each other. In this thesis 30 cutouts from each video are choosen randomly which should be enough to represent the actual content and information flow without much loss. Also this constant represents nearly the average video length divided by 2. 

Premade feature extraction methods like FACET which are directly looking for information about the presenting face and acting persons in these videos are suitable for scientifically recorded datasets like CREMA-D where only one persons sits directly in front of the camera. Due to the usage of the MELD dataset, which includes more real-world near data and where the video cutouts showing sometimes additional persons in a snippet or where the actor won't sit right in front of the camera. These kind of data collections are not suitable for FACET or other premade feature extraction methods regarding videos. 

In total there won't be much preprocessing besides randomly picking 30 frames out of each video. As usual the data will be normalized which will loose information about the color and just keeps the grayscale information in the cutouts. This will also force the model to learn specifically features about the moving parts in the faces. Thus in this case every color is given by an seperate channel for each RGB (red, green, blue) value. This should not make much difference but can give the model some colored reference points. 

Another problem which occurs before the video can be forwarded into the model is the actual size of a single frame. Generally for example the vision transformer model is tested with small videos and images in size of 16x16 pixel @dosovitskiy2021imageworth16x16words which won't represent the given data from both datasets. Within CREMA-D all data samples have the resolution of 480 pixel width and 360 pixel height. This results into over 100.000 values per frame however in comparison to the MELD dataset it is still not as problematic. 

#figure(
  grid(
    columns: 2,
    column-gutter: 50pt,
    image("figures/vid_pre/dia0-utt0.jpg", height: 100pt),
    image("figures/vid_pre/dia1-utt8.jpg", height: 100pt)
  ),
  caption: [Example cutout from the MELD dataset with marked active speaker.]  
  
)<fig-vid_pre_1>

These videos in the set are much larger due to their origin as samples from a television show made for bigger screens. Therefore they have a resolution of 1020 pixel in width and 720 pixel in height which is nearly sevenfold the amount of values per frame and video in comparison to CREMA-D. The only solution for this problem is to crop the videos to a workable size without any loss of information. 
CREMA-D offers an realtively easy approach thanks to the static recording of the speaking person which is generally in the center of the video with some surroundings from the background which can be cutted off. Thus as already shortly presented in @chap-datasets there are several persons within the MELD videos besides the speaking actor. Also as shown in @fig:fig-vid_pre_1 the position of the observation target differs from data sample to data sample which is marked red for better visualization. #linebreak(justify: true)
There are two necessary steps available to extract the active person automatically as shown in @fig:fig-audio_preprocessing and as an example visualized in @fig:fig-vid_pre_2. 

#include "figures/preprocessing.typ"



First all persons within the video have to get detected by an algorithm. Fortunatly computer vision librarys like OpenCV for python are able to recognize faces in images and therefore also in videos using pretrained machine learning algorithms. In the second step the active speaker must be found. There are also libraries which are able to analyze if the given audio matches to the lip movement from a person. Combining those methods all unnecessary parts like background actors can be cropped out of the videos which leaves only the important active part in a smaller video size.

#figure(
  grid(
    columns: 3,
    column-gutter: 20pt,
    stack(
      spacing: 10pt,
      image("figures/vid_pre/dia1038-utt7.jpg", height: 100pt),
      [(a) Face recognition. Red = Active Speaker, Blue = Background Character]
    ),
    stack(
      spacing: 10pt,
      image("figures/vid_pre/dia1038-utt7-processed.jpg", height: 100pt),
      [(b) Cropped video after active speaker recognition]
    ),
    stack(
      spacing: 10pt,
      image("figures/vid_pre/dia1038.jpg", height: 100pt),
      [(c) Resized and downscaled video]
    )
  ),
  caption: [Example for the video cropping preproceesing pipeline.]
)<fig-vid_pre_2>




At the end a futher downscaling is applied on both datasets regarding the relative face position using again the face recognition capability from the computer vision librarys. This leads to a video format of 200 pixels in width and height as shown in (c) from @fig:fig-vid_pre_2 reducing the computation and memory cost by a lot. Thus there are sometimes some visible artifacts in the video which are resulting from camera shaking or unclear face positioning by the actors. Due to these issues the machine learning algorithms and libraries which are used are some times not as precise as the human understanding for face recognition. Also there might be some loss in video quality due to the downscaling which could lead to a depletion of subtle movements in the given face region. But with this preprocessing a model should be able to recognize patterns and similarities which was mostly impossible before.


#section[Model Architectures]

Similarly to the proposed audio architectures, the following structure for the classification in video won't differ that much from each other. Thus for better performance the preprocessing will be mandatory for the convolution based model and the video transformer architecture while the OpenSmile extraction was optionally due to a possible understanding of the raw audio signal. The following overview in @fig:fig-video_flow shows again as for text and audio, an abstract architecture about the necessary steps for audio classification. 

#include "figures/video_flow.typ"

As explained and proposed before the video will be preprocessed first where it is downscaled and cropped generally. Especially the data from the MELD set runs through the speaker recognition pipeline to filter out the most of the unnecessary parts from the samples. Also in both datasets the amount of frames is reduced to thirty und the assumption and aim to reduce redundancy and to save computation cost. After the normalization step which is still part of the preprocessing the videos are fed into the model architectures. As the input has a size of $("batch size", 3, 30, 200, 200)$, describing the (batch_size, channels, frames, width, height), the convolution based approach uses 3D kernels to approach the trainings loop on the given batch regarding the additional time dimension. In contrast the audio convolution model only uses 2d convolution due to the dimensionality of the structure from these time series. Every block in the network consists of a layer norm, the actual weighted convolution layer and a max-pooling. After these blocks some linear dense connected layers are following for further downscaling of the remaining shape and the final mapping to the expected class shape which is in this case and also in the case of audio classificaiton (batch size, 7) representing each emotion as a one-hot encoding. This is also visible in @fig:fig-audio_flow and @fig:fig-video_flow while looking at the output block thus the model first outputs the logits as the likelihoods for each class. An argument of the maxima (argmax) is able to compute the corresponding label from the probabilities. Furthermore the transformer model is an adaption of a vision transformer which only accepts single images @beyer2022betterplainvitbaselines. The implementation is currently open source available #footnote("https://github.com/lucidrains/vit-pytorch") as an trainable pre-build architecture which only has to be integrated in the same training loop as for the convolution model. 



#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: (30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 or y == 1 { (top: 1pt)} else if y == 2 {(bottom: 1pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      [Architecture], [Trainable Parameters],
      [Convolution], [2.504.047.929],
      [3D Vision Transformer], [1.266.615.309], 
    )
],
caption: [Amount of trainable parameters for both implementations.]
)<tbl-video_params>

For comparison @tbl:tbl-video_params shows the amount of trainable parameters for each architecture. Looking back at @tbl:tbl-audio_params the convolution model has a related size to the other audio based convolution model. Also in comparison to the pre-trained text models they are quite smaller but they should have enough parameters for a reliable result. The 3D vision transformer architecture features a lower amount of trainable points in the given model. Thus as proposed in the original paper @vaswani2023attention, which introduced these kinds of architectures, they generally will perform similar or sometimes even better than traditional models with less parameters.  #linebreak(justify: true)


All models will be trained in twenty epochs with an 90/10 split for training and testing. This can give an overview about the efficiency of the architectures and also about the consistency and reliability of the results. Normally these models have to be trained over month for realistic and nearly perfect results but this will exceed the scope of this thesis work. Further the cross entropy loss is calculated for the gradient descent. Also the Adam optimizer is utilized for further optimizations in the calcaulation and uses a learning rate of $mu = 0.00005$.


== Multimodal Classification

Here the bimodal and trimodal emotion classification are unified as they won't differ that much in their structure and the methods for combining the outputs from every model. As the unimodal detection was straight forward a mapping from an input to the corresponding output some new ideas must be appended at the end of the given models. Some related works have already presented different feature combination methods like kernel fusion or other ideas. In this case it is more difficult due to some limitations by the architectures which are presented in this thesis. It is too hard and nearly impossible to extract the kernel and logits from the pre-trained text classification models because they work like a blackbox where only the output which is always text can be considered. Also both implemented transformer architectures for emotion detection in audio and video are not suitable for feature combination because of their lack of useable interfaces to extract feature information. These architectures will also only give their output logits. Only the two convolution models can give the required information for kernel learning or other feature combination. As a solution for these problems this thesis will only take a look on scoring methods as a simple form of mapping the three outputs to one final emotion. There are some different main methods which are suitable. #linebreak(justify: true)

#section[Scoring Methods]

A scoring method is a way to weight multiple inputs by their importance for the final output. For example the first architecture is less crucial for the result as the second and third architecture. The task is to find a optimal function $f: VV^(n times m) -> VV^n$ where $n$ describes the amount of emotion which are able to get classified and $m$ counts all possible inputs. In this case $n = 7$ for the six base sentiments together with neutral and further $m = 3$ for the three given modals. 

*#smallcaps("Neural Networks")* which try to learn their own weights are a good design for the simplest approach for scoring without further complexity. Here a single linear layer is used with the predictions of all training data and the actual output. After the learning phase this model should have an internal weight system for the multimodal input. As they try to solve an optimization problem by minimizing the loss they optimize the function $f$ analogous to this. A drawback of this method shows the blackbox-like behavior of neural networks. After training and testing nobody is able to tell which input was important for the final result and which was not necessary or just a small influence. Also the supervised model architecture might be a drawback in comparison the the following unuspervised approaches.

*#smallcaps("Brute-Force")* is a more elaborate method regarding time complexity. The idea is to permute all possible weights for each input. Looking back at $f: VV^(7 times 3) -> VV^7$ it can be simplefied and adapted to feature a weightened and parameterized function 

$ f(a, b, c): a VV^7_0 plus.circle b VV^7_1 plus.circle c VV^7_2 $


where $a, b, c in [0, 1]$ are denoting the different weights for each output and $plus.circle$ the arithmetic for combining the vectors. The goal is to minimize the difference between the actual target $hat(f)$ and the calculated output.

$ min(hat(f) - f(a, b, c)) $

As already mentioned the brute force algorithm will permute all weights with a step size of 0.01. This results in a total of $101^3 = 1.030.301$ permutations. Reducing the step size will increase the amount of possible test cases cubical which underlines the high time complexity. Also it might not be able to find the most optimal optimum globally but just locally in the permutation space. To find the global solution the function has to leave the discrete numeric space which is impossible for machines.

*#smallcaps("Major Voting")* is a strategy which only works with more than two different inputs. The main idea is quite simple: the most voted emotion must be the corresponding emotion. For example if the input is $("sad", "sad", "neutral")$ the calculated  output should be "sad" due to its major occurence in the space. This is also a more simple method and won't solve the optimization problem. Also there is no differentiation between the input models. 

#figure(
  include "code/major_vote.typ",
  caption: [Python implementation for the major vote algorithm.]
)<code-major_vote>


This approach will only focus on the output. If two models are voting equally for the wrong label the result is also wrong. Thus it is quite efficient regarding the complexity and also in comparison to the already proposed scoring methods like brute-force. An implementation for the major voting system is shown in @lst:code-major_vote



There exist many other possible methods. Every clustering algorithm like k-means would give a reliable result by considering the input labels as cluster points and mapping it to natural numbers which then will be observed as emotion. Also rule based classification approaches as for example decision trees can be used. Thus this will also exceed the scope of this theses and might be related to future work. 

#section[Architecture]


#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: (30%, 30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => {
        if y == 0 or y == 1 {
          (top: 1.5pt)
        } else if y == 2 or y == 3 or y == 5 or y == 7 {
          (top: 1pt)
        } else if y == 8 {
          (top: 1pt, bottom: 1.5pt)
        }
      },
      fill: (.., x, y) => if (y > 3 and y < 6) or (y > 7) or (y == 0)  { luma(242) },

      [Modal], [Architecture], [Trainable Parameters],
      
      table.cell(rowspan: 3)[Text], [Llama 3], table.cell(rowspan: 3)[$approx 4.000.000.000$],
      [Multi EmoBERT], 
      [T5],
      // hlinex(),
      table.cell(rowspan: 2)[Audio], [Convolution], [2.176.474.377],
      [Audio-Transformer], [1.394.574.473],
      // hlinex(),
      table.cell(rowspan: 2)[Video], [Convolution], [2.504.047.929],
      [3D Vision Transformer], [1.266.615.309], 
      [Multimodal Scoring], [Linear Layer], [147],
    )
],
caption: [Overwie of all trainable parameters for each unimodal architecture.]
)<tbl-total_params>

All unimodal architectures are already proposed and discussed before in this chapter. Thus regarding to the scoring methods they have to put in the same context especially for the same kind of output to meet the requirements given by the optimization function $f$. Looking back at the abstract overviews for each modal as shown in @fig:fig-text_flow, @fig:fig-audio_flow and @fig:fig-video_flow some tasks are showing up. First of all due to the text-to-text understanding of the natural language models the output has to get mapped back to the one-hot vector which is already given by the audio and video based architectures. Secondly for the neural network approach a dataset out of the results from the original datasets is needed. Therefore every model saves its prediction.  
@tbl:tbl-total_params shows an final overview over all trainable parameters for each model and also for the multimodal scoring method featuring a neural network. All models are good comparable regarding their size and amount of trainable weights. The scoring network is the smallest of all thus it includes only a single linear layer which maps three vectors to a single vector. 



// #include "figures/all_flow.typ"

