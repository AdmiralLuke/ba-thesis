#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Conclusion

This chapter will give an overview over the findings of this thesis and which limitations occured during the implementation and evaluation. Further an outlook about further optimization ideas is presented.  

== Summary

The background of this thesis discussed mutliple approaches for emotion detection in the three given modals and where different features can be obtained. There are a lot of supervised and also unsupervised architectures which could lead to promising results. Mostly theses ideas are based on neural network architectures --- convolution, recurrent and transformer models --- or based on similar machine learning algorithms. Further both datasets, CREMA-D and MELD are introduced. CREMA-D is a scientific dataset with a static view angle on the actors face. The drawback stands from the usage of only twelve different sentences, distributed in 7,000 videos. MELD is extracted from the TV-show "Friends" and shows short clips with multi-conversation input and many other challenges. Here the drawback origins from a high imbalance within the labels. 

Related work showed that many approaches with neural networks and machine learning are already implemented. These are also commonly based on convolution or variations of recurrent networks. Only any implementations with transformer architectures could not be found yet. Furthermore, the contributions are explaining multiple approaches for feature combination to achieve high accuracy in multimodal emotion detection.

The own implementation starts with three pre-trained text models: Llama 3, Multi-EmoBERT and T5. The chapter explained that it is necessary to feed the context for each dataset in to these architectures. Llama accepts only some way of prompt engineering as a chat like option. EmoBERT and T5 are offering an interface for further training of the weights. Additionally, the feature extraction method for emotion understanding in audio was discussed. OpenSmile offers an extraction of many details and metrics about the audio, based on fourier transformation. Therefore information like loudness or voice intensity were extracted. For both, audio and video detection, the convolution and transformer architecture are shown. Additionally for video, further preprocessing was implemented where the videos are cropped down on to the active speaker. This was necessary due to the different video and camera formats from each dataset.

To summarize the results: artifical intelligence is able to recognize emotions in different modals. Even the state-of-the-art transformer models which are introduced recently are able to keep pace with the traditional convolution architectures. However there are many challenges which have to be achieved first and some general issues which are hard to fix. 
The first challange starts with the understanding of famous models like ChatGPT or Llama which are used every day from many people. This thesis shows that there is many context necessary for more precise predictions which is only conditionally realizable. These contextual dependencies are also existing for every other model, so it is nearly impossible to build an architecture to classify emotion in every scenario. In this case overfitting within each architecture was observed in every evaluation step. Emotions can be detected but the theories by Ekman or other psychologists are not universal rules. At the end these patterns are differ from person to person, sometimes more and sometimes less. 

Another finding is the interesting fact, that every modal is important for a multimodal evaluation. As stated in the motivation, there might be at least one modal which could not deliver important information to the multimodal result. The evaluation shows, that there are always useable features within each modal which brings more than 50% accuracy. Even though audio classification did not brought any benefits to the label combination it might bring advantages to a possible feature combination method.

In comparison with the presented related works, the models performed quite well with up to over 70% accuracy. Although this should be considered with caution due to the missing comparability within the used datasets and the presented model architectures. 

// für jedes Kapitel kurz Zusammenfassen -> Struktur der Arbeit kurz 

== Limitations

The biggest limitation is brought by the datasets themself. Mostly MELD shows that there are no unified standards for these kind of multimodal collections. There are high imbalances in the data distribution and no unified camera positions, audio recording types and other points to make them comparable to each other. Further limitation are also available due to time constraints. Normally these large models will train up to several months for better usability and reliable results. However the scope of this thesis only allowed to train on short time although the results are still representing the foundings as presented before.  

== Future Work

As presented by Picard in his book "Affective Computing" @GBV-233416889 the research about emotion detection is still a big topic with many interesting optimization approaches. There exists much more modals than just text, video and audio. Nowadays wearables like smart watches, smart glasses or other devices are able to precisely measure information like blood pressure, heart rate or even directly calculate a stress level. These features can also be used to detect emotion as for example a higher or lower pulse rate might stand for calm and agressive emotions. Also the raw environment around the person, like the weather or the atmosphere brought by the surroundings can be used as valuable features. 

Furthermore, experiments with feature combination could bring quite better results and offers a high variety of optimization and different approaches. As explained before there are more insights in the given model architectures needed to provide an interface to early combine necessary information.

To avoid further limitations with the datasets, defining standards and important needs for better comparability between emotion detection approaches. The challenges occur when finding as many data to satisfy large architectures and when finding valuable annotations for supervised learning. This can be done first with unsupervised learning but still needs manual correction by at minimum one person. However even for humans, it is hard to find the one correct emotion for each data entry.

At last, a just-in-time emotion detection offers high potential for application in job interviews or better interaction with non-human devices. Therefore, further improvements in the computation time are necessary.

