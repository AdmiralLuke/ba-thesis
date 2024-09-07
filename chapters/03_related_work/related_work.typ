#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Related Work

Emotion detection represents a field of research which has developed much over the time. An increasing number of multimodal emotion detection approaches and their resulting evaluation have emerged in the last few years. In the following chapter, multiple explorations are presented with their idea and the result. Also a comparison of the different approaches will take place while presenting the ideas shown in the works.

== Audio and Video Based
*Temporal Multimodal Fusion for Video Emotion Classification in the Wild* by Vielzeuf et al. @relwork1 builds a framework on audio and visual features where it tries different combinations and different scorings of the features. They use convolution models as a deep learning architecture and the OpenSmile toolkit as an audio feature extractor to retrieve the six emotions from Ekman and, additionally the neutral state in a supervised manner. The visual information is extracted frame by frame and as a consecutive video within two different models. For training they used the Acted Facial Emotion in the Wild dataset @6200254 which consists of different movie scenes and is comparable with the presented MELD dataset. In total Vielzeuf et al. manage to score an accuracy of 58.8% with their combination of weighted means but with no information about how they set the weights.


*Multimodal mixed Emotion Detection* @8321250 presents a similar method and implementation to the work presented before. Thus, they create features from hand gestures and body movement aswell which are then forwarded into a support vector machine. To extract information about the visual and audio data, they used premade frameworks like OpenEar similar to OpenSmile and FaceAPI which allows better tracking for faces and head rotations. additionally they used an infrared sensor from Microsoft for the gestures and moving parts of the body. Furthermore, they classified the six Ekman emotions like the previous paper but without any neutral emotion. As results they presented an accuracy of 77.5% while using data from the hand gestures, 65.2% for the body modality and 94.3% for using information from the head region. In total by combining all features they manage to obrain an accuracy of 96.6% which is quite promising. However, they are using the IEMOCAP data which is closer to the CREMA-D set and incorporates more acted emotions into training than a more natural dataset would do which was used in the work before. Also they did not include any feature combination with weights or other methods. The high difference in the final accuracy shows the difficulty with natural moving parts or moving camera perspectives as those shown in movie scenes. 

== Audio, Video and Text Based

*Multi-level Feature Optimization and Multimodal Contextual Fusion for Sentiment Analysis and Emotion Classification* @relwork3 uses text, audio and video as input, extracting the features with evolutionary computing based models like GA or GGA @gga. They propose a multi layer feature extraction which propagates the raw input through different layers. The first subsets of information and patterns are extracted by unimodel GAs and GGAs, and then forwared into a recurrent LSTM network to retrieve more contextual input. This procedure will be repeated multiple times and, between each step, a fully concatenation of all features is applied. Following that, the unimodal architecture gets split into a trimodal architecture. For training and testing they used the IEMOCAP database as a static dataset and the CMU-MOSI data. This set consists of opinionated video essays from YouTube split up into multiple emotionally affected segments making it comparable with the MELD or the WILD database. As shown in @tbl:table-accs their results show a reasonably relieable accuracy improvement when using a combination of multimodal features. In single feature usage they got a score of 69.49% for video, 77.28% in text and 68.28% while using the IEMOCAP dataset and similar results for the CMU-MOSI model. 

#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: (30%, 30%, 30%),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 or y == 1 {(top: 1pt)} else if y == 4 {(bottom: 1pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      [Modality], [Accuracy CMU-MOSI], [Accuracy IEMOCAP],
      [T+A], [77.06%], [78.85%], 
      [T+V], [76.65%], [79.12%],
      [A+V], [70.00%], [65.44],
      [T+A+V], [80.38%], [79.52%],
    )
],
caption: [Comparison of results. A = Audio, V = Video, T = Text.]
)<table-accs>

To combine the features, they used contextual fusion in which the model trains the optimal weights for the composition.
Furthermore it shows that between text and audio, no further improvement is to be expected. Thus it presents a reliable architecture for both datasets.

*Multimodal Sentiment Analysis using Hierarchical Fusion with Context Modeling* @MAJUMDER2018124 follows a slightly similar approach to the work before. Instead of GGAs for feature extraction they used basic convolution networks trained with the IEMOCAP and CMU-MOSI databases. OpenSmile was used as a pretrained processor for audio. They present a mostly identical feature combination strategy with a fully connected layer and gated recurrent units which are used for contextual learning and to combine the features while learning the optimal weights. Overall they achieved a little less accuracy than the feature extraction with generative models but for text, video and audio in combination they recieved a score of 80.0%. Audio and video achieved 58.8%. Bimodal combinations with text got an accuracy of roughly 79% as well as the insight that there is not much room for improvement in comparison to the trimodal result. For the single model evaluation, text performed the best with an accuracy of 76.5%. The other two models bring about 50% to the evaluation which is quite low in comparison to the already presented methods.  

*Seq2Seq2Sentiment: Multimodal Sequence to Sequence Models for Sentiment Analysis* researched by Pham et al. @seq2seq2sentiment presents an architecture based on a special class from recurrent networks. The basic idea is to first train a sequence-to-sequence model for two modalities and afterwards a combination of the already trained model and the third modal to the final result. Therefore they use the CMU-MOSI dataset and a feature extraction build on different pre-trained encoders. For text input a GloVE model @pennington2014glove --- which represents its own idea of encoding besides skip-gram or bag-of-word models --- was used in lieu of an already pre-trained one. COVAREP @6853739 was used to extract multiple important features and feature representation from the audio signals and for videos a motion-based representation extraction method is proposed. Altogether they did not measure the accuracy for single modal training due to the structure of the architecture. Thus they got a score of 75% for all three modalities combined. Interesting to note are the accuracies for the bimodal detections: Text in combination with video got 78%. The other two modal permutations lay at 44% for text with audio and 55% for audio and video. According to Pham et al., the reason for these rather subpar results stem from poor video and audio feature training of the model architecture. Instead, they recommend other encoding mechanisms and a slightly different model architecture based on sequence-to-sequence for future work. #linebreak(justify: true)

