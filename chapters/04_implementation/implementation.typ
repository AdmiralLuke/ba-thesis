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

To retrieve this overwiev all audio data for each emotion from the CREMA-D dataset are added together and the average was drawn to retrieve an average signal and to compute these features with OpenSmile. Visible in the loudness-plot the red lines shows the visualization of anger. It is in general higher than the neutral plot which is connotated by the blue color. Furthermore the subfigure shows that fourious emotion are starting much louder in the main than the baseline data. This is underlined by looking at the average drawn out of the signals. Here also the main loudness from anger is much higher as from neutral emotion. As shown later it is also the highest difference between the averages leading to the assumotion that loudness is a quite important factor and feature for the differentiation between these two emotions. Similarly a look on the alpha ration (b) shows an higher average from anger in comparison to neutral. As already explained this ratio shows also some information about the voice volume and the timbre which further supports the theory about the importance of loudness for this comparison. Interestingly the high amount of negative values of the alpha ratio are showing that there is more energy in the lower frequencys than in the higher frequencys. In this case lower frequencys are the range between 50Hz and 1000Hz. To compare these values a male voice has generally a mean of 111.8Hz and 161.3Hz for females @BERG2017257e13 showing the reason for this distribution and values in the ratio and is also supported by the distribution of frequencys (e). Even though it looks unequally distributed, the average for both anger and neutral is nearly the same. The very small difference might show a contrast between the sentiments like loudness or other high-level information due to its low-level representation where the most features are obtained from. More likely are small numerical issues for example instability in calculation of the averages or the difference can be canceled out with much more data. For this overwiev the CREMA-D dataset just offerend round about 1000 samples for neutral and slightly more than 1200 samples for anger out of the training set. #linebreak(justify: true)  

Normally expecting from the Hammarberg index anger must show more energy than the neutral emotion as already described in the alpha ratio. Thus visualized in (c) from the overwiev figure the average from neutral is a little bit but visibly higher than the calculated value from the other sentiment. This may result from different reasions related to the recorded voice quality and timbre. Sometimes more detailled voiced audios with less noise. Also a softer timbre might lead to these results. Finally the vocal pitch could have an influence and can result to these small yet existing and a bit unexpected difference. 

Furthermore interesting is the MFCC plot (e) which shows the difference from anger and neutral emotion by subtracting each MFCC value stream from the other. Each colored cuboid represents the intensity of the mel coefficient measured in decibel. Transparent areas are showing that there is no difference between both values. Reddish parts describing that the mel coefficient for the anger emotion is higher than the coefficient for neutral. On the contrary bluish colored cuboids representing higher values for neutral voices. Looking back at the resulting plot in @fig:fig-audio_features there is a high difference in the low frequency are in the range of 0Hz to 150Hz. As already described this is the interval where the average pitch for male voices lies showing the more active and relevant parts of the plot. This shows that anger voices are having a much higher mel coefficient than the neutral audios meaning that there is much more energy in the recording like loudness in opposite to the baseline. In the higher freguencys the mel coefficient in the neutral emotion is sometimes more present thus there is not many activity by the acting voice in the signal. The values might occur due to noise or compression artifacts in the recording data. While hearing into the audio samples a constant white noise can be observed which encourage this assumption. In a few times this sound could be the same in both audio categories leading to the colorless areas in the presented plot. #linebreak(justify: true) 

At last from the cutout the slope shows similarly to the Hammarberg index and alpha ration a small but observeable difference between anger and neutral. These information about the pitch range and change shows that there are some importances within emotion classifcation and that there exists trainable features for the neural network architectures. Negative values are are usually an indication of pauses between words and sentences which can be important for measuring the pace of the speaking person or other information like spoken words per minutes.

