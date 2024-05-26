#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Related Work

Emotion detection is a research field which has developed much over the time. Also the comparison of multimodal emotion detection approaches and their results crystallized in the last few years. In the following chapter multiple exploration are presented with their idee and the result. Also a comparison of the different approaches will take place mostly while presenting the idea of the works.

*Temporal Multimodal Fusion for Video Emotion Classification
in the Wild* by Vielzeuf et. al. @relwork1 builds a framework on audio and visual features where it tries different combination and different scoring of the features. They use convolution models as a deep learning architecture and the OpenSmile toolkit as an audio feature extractor to retrieve supervised the six emotion from Ekman and in addition the neutral state. The visual information are extracted frame by frame and as a conecutive video whithin two different models. For training they used the Acted Facial Emotion in the Wild dataset @6200254 which consists of different movie scene and is comparable with the presented MELD dataset. In total they have an accuracy of 58.8% with the combination by a weighted mean but with no information about how they set the weights.


*Multimodal mixed emotion detection* @8321250 presents a similar method and implementation to the work presented before. Thus they create features from hand gestures and body movement aswell which are then forwarded into a support vector machine. To extract information about the visual and audio data they used premade frameworks like OpenEar and FaceAPI. Additionaly they used an infrared sensor from Microsoft for the gestures and moving parts of the body. Furthermore they classified the six Ekman emotion like the paper before but without any neutral emotion. As results they presented an accuracy of 77.5% while using data from the hand gestures, 65.2% for the body modality and 94.3% for using information from the head region. In total by combining all features they got an accuracy of 96.6% which is quite promising. Thus they are using the IEMOCAP database which is more comparable with the CREMAD database and brings more acted emotion than a more natural dataset used in the work before. Also they didn't include any feature combination with weights or other methods.




https://onlinelibrary.wiley.com/doi/abs/10.1111/coin.12274


https://github.com/audeering/opensmile/releases/tag/v3.0.0