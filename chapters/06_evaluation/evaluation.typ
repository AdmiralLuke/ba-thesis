#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Conclusion

This chapter will give an overwiev over the findings of this thesis and which limitations occured during the implementation and evaluation. Further an outlook about further optimization ideas is presented.  

== Summary

To summarize it all, artifical intelligence is able to recognize emotions in different modals. Even the state-of-the-art transformer models which are introduced recently are able to keep pace with the traditional convolution architectures. However there are many challenges which have to be achieved first and some general issues which are hard to fix. 
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