Overall there are many more observeable features extracted by OpenSmile which are covering many aspects from audio signals. There are also differences visible between each emotion and the baseline neutral thus some of these are quite small but in some ways like short patterns existing. Also as already shown there are some redundancies within the choice of extracted features which will not be a problem and might result in better training. All feature combination which are earlier shown in @tbl:speech_features are available and measured by OpenSmile and also shown in the given cutout from @fig:fig-audio_features. In every plot and feature there are many zero values visible. Generally they exists at the end of the signal series due to padding with zeros and are the reason for the sudden constant progression of the time series. A neural network wouldn't have any problems with these padded values and normally only tries to learn from the non-zero features.

#section[Model Architectures]

As already presented there exists a lot of different architectures which are able to learn and train from audio data. Most commonly they have some kind of recurrent and bidirectional neurons or in general some context understanding which is important for time series training. 

#include "figures/audio_flow.typ"

Similar to @fig:fig-text_flow which shows an abstract visualization of the text to emotion processing pipeline, @fig:fig-audio_flow presents a small overwiev about the necessary components for the detection in audio signals. Starting with the input it is possible to train from it without any external feature extraction. Thus only the audio transformer which was presented earlier is currently capeable enough for relieable results. In general the convolution based architecture mostly needs a predefined feature extraction for better and faster learning results. These two models are the main models implementet in this thesis for emotion understanding in audio. Each architecture will output the calculated logits which are representing the possibilities for each label to be correct. These are afterwards used to map them on to one-hot vectors showing the corresponding emotion as positive (1) and negative (0). This might also allow multi-label classifcation but is not introduced further in this thesis due to the limitation of the scope. For the minimation task of the models the cross-entropy loss is used for each to calculate the error between the resulting and softmaxed logits with the given one-hot vector target. @tbl:tbl-audio_params shows as an important overwiev the amount of trainable parameters for each model. Before the three presented text models implementing round about 4 billion parameters ore more thus they are already mostly pretrained. Both audio architectures are well comparable and within a reasonable range to these models allowing less noise due to higher model differences. #linebreak(justify: true)

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: (30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Architecture], [Trainable Parameters],
      hlinex(),
      [Convolution], [2.176.474.377],
      [Audio Transformer], [ToDo], 
      hlinex()
    )
],
caption: [Amount of trainable parameters for both implementations.]
)<tbl-audio_params>


== Unimodal Video Classification

Due to the feature extraction methods in audio emotion classifcation which outputs multiple matrices with their corresponding values the detection in videos won't differ much from each other. Thus as already discussed the problem with the additional time dimension within the videos is still existing and needs some preprocessing for improvements and optimizations to reduce the computation time while preventing any avoidable loss in training and evaluation. 



#section[Preprocessing Methods]

As already discussed earlier there are several methods and ideas for preprocessing the video samples before feeding them into the networks. The simplest idea but most expensive in computation time would be to just use the full length with all available frames. The CREMA-D dataset would support this idea without much performance issues as its highest amount of frames in a video is 125 and an average of 75 frames but looking at the MELD dataset shows the significant difference with more than 200 single images in one video. A possible way which is also easy to implement would be to just extract important parts of the videos to represent all most significant features and movements of the speaking person. In general this is hard to track and measure without any further extraction or classifcation of the material. Thus an easier way is to pick every n-th frame out of the given videos instead of every frame. This will reduce the memory costs by the given picking constant and reasons by assume that a video with about 60 frames per second must include a bunch of redundant information which are skippable. Due to the different lengths of the videos, this idea will generate different amount of important cutouts. Therefore padding with zeros would be important and in the average case there will be as many frames as the longest video divided by the constant would have, leading especially within the MELD dataset to many zero values due to the inbalanced distribution of the lengths. Adapting to this problem a further development would consist of a fixed amount of picked frames with different distances and intervals between each other. In this thesis 30 cutouts from each video are choosen randomly which should be enough to represent the actual content and information flow without much loss. Also this contant shows nearly the half of the video length average for each dataset. 

Premade feature extraction methods like FACET which are directly looking for information about the presenting face and acting persons in these videos are suitable for scientificly recorded datasets like CREMA-D where only one persons sits directly in front of the camera. But due to the usage of the MELD dataset which includes more real-world near data and video cutouts which sometimes shows more than one person in a snippet or where the actor won't sit right in front of the camera. These kind of data collections are not suitable for FACET or other premade feature extraction methods regarding videos. 