*Tensor Fusion Network for Multimodal Sentiment Analysis* @zadeh2017tensor presents the method of tensor fusion for the necessary feature combination in context of the multimodality. It describes an untrainable algorithm which attemps to combine multiple tensors by a reduction to a single tensor. This results in an interplay between a recurrent and LSTM based model for each modality and the proposed tensor fusion layer. Only for text input did they show their own method for necessary feature extraction by combining LSTM cells and linear layers. Like the other works before they set their foundation for audio extraction on pretrained models like COVAREP but they combined multiple processors for different features as peak slope parameters or other high level audio information. For video they also refer to FACET as the facial expression analysis framework able to extract up to 20 action units. On to the tensor fusion layer some fully connected deep layers will learn from the combination tensor to predict the emotion. Overall they reached with their unimodal network an accuracy of 77.1%. Also here the baselines representing every single modal are bringing a high accuracy for text processing by 74.8% and lower precision for visual and acustic features with round about 66%. It outperforms the basic convolution network proposed by the first work and reaches good performance in relation to all other presented works thus being a more rare approach while using an untrainable feature combination. 

*A Social Emotion Classification Approach using Multi-Model Fusion* @XU2020347 implements a hybrid form of convolution and recurrent networks to build a context based extraction method for all three modals. For video they combine LSTM and 3D convolution to a proper time understanding model and a simpler CNN-RNN architecture and a bag-of-words for text classification. Again for the feature extraction from the audio signals they proposed OpenSmile as a relieable framework. For the subsequent feature combination they introduce multi-kernel learning @sonnenburg2006large which retrieves the result from each kernel gernerated by each modal within the CNN architecture. For comparable results they used the IEMOCAP database aswell as the MOUD dataset. It is like CMU-MOSI a collection of YouTube videos and snippets and therefore a more real-world illustration but it has over 300000 data snippets which makes it in comparison to all presented datasets really large. Therefore they got pretty relieable results and a trimodal accuracy of 95.88% with the MOUD dataset and 78.75% for IEMOCAP showing that a bigger dataset can lead to more exact results.

All in all the current works in the field of multimodal emotion detection are not showing much differences to each other. As shown in the following @tbl:table-relword the main dissimilarities are lying in the basic training architecture to train the feature combination. Thus there are mostly some kind of reccurent architectures deposited to keep track and of context bringing an important focus. Furthermore most of the current works are bringing some indistinguishable accuracys but showing that a bimodal combination of text and audio brings a nearly good result in comparison to the unimodal architectures. Also the usage of pretrained processing layers and feature extraction like FACET, GloVE and OpenSmile is highlighting which servers a huge reduction in computation and necessary preprocessing time. It should be noted that there is no research about the multimodal emotion detection featuring the leading transformer architectures which could be found. 

// https://github.com/audeering/opensmile/releases/tag/v3.0.0


#figure(
kind: table,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: (auto, auto, auto, auto, auto, 20%, auto),
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => if y == 0 or y == 1 {(top: 1.5pt)} else if y == 3 {(top: 1pt)} else if y == 7 {(bottom: 1.5pt)},
      fill: (.., y) => if calc.even(y) { luma(242) },
      [Author], [Year], [Dataset], [Architecture],[Fusion Method], [Accuracy Bimodal], [Accuracy Trimodal],
      [Vielzeuf et al. @relwork1], [2017], [WILD],[CNN], [Weighted Mean], [58.8% (A + V)], [-],
      [Majumder et al. @8321250], [2018], [IEMOCAP], [SVM], [Linear Layer], [96.6% (A + V)], [-],
      [Huddar et al. @relwork3], [2020], [IEMOCAP, CMU-MOSI], [GGA, GA, Recurrent LSTM], [Contextual Fusion], [77.06% (T + A) \ 76.65% (T + V) \ 70.00% (A + V)], [80.83%],
      [Majumder et al. @MAJUMDER2018124], [2018], [IEMOCAP, CMU-MOSI], [CNN], [Recurrent Networks], [77.30% (T + A) \ 77.80% (T + V) \ 58.80% (A + V)], [80.00%],
      [Pham et al. @seq2seq2sentiment], [2018], [CMU-MOSI], [Seq2Seq], [Hierarchical Fusion], [44.00% (T + A) \ 78.00% (T + V) \ 55.00% (A + V)], [75.00%],
      [Zadeh et al. @zadeh2017tensor], [2017], [CMU-MOSI], [LSTM], [Tensor Fusion], [-], [77.10%],
      [Xu et al. @XU2020347], [2020], [IEMOCAP, MOUD], [CNN-RNN], [Multi-kernel learning], [85.36% (T + A) \ 92.37% (T + V) \ 91.14% (A + V)], [95.5%]
    )
],
caption: [Overwiev of the compared works showing the bimodal and trimodal results. \ A = Audio, V = Video, T = Text, - = not provided / not evaluated.]
)<table-relword>