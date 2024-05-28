#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Related Work

Emotion detection is a research field which has developed much over the time. Also the comparison of multimodal emotion detection approaches and their results crystallized in the last few years. In the following chapter multiple exploration are presented with their idee and the result. Also a comparison of the different approaches will take place mostly while presenting the ideas shown in the works.

== Audio and Video Based
*Temporal Multimodal Fusion for Video Emotion Classification in the Wild* by Vielzeuf et al. @relwork1 builds a framework on audio and visual features where it tries different combination and different scoring of the features. They use convolution models as a deep learning architecture and the OpenSmile toolkit as an audio feature extractor to retrieve supervised the six emotion from Ekman and in addition the neutral state. The visual information are extracted frame by frame and as a conecutive video whithin two different models. For training they used the Acted Facial Emotion in the Wild dataset @6200254 which consists of different movie scene and is comparable with the presented MELD dataset. In total they have an accuracy of 58.8% with the combination by a weighted mean but with no information about how they set the weights.


*Multimodal mixed Emotion Detection* @8321250 presents a similar method and implementation to the work presented before. Thus they create features from hand gestures and body movement aswell which are then forwarded into a support vector machine. To extract information about the visual and audio data they used premade frameworks like OpenEar similar to OpenSmile and FaceAPI which allows better tracking for faces and head rotations. Additionaly they used an infrared sensor from Microsoft for the gestures and moving parts of the body. Furthermore they classified the six Ekman emotion like the paper before but without any neutral emotion. As results they presented an accuracy of 77.5% while using data from the hand gestures, 65.2% for the body modality and 94.3% for using information from the head region. In total by combining all features they got an accuracy of 96.6% which is quite promising. Thus they are using the IEMOCAP database which is more comparable with the CREMAD database and brings more acted emotion into training than a more natural dataset would do which was used in the work before. Also they did not include any feature combination with weights or other methods. The high difference in the final accuracy shows the difficulty with natural moving parts or moving cammera perspectives like shown in movie scenes instead of static positioning and overacted emotion. 

== Audio, Video and Text Based

*Multi-level Feature Optimization and Multimodal Contextual Fusion for Sentiment Analysis and Emotion Classification* @relwork3 is using text, audio and video as input, extracting the features with evolutionary computing based models like GA or GGA @gga. They propose a multi layer feature extraction which propagates the raw input through different layers. The first subsets of information and patterns is extracted by unimodel GAs and GGAs, and then forwared into an recurrent LSTM network to retrieve more contextual input. This procedure will be repeated multiple times and between each step a fully concatenation of all features is applied and a split from unimodal to a trimodal architecture. Fot training and testing they used the IEMOCAP database as a static dataset and the CMU-MOSI data. This set consists of opintion videos from YouTube splitted up into multiple emotionally affected segments making it compareable with the MELD or the WILD database. As shown in @tbl:table-accs they got quit relieable results showing that a combination of the multimodal features can improve the accuracy. In single feature usage they got an score of 69.49% for video, 77.28% in text and 68.28% while using the IEMOCAP dataset and similar results for the CMU-MOSI model. #linebreak(justify: true)

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 3,
      columns: (30%, 30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      [Modality], [Accuracy CMU-MOSI], [Accuracy IEMOCAP],
      hlinex(),
      [T+A], [77.06%], [78.85%], 
      [T+V], [76.65%], [79.12%],
      [A+V], [70.00%], [65.44],
      [T+A+V], [80.38%], [79.52%],
      hlinex()
    )
],
caption: [Comparison of results. A = Audio, V = Video, T = Text.]
)<table-accs>

To combine the features they used the contextual fusion where the model trains the optimal weights for the composition.
Furthermore it shows that there won't be much improvement between text and audio in turn of the same features combined with video features. Thus it presents a relieable architecture for both different types of datasets.

*Multimodal Sentiment Analysis using Hierarchical Fusion with Context Modeling* @MAJUMDER2018124 follows a slightly similar approach like the work before. Instead of GGAs for feature extraction they used basic convolution networks trained with the IEMOCAP and CMU-MOSI databases. Thus for audio OpenSmile was used as a pretrained processor. They present an mostly identical feature combination strategie where a fully connected layer and gated recurrent units for contextual learning to combine the features and learn the optimal weights. Overall they achieved a little less accuracy than the feature extraction with generative models but for text, video and audio in combination they got a score of 80.0%. Audio and video achieved 58.8%. Bimodal combinations with text got an accuracy of round 79% leading aswell to the insight that there is not much room for improvement in comparison to the trimodal result. For the single model evaluation, text performed the best with an accuracy of 76.5%. The other two models bring about 50% to the evaluation which is quite low in comparsion to the already presented methods.  

*Seq2Seq2Sentiment: Multimodal Sequence to Sequence Models for Sentiment Analysis* researched by Pham et al. @seq2seq2sentiment presents architecture based on a special class from recurrent networks. The basic idea is to first train a sequence-to-sequence model for two modalities and afterwards a combinition of the already trained model and the third modal to the final result. Therefore they use the CMU-MOSI dataset and for feature extraction they build on different pre-trained encoder. For text input a GloVE @pennington2014glove which represents his own idea of encoding besides skip-gram or bag-of-word models thus they used an already pre-trained one. COVAREP @6853739 was used to extract multiple important features and feature represenation from the audio signals and for videos an motion-based representation extraction method is proposed. Altogether they didn't measured the accuracy for single modal training due to the structure of architecture. Thus they got an accuracy of 75% for all three modalities in combination. Interesting to note are the accuracys for the bimodal detections. Text in combination with video got 78%. The other two modal permutations lay at 44% for text with audio and 55% for audio and video. They discussed these results with the reasioning that the model architecture did poor training on video and audio features and recommend other encoding mechanisms and a bit different model architecture basing on sequence-to-sequence for future work. #linebreak(justify: true)

*Tensor Fusion Network for Multimodal Sentiment Analysis* @zadeh2017tensor presents the method of tensor fusion for the necessary feature combination in context of the multimodility. It describes an untrainable algorithm which attemps to combine multiple tensors by a reduction to a single tensor. This results in an interplay between a recurrent and LSTM based model for each modality and the proposed tensor fusion layer. Only for text input they showed an own method to extract the necessary features also by combining LSTM cells and linear layers. Like the other works before they set their foundation for audio extraction on pretrained models like COVAREP but they combined multiple processors for different features as peak slope parameters or other high level audio information. For video they also refer to FACET as the facial expression analysis framework able to extract up to 20 action units. On to the tensor fusion layer some fully connected deep layers will learn from the combination tensor to predict the emotion. Overall they reached with their unimodal netowrk an accuracy of 77.1%. Also here the baselines representing every single modal are bringing a high accuracy for text processing by 74.8% and lower precision for visual and acustic features with round about 66%. It outperforms the basic convolution network proposed by the first work and reaches good performance in relation to all other presented works.

https://github.com/audeering/opensmile/releases/tag/v3.0.0