In total there won't be much preprocessing besides randomly picking 30 frames out of each video. As usual the data will be normalized which will loose information about the color and just keeps the grayscale information in the cutouts. This will also forces the model to learn specifically features about the moving parts in the faces. Thus in this case every color is given by an seperate channel for each RGB (red, green, blue) value. This should not make much difference but can give the model some colored reference points. 

Another problem which occurs before the video can be forwarded into the model is the actual size of a single frame. Generally for example the vision transformer model is tested with small videos and images in size of 16x16 pixel @dosovitskiy2021imageworth16x16words which won't represent the given data from both datasets. Within CREMA-D all data samples have the resolution of 480 pixel width and 360 pixel height. This is already a large amount of values thus it is still not as problematic as the MELD dataset. These videos in the set are much larger due to their origin as samples from a television show made for bigger screens. Therefore they have a resolution of 1020 pixel in width and 720 pixel in height which nearly sevenfold the amount of values per frame and video in comparison to CREMA-D. The only solution for this problem is to crop the videos to a workable size without any loss of information. CREMA-D offers an realtive easy approach thankfully due to the static recording of the speaking person which is generally in the center of the video with some surroundings from the background which can be cutted off. Thus as already shortly presented in @chap-datasets there are several persons within the MELD videos besides the speaking actor. Also as shown in @fig:fig-vid_pre_1 the position of the observation target differs from data sample to data sample which is marked red for better visualization. #linebreak(justify: true)

#figure(
  grid(
    columns: 2,
    column-gutter: 50pt,
    image("figures/vid_pre/dia0-utt0.jpg", height: 100pt),
    image("figures/vid_pre/dia1-utt8.jpg", height: 100pt)
  ),
  caption: [Example cutout from the MELD dataset with marked active speaker.]  
  
)<fig-vid_pre_1>



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

There are two necessary steps available to extract the active person automatically as shown in @fig:fig-vid_pre_2.
First all persons within the video have to get detected by an algorithm. Fortunatly computer vision librarys like OpenCV for python are able to recognize faces in images and therefore also in videos using pretrained machine learning algorithms. In the second step the active speaker must be found. There are also libraries which are able to analyze if the given audio matches to the lip movement from a person. Combining those methods all unnecessary parts like background actors can be cropped out of the videos which leaves only the important active part in a smaller video size.

At the end a futher downscaling is applied on both datasets regarding the relative face position using again the face recognition capability from the computer vision librarys. This leads to a video format of 200 pixels in width and height as shown in (c) from @fig:fig-vid_pre_2 reducing the computation and memory cost by a lot. Thus there are sometimes some visible artifacts in the video which are resulting from camera shaking or unclear face positioning by the actors. Due to these issues the machine learning algorithms and librarys which are used are some times not as precise as the human understanding for face recognition. Also there might be some loss in video quality due to the downscaling which could lead to a depletion of subtle movements in the given face region. But with this preproceesing a model should be able to recognize patterns and similarities which was mostly impossible before.


#section[Model Architectures]

Similarly to the proposed audio architectures, the following structure for the classification in video won't differ that much from each other. Thus for better performance the preprocessing will be mandatory for the convolution based model and the video transformer architecture while the OpenSmile extraction was optionally due to a possible understanding of the raw audio signal. The following overview in @fig:fig-video_flow shows again as for text and audio, an abstract architecture about the necessary steps for audio classification. 

#include "figures/video_flow.typ"

As explained and proposed before the video will be preprocessed first where it is downscaled and cropped generally. Especially the data from the MELD set runs through the speaker recognition pipeline to filter out the most of the unnecessary parts from the samples. Also in both datasets the amount of frames is reduced to thirty with the assumption to reduce redundancy and to save computation cost. After the normalization step which is still part of the preproceesing the videos are feed into the model architectures. As the input has a size of $("batch size", 3, 30, 200, 200)$, describing the (batch_size, channels, frames, width, height), the convolution based approach uses 3D kernels to approach the trainings loop on the given batch regarding the additional time dimension. In contrast the audio convolution model only uses 2d convolution due to the dimensionality of the structure from these time series. Every block in the network consists of a layer norm, the actual weighted convolution layer and a max-pooling. After these blocks some linear dense connected layers are following for further downscaling of the remaining shape and the final mapping to the expected class shape which is in this case and also in the case of audio classificaiton (batch size, 7) representing each emotion as a one-hot encoding. This is also visible also in @fig:fig-audio_flow and @fig:fig-video_flow while looking at the output block thus the model first outputs the logits as the likelihoods for each class. An argument of the maxima (argmax) is able to compute the corresponding label from the probabilities. Furthermore the transformer model is an adaption of a vision transformer which only accepts single images @beyer2022betterplainvitbaselines. The implementation is currently open-source available #footnote("https://github.com/lucidrains/vit-pytorch") as an trainable pre-build architecture which only has to be integrated in the same training loop as for the convolution model. 

For comparison @tbl:tbl-video_params shows the amount of trainable parameters for each architecture. Looking back at @tbl:tbl-audio_params the convolution model has a related size to the other audio based convolution model. Also in comparison to the pre-trained text models they are quite smaller but they should have enough parameters for a relieable result. The 3D vision transformer architecture features a lower amount of trainable points in the given model. Thus as proposed in the original paper, which introduced these kinds of architectures, they generally will perform similar or sometimes even better than traditional models with less parameters.  #linebreak(justify: true)

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: (30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Architecture], [Trainable Parameters],
      hlinex(),
      [Convolution], [2.504.047.929],
      [3D Vision Transformer], [1.266.615.309], 
      hlinex()
    )
],
caption: [Amount of trainable parameters for both implementations.]
)<tbl-video_params>

All models will be trained in twenty epochs with an 90/10 split for training and testing. This can give an overwiev about the efficiency of the architectures and also about the consistency and reliability of the results. Normally these models have to be trained over month for realistic and nearly perfect results but this will exceed the scope of this thesis work. Further the cross entropy loss is calculated for the gradient descent. Also the Adam optimizer is utilized for further optimizations in the calcaulation and uses a learning rate of $mu = 0.00005$.


== Multimodal Classification

Here the bimodal and trimodal emotion classifcation are unified as they won't differ that much in their structure and the methods for combining the outputs from every model. As the unimodal detection was straight forward a mapping from an input to the corresponding output some new ideas must be appended at the end of the given models. Some related works have already presented different feature combination methods like kernel fusion or other ideas. Thus in this case it is more difficult due to some limitations by the architectures which are presented in this thesis. It is too hard and nearly impossible to extract the kernel and logits from the pre-trained text classifcation models because they work like a blackbox where only the output which is always text can be considered. Also the both implemented transformer architectures for emotion detection in audio and video are not suitable for feature combination due to their lack of useable interfaces to extract feature information. These architectures will also only give their output logits. Only the two convolution models can give the required information for kernel learning or other feature combination. As a solution for these problems this thesis will only take a look on scoring methods as a simple form of mapping the three outputs to one final emotion. There are some different main methods which are suitable. #linebreak(justify: true)

#section[Scoring Methods]

A scoring method is a way to weight multiple inputs by their importance for the final output. For example the first architecture is less crucial for the result as the second and third architecture. The task is to find a optimal function $f: VV^(n times m) -> VV^n$ where $n$ describes the amount of emotion which are able to get classified and $m$ counts all possible inputs. In this case $n = 7$ for the six base sentiments together with neutral and further $m = 3$ for the three given modals. 

*#smallcaps("Neural Networks")* which tries to learn its own weights are a good design for the simplest approach for scoring without further complexity. Here a single linear layer is used with the predictions of all training data and the actual output. After the learning phase this model should have an internal weight system for the multimodal input. As they try to solve an optimization problem by minimizing the loss they optimize the function $f$ analogous to this. A drawback of this method shows the blackbox-like behavior of neural networks. After training and testing nobody is able to tell which input was important for the final result and which was not necessary or just a small influence. Also the supervised model architecture might be a drawback in comparison the the following unuspervised approaches.

*#smallcaps("Brute-Force")* is more elaborate method regarding time complexity. The idea is to permute all possible weights for each input. Looking back at $f: VV^(7 times 3) -> VV^7$ it can be simplefied and adapted to feature a weightened and parameterized function 

$ f(a, b, c): a VV^7_0 plus.circle b VV^7_1 plus.circle c VV^7_2 $


where $a, b, c in [0, 1]$ are denoting the different weights for each output and $plus.circle$ the arithmetic for combining the vectors. The goal is to minimize the difference between the actual target $hat(f)$ and the calculated output.

$ min(hat(f) - f(a, b, c)) $

As already mentioned the brute force algorithm will permute all weights with a step size of 0.01. This results in a total of $101^3 = 1.030.301$ permutations. Reducing the step size will increase the amount of possible test cases cubical which underlines the high time complexity. Also it might not be able to find the most optimal solution globally but just locally in the permutation space. To find the global solution the function has to leave the discrete numeric space which is impossible for machines.

*#smallcaps("Major Voting")* is a strategy which only works with more than two different inputs. The main idea is quite simple: the most voted emotion must be the corresponding emotion. For example if the input is $("sad", "sad", "neutral")$ the calculated  output should be "sad" due to its major occurence in the space. This is also a more simple method and won't solve the optimization problem. Also there is no differentiation between the input models. This approach will only focus on the output. If two models are voting equally for the wrong label the result is also wrong. Thus it quite efficient regarding the time complexity and also in comparison to the already proposed scoring methods like brute-force. 

There exists many other possible methods. Every clustering algorithm like k-means would give a relieable result by consider the input labels as cluster points and maps it to natural numbers which then will be observed as emotion. Also rule based classifcation approaches as for example decision trees can be used. Thus this will also exceed the scope of this theses and might be related to future work. 

#section[Architecture]

All unimodal architectures are already proposed and discussed before in this chapter. Thus regarding to the scoring methods they have to put in the same context especially for the same kind of output to meet the requirements given by the optimization function $f$. Looking back at the abstract overwievs for each modal as shown in @fig:fig-text_flow, @fig:fig-audio_flow and @fig:fig-video_flow some tasks are showing up. First of all due to the text-to-text understanding of the natural language models the output has to get mapped back to the one-hot vector which is already given by the audio and video based architectures. Secondly for the neural network approach a dataset out of the results from the original datasets is needed. Therefore every model saves its prediction.  

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 3,
      header-columns: 3,
      columns: (30%, 30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Modal], [Architecture], [Trainable Parameters],
      hlinex(),
      rowspanx(3)[Text], [Llama 3], rowspanx(3)[$approx 4.000.000.000$],
      hlinex(),
      [Multi EmoBERT],
      hlinex(), 
      [T5],
      hlinex(),
      rowspanx(2)[Audio], [Convolution], [2.176.474.377],
      hlinex(),
      [Audio-Transformer], [TBD],
      hlinex(),
      rowspanx(2)[Video], [Convolution], [2.504.047.929],
      hlinex(),
      [3D Vision Transformer], [1.266.615.309], 
      hlinex(),
      hlinex(),
      [Multimodal Scoring], [Linear Layer], [147],
      hlinex(),
    )
],
caption: [Overwie of all trainable parameters for each unimodal architecture.]
)<tbl-total_params>

@tbl:tbl-total_params shows an final overwiev over all trainable parameters for each model and also for the multimodal scoring method featuring a neural network. All models are good comparable regarding their size and amount of trainable weights. The scoring network is the smallest of all thus it includes only a single linear layer which maps three vectors to a single vector. 



// #include "figures/all_flow.typ"

