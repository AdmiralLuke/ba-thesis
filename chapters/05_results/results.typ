#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Evaluation

This chapters presents all results for the described and discussed implementations. Therefore, a setup for the evaluation part is shown with a look on accuracy measuring functions especially the precision under recall curve. After this introduction and overview the actual results for the experiments are shown, visualized and further discussed.   

== Setup

As already explained, each model is trained on both datasets for 20 epochs and a 90/10 split in training and testing. Each epoch runs through the whole training data which is randomly shuffled every time for better and more efficient training. The preprocessing follows analogously to the implementation presented in the chapter before. The normalization of the data entries is done globally to bring the values in a uniform space between -1 and 1. Every training loop consists of the Adam optimizer and the cross entropy loss function to calculate the gradient. After this each trained model is also tested with each dataset to show if a model trained on CREMA-D is capable to detect emotion in the MELD data and the other way around. The only data which is not tested is the text data from the CREMA dataset. Due to its lack of a variety of sentences this would not be necessary. The dataset consists only of twelve different sentences in around 7000 videos. Every sentence is acted in the different emotions. It is neither learnable nor testable for the further evaluation. After this unimodal detection, all predictions for the test and trainings datasets are saved in an external dataset for the multimodal emotion classification so they do not have to evaluated each time for the three presented methods. To measure the accuracy different metrics are used. Initially as example for the text classification the precision is calculated by simply counting how many of the predictions are actually equal to the expected output. Besides it is counted how many and which emotions are wrongly labeled by the model to display a heatmap and to analyze if there are easy mix-ups between similar feature spaces. This is also repeated for each experiment. For the following sections, the calculation of the accuracy changed to a more informative and meaningful metric. 



=== Accuracy Metrics

Precision under recall describes an accuracy metric to evaluate the quality of classification tasks. It provides three scores for the comparability of the values. For the further overview it is necessary to define some variables to later understand the components of this metric.

#set list(indent: 2em)
#grid(
  columns: 3,
  gutter: 1em,
  [- $bold(T_P)$], [$->$ True Positive:], [Amount of all correctly classified values.],
  [- *$bold(T_N)$*], [$->$ True Negative:], [Amount of all correctly zero-classified values.],
  [- *$bold(F_P)$*], [$->$ False Positive:], [Amount of all falsly predicted labels],
  [- *$bold(F_N)$*], [$->$ False Negative:], [Amount of all falsly zero-classified labels]
)

Zero-classified are all labels, where the model predicted that these are not the corresponding emotion.
Out of these values, the four important metrics can be derived from this. The accuracy shows the proportion of all correctly classified labels including the quantity of all true positive and true negative classifications.

$ "Accuracy" = frac(T_P + T_N, T_P + T_N + F_P + F_N) $

By looking at the true positive values the precision of the model can be calculated. It describes the proportion of all correct classified values.

$ "Precision" = frac(T_P, T_P + F_P) $

In addition, the recall shows how accurate the model predicted the classes by looking at the true positive and false negative values.

$ "Recall" = frac(T_P, T_P + F_N) $

At last the F1-score can be calculated to measure the quality of the classification model. It describes the harmonic mean between precision and recall and is denoted by 

$ "F1-Score" = 2 dot frac("Precision" dot "Recall", "Precision" + "Recall") $



All in all these metrics are normally used for each label instead of for the whole classifier. Thus for a more clear arrangement of the results regarding the amount of different classifier and multimodal combination methods the following results are calculated for all labels in total showing the precision, accuracy, recall and quality of each classifier. Also this global observation of precision under recall helps to ignore imbalances within the datasets. This problem would otherwise occur while evaluating measurements with the MELD dataset. Furthermore the area under recall (AUC) metric describes the area under the precision-recall curve. A perfect model would have an AUC of 1, showing that the precision under recall is also always 1. In turn a completly untrained model has an AUC of 0. In general it shows how high the precision under the amount of all correct classified labels, to see if there are many misclassification, even if the model seems to have a high accuracy. 


=== Experiments 

As already discussed there are several experiments to do for an appropriate showcase of the model functionalities. After they got trained they will be evaluated using their normal test data. Each model will be tested with the MELD data as well as the CREMA data to look if these models are able to understand the data from each other without further training. The best models for each modal will be choosen for the multimodal classification which follows the same testing procedure as before. As presented in the previous chapter, the training for an output fusion with a simple neural network, major voting system and the brute-force approach are simulated and evaluated. The following listing summarizes the following experiments:


#set list(indent: 2em)
#grid(
  columns: 2,
  gutter: 1em,
  [- *Experiment 1:*], [Unimodal emotion detection in *text* with MELD],
  [- *Experiment 2:*], [Unimodal emotion detection in *audio*, trained on each dataset and tested each permutation.],
  [- *Experiment 3:*],[Unimodal emotion detection in *video*, trained on each dataset and tested each permutation.],
  [- *Experiment 4*], [Multimoda emotion detection by *label fusion* with the three presented methods: Neural Network, Brute-Force and Major Voting]
)




== Results

#section("Experiment 1 - Unimodal Results for Classification in Text")

#figure(
kind: table,
align(center)[
    #set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => {
        if y == 0 or y == 2 {
          (top: 1.5pt)
        } else if y == 1 {
          (top: 1pt)
        } else if y == 4 {
          (bottom: 1.5pt)
        }
      },
      table.cell(rowspan: 2)[], table.cell(colspan: 4)[*CREMA-D*], table.cell(colspan: 4)[*MELD*],
      
      [Accuracy], [Precision], [Recall], [F1],  [Accuracy], [Precision], [Recall], [F1],  
    
      [Llama], [nA], [nA], [nA], [nA], [0.372], [0.546], [0.372], [0.385],
      [Multi-EmoBert], [nA], [nA], [nA], [nA], [*0.603*], [*0.594*], [*0.603*], [*0.597*],
      [T5], [nA], [nA], [nA], [nA], [0.559], [0.581], [0.556], [0.559],
    )
],
caption: [Accuracy for unimodal emotion classification in text.]
)<fig-accs_text>

As noted in @tbl:fig-accs_text it was not possible to measure the accuracy, precision and other metrics for the CREMA-D dataset within the text data. This results from the usage of the same sentence for each emotion. Therefore they change the emotionaly meaning every time so the model is unable to correctly learn any features from the given training set. Fortunately some results are achieved with the MELD dataset, which features a high variety of different sentences. The only prompt-driven model, Llama performes the worst of all three models with only 37% accuracy which still performed better than just guessing ($1/7 = 14.3% "accuracy"$) the right emotion. Here the model mostly tried to predict other emotion instead of neutral, leading to a high misclassification rate in every given label which is hightlighted by (b) in @fig:fig-text_pcr. Llama oftenly predicts happiness wrong which shows that it interprets the sentences most of the time as an happier atmosphere showing the missing understanding of the dataset although the context is presented by the prompt before. 
Continuing with the Multi-EmoBERT model, this architecture performed the best with a small gap to T5. A further look at @fig:fig-text_pcr, especially at (c) and (d), shows that the neutral emotion was still the best learned emotion and is also the most common emotion in the MELD dataset. However in contrast to Llama, EmoBERT showed in total better results in every category.
The precision-recall curve in (c) notes that fear was learned and classified not well at all, but as showcased in the heatmap distribution from (d) it is still a result from the imbalance of the dataset.  Here, fear was misclassified the most but there were only around 100 samples in the test dataset while nearly a third was labeled as neutral. All other emotions are aligned as good as fear and neutral to the distribution in the MELD data. It is important to note, that all of the three models, especially EmoBERT are always guessing different emotions even though they will have high accuracy by only classifying the sentences as neutral. This problem will occur again in the video and audio detection. With almost equal results T5 shows mostly similar behavior in training and testing, however the small differences are visible in the emotion with less occurence. In comparison to EmoBERT, nearly every other sentiment was misclassified more often, however, these amounts are also very small. Interestingly, the T5 model was able to label sadness a bit more accurately than every other presented text model which can be an influence of the small yet existing architecture differences and the difference in data for pretraining the weights. The most visible contrast between the two models can be found in the fear and disgust emotion. As shown, the T5 model tries to classify fewer sentences as a further result of the imbalance from MELD data. Llama struggles the most as it is unable to identify the structure of the dataset. In this case it shows the high difference between actual training of the weights and the use of a possible small context memory in these architectures. To look at similarities between the three architectures, both T5 and EmoBERT are able to differentiate perfectly between disgust and fear while it is the only emotion without any misclassification. As these are very rare labels in the given dataset this can be a random occurence.  

Overall, it can be observed that text classification models for emotion detection can be a good choice in some cases. Generally these large and public models like Llama3 or ChatGPT, which are seen as the state-of-art tools for nearly every problem, are not able to correctly recognize the correct sentiment even with much context. However, it is currently not publically available how much context these models can handle, store and use, or if most of the given input was mostly ignored by the architecture. In comparison, the directly trained models like EmoBERT and T5, where the user has a chance to fully integrate the context into the given weights, are more suitable for these problems. Nonetheless they are in most cases only able to detect emotion from the specific dataset due to the dependencies within the data. In fact MELD offers only quite specific sentences with many insider words and important context from the series where it finds its origin. While looking at the tokenizer and encoder, there are mostly names from character and specific insider words from this TV-show available. Therefore the model is able to understand the emotional context from this series but it would struggle with for example sentences from a normal conversation. As it turned out later, they will easily overfit while training each model. This could also be the case here but could not be further evaluated due to the lack of necessary data. The approach to detect emotion within the CREMA-D dataset shows that there are no specific rules for a general classification. There are many sentences with different meanings as stated earlier in the background. Every human-made statement and even statements by artifical intelligence can include irony or can be acted differently. It should be nearly impossible to find general patterns to reduce overfitting by a large scale as text-based emotion detection must always look at the context from the full conversation. #linebreak(justify: true)

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/llama_pcr.svg"),
        [(a) Precision-Recall Curve for Llama3]
      )
    ],
    [
      #stack(
        image("heatm/llama_hm.svg"),
        [(b) Heatmap classification distribution for Llama3]
      )
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_emobert_pcr.svg"),
        [(c) Precision-Recall Curve for EmoBERT]
      )
    ],
    [
      #stack(
        image("heatm/meld_emobert_hm.svg"),
        [(d) Heatmap classification distribution for EmoBERT]
      )
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_t5_pcr.svg"),
        [(e) Precision-Recall Curve for T5]
      )
    ],
    [
      #stack(
        image("heatm/meld_t5_hm.svg"),
        [(f) Heatmap classification distribution for T5]
      )
    ],
    
  ),
  caption: [Text-Models: Precision-Recall Curve for each label and heatmap distribution from testing and training with the MELD dataset]
)<fig-text_pcr>

#pagebreak()

#section("Experiment 2 - Unimodal Results for Classification in Audio")

#figure(
kind: table,
gap: 15pt,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      
      stroke: (.., y) => {
        if y == 0 or y == 2 {
          (top: 1.5pt)
        } else if y == 1 {
          (top: 1pt)
        } else if y == 5 {
          (bottom: 1.5pt)
        } else if y == 4 {
          (top: 0.5pt)
        }

      }  
        ,

      table.cell(rowspan: 2)[], table.cell(colspan: 4)[*CREMA-D*], table.cell(colspan: 4)[*MELD*],
      [Acc.], [Precision], [Recall], [F1], [Acc.], [Precision], [Recall], [F1],

      [$"Conv. (C)"$], [*0.409*], [*0.449*], [*0.409*], [*0.387*], [0.143], [0.021], [0.143], [0.036], 
      [$"Transf. (C)"$], [*0.463*], [*0.456*], [*0.463*], [*0.427*], [0.151], [0.024], [0.151], [0.039],
      [$"Conv. (M)"$], [0.115], [0.042], [0.115], [0.046], [*0.478*], [*0.223*], [*0.478*], [*0.309*],
      
      [$"Transf. (M)"$], [0.134], [0.051], [0.134], [0.055], [*0.461*], [*0.213*], [*0.461*], [*0.291*], 
  
    )
],
caption: [Accuracy for unimodal emotion classification in audio trained on each dataset. \ (C) = tested with CREMA, (M) = tested with MELD]
)<fig-accs_audio>

@tbl:fig-accs_audio summarizes the evaluation results for emotion classification in audio data. The first look shows, that it perfomed not as good as the text models, however they still reach nearly 50% accuracy. Starting with the convolution models, tested on data from the CREMA-D dataset, @fig:fig-audio_crema_c visualizes the performance of the architecture trained on each set. The heatmap in (b) shows that there are many misclassifications within the CREMA-trained model. In addition while looking at (a), it was able to classify the strong emotions like anger and sadness are detected way better than the sentiments which are not as present in voice as expected. 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_cr_audio_c_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_cr_audio_c_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on CREMA]
      )
    ]),
    caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio convolution based network with CREMA-D and tested with the same dataset.]
)<fig-audio_crema_c>


Further the model struggles with the correct labeling of neutral while annotating actual emotions which normally should contains features. In total it achieved 41% accuracy with nearly 45% precision. In comparison, the MELD model struggles with the CREMA data. 
Here it classifies only neutral for every data entry which is underlined by (a) from @fig:fig-audio_meld_crema_c. This problem originates in the actual training with MELD due to the imbalance of the dataset. As shown in (b), the precision-recall curves for each corresponding emotion are overlapping a lot, showing that there were no features analyized by the architecture. Only surprise is not part of the pattern as it is not featured in the CREMA-D dataset.   


#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_cr_audio_c_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_cr_audio_c_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio convolution based network with MELD and tested with the CREMA dataset.]
)<fig-audio_meld_crema_c>

For comparison, the MELD model achieved only 14% accuracy, which is equal to a result which could be obtained by randomly guessing the label. Also the low precision of 2% shows that there was nearly no classification done by the architecture. While testing with the MELD dataset, interesting results can be observerd. As shown in @fig-audio_meld_c, the corresponding model which is trained on the same data, still predicted neutral every time due to the imbalance. This is verified by (a) where neutral has an AUC score of 0.74 instead of the expected 0.5, showing that even the test dataset is imbalanced and contains mostly one label. Therefore, there are less misclassifications and the model achieved an accuracy of 48% but with a low precision of only 22%. This shows, that most of the time a model tries to increase only the accuracy --- in general to minimize the loss --- without further notice about the actual precision. Meanwhile, the CREMA-D trained model overfitted and nearly only guessed anger as it is the most learned emotion as shown in (d). However (c) shows, that there also are many misclassifications within the testing. There are four emotion which are never classified by the CREMA convolution model but as three of them are quite rare in the MELD dataset, they have a low AUC score. Again neutral is outstanding from the other results as it has no misclassifications. These values are also represented in the low accuracy of 11.5% and a much lower precision of 4.2%. This is even worse than just randomly guessing the correct label, showing that the emotion detection is dataset-specific and not generally applicable.



#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_audio_c_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_audio_c_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on MELD]
      )
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_me_audio_c_pcr.svg"),
        [(c) Precision-Recall Curve, \ trained on CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_me_audio_c_hm.svg"),
        [(d) Heatmap classification distribution, \ trained on CREMA]
      )
    ]),
    caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio convolution based network and tested with the MELD dataset.]
)<fig-audio_meld_c>

The transformer models are showing mostly the same behavior as the convolution moarchitectures but with a small bit of improvement in the scores. First of all, the plots for testing the models with the respective other dataset are similar to before. MELD again just predicts for neutral and CREMA-D overfits and tries to label anger most of the time. Even for the normal testing with the same dataset for each trained transformer, a similar behavior to the convolution models can be observed. As before, CREMA-D was able to recognize various emotion especially anger as it seems to be the clearest sentiment which can be recognized in the voice as shown in @fig:fig-audio_crema_t. In general, this model achieved 5% more accuracy and up to 10% increase in precision than the convolution model. The heatmap in (b) shows that there are less misclassifications, which verifies a better training. For MELD it performed the same with around 50% accuracy and the same low precision. This is again a result of the permanent and constant labeling to neutral as shown in @fig:fig-audio_meld_t. 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_cr_audio_t_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_cr_audio_t_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on CREMA]
      )
    ]
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio transformer based network and tested with the CREMA-D dataset.]
)<fig-audio_crema_t>


#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_audio_t_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_audio_t_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio transformer based network and tested with the MELD dataset.]
)<fig-audio_meld_t>

#pagebreak()
#section("Experiment 3 - Unimodal Results for Classification in Video")


 
#figure(
kind: table,
gap: 15pt,
align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      
      stroke: (.., y) => {
        if y == 0 or y == 2 {
          (top: 1.5pt)
        } else if y == 1 {
          (top: 1pt)
        } else if y == 5 {
          (bottom: 1.5pt)
        } else if y == 4 {
          (top: 0.5pt)
        }

      }  
        ,

      table.cell(rowspan: 2)[], table.cell(colspan: 4)[*CREMA-D*], table.cell(colspan: 4)[*MELD*],
      [Acc.], [Precision], [Recall], [F1], [Acc.], [Precision], [Recall], [F1],

      [$"Conv. (C)"$], [*0.749*], [*0.747*], [*0.747*], [*0.742*], [0.154], [0.024], [0.154], [0.041], 
      [$"Transf. (C)"$], [*0.544*], [*0.577*], [*0.544*], [*0.539*], [0.146], [0.021], [0.146], [0.037],
      [$"Conv. (M)"$], [0.295], [0.049], [0.295], [0.043], [*0.473*], [*0.223*], [*0.473*], [*0.303*], 
      [$"Transf. (M)"$], [0.219], [0.057], [0.219], [0.057], [*0.472*], [*0.223*], [*0.472*], [*0.303*], 
  
    )
]
,
caption: [Accuracy for unimodal emotion classification in video trained on each dataset. \ (C) = tested with CREMA, (M) = tested with MELD]
)<fig-accs_video>


Looking at the results for classification in audio, these results are quite similar. However, there was one architecture which performed with great accuracy. Visible in the following @tbl:fig-accs_video the models are still struggeling with the imbalance of the MELD dataset. As for audio classification it was the most efficient way to only predict the neutral emotion while always achieving a high accuracy of around 47%. However the precision of only 20% and the low F1-score are still showing this problem underlined by the visualization in @fig:fig-video_meld_c and @fig:fig-video_meld_t. Just as they look similar to each other, they are also alike to the figures from the training of all audio models with MELD. All other emotion except neutral are untrained thus the model never learned features from the video input and only trained to guess neutral. #linebreak(justify: true) 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_video_c_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on MELD.]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_video_c_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on MELD.]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video convolution based network and tested with the MELD dataset.]
)<fig-video_meld_c>

Also similar to emotion detection in audio, the presented models are still overfitting due to the lack of uniform datasets. Even though the preprocessing tried to bring the videos to a similar level with the active speaker detection and cropping, there are still many artefacts. The TV series character from MELD features many movements from the head of the acting person which is not present in the CREMA data where the face is always looking directly straight into the camera. These effects can also be seen in @tbl:fig-accs_video. As in audio, the precision for each model tested with the data set with which it was not trained is really low with under 6%. Although the accuracy for the MELD trained models reaches the value, which is expected for guessing one of the seven emotion. For this reason the plots are not shown for the cross-testing as they will look the same as (c) and (d) from @fig:fig-video_meld_c  or any figure from audio detection. 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_video_t_pcr.svg"),
        [(a) Precision-Recall Curve, \ trained on MELD.]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_video_t_hm.svg"),
        [(b) Heatmap classification distribution, \ trained on MELD.]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video transformer based network and tested with the MELD dataset.]
)<fig-video_meld_t>

The higher results from the CREMA-D trained models are more interesting. Again the overview in  @tbl:fig-accs_video shows that the convolution architecture achieved an accuracy of nearly 75% which is the highest score achieved by any model so far. @fig:fig-video_crema_c shows in (b), that the diagonal with the correct classified emotion is highlighted. This correlates with a good classification. There are still some misclassification, mostly for anger and fear as well as fear with sadness and anger with sadness which are sharing many facial features. As before, the CREMA dataset did not include any samples with surprise so there were no evaluation for this label possible. 

The graphical representation of the precision-recall curve in (a) from @fig:fig-video_crema_c desribes that the model performed best with happy and closely followed by disgust. Due to the overacting by the people which are shown in the video samples, both emotions are cleary differentiable from each other. Followed by this explanation that the model looks mostly at the strong shown features from the faces, neutral performed much worse than the two other well learned emotions due to this sentiment should not cover any features.  Furthermore, sadness performed the worst out of all of the six labels due to multiple misclassifications with fear and anger as they differ mostly in one or two features. Corresponding to Ekmans Facs system which was explained before, all three emotion share all information around the eyes and they are only differentiable by the lower part of the face. The convolution model might lay its focus more on the upper half which can lead to this kind of training and testing behavior. 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_cr_video_c_pcr.svg"),
        [(a) Precision-Recall Curve for CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_cr_video_c_hm.svg"),
        [(b) Heatmap classification distribution for CREMA]
      )
    ]

  ),
  caption: [Precision-Recall Curve and their heatmap distribution from training on an video convolution based network and tested with the CREMA-D dataset.]
)<fig-video_crema_c>

Nearly the same observations can be found within the transformer model. Visible in (b) from @fig:fig-video_crema_t the diagonal line with the correct classified labels is still existing and clearly recognizable. However there are also quite a lot of misclassified outliers, mostly where the actual label is anger, sadness and fear. This problem follows the explanation about the convolution model but is more visible. It shows that the model did not learn the correct features as fast as the convolution model which can be a result due to the difference in the amount of trainable parameters. With more time in training which was not possible due to the limitations in this thesis, the model could achieve the same results as from the convolution model.

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_cr_video_t_pcr.svg"),
        [(a) Precision-Recall Curve for CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_cr_video_t_hm.svg"),
        [(b) Heatmap classification distribution for CREMA]
      )
    ]

  ),
  caption: [Precision-Recall Curve and their heatmap distribution from training on an video transformer based network and tested with the CREMA-D dataset.]
)<fig-video_crema_t>

 Looking at (a) from @fig:fig-video_crema_t it is still clear that happiness was well learned, followed by disgust. The other emotions show that there is more proper training missing, to differentiate between the smaller yet important features. 

 In total, there are some facial features which can be learned by neural networks or similar deep learning architectures. However, there are still many problems with the existing datasets as there is no standard or good comparability between each other. This leads to the described overfitting effect which was found in every modal yet since there are different artefacts like shaking heads or other disturbances. With better active speaker recognition, artifical camera stabilization or interpolation to clean up bad frames there are many possibilities to improve and generalize these models within video based emotion detection.



#section("Experiment 4 - Multimodal Results")

For multimodal evaluation the best model of each modal was picked, as it is not necessary to test the same experiment with less precise results but identically trained models. For MELD the EmoBERT model, the audio convolution and the video convolution architecture are chosen. As there are no metrics and trained text models for CREMA-D, only the audio transformer and video convolution models are used for the multimodal evaluation. To simulate the missing results from text detection a random label is picked for each sentence. Without a third modal the major vote strategy would not work properly. @tbl:fig-accs_mm presents the results of the multimodal experiment for each dataset. In general it can be observed that none of the three label combination methods brought any optimization or any higher accuracy or precision. Starting with CREMA-D, the major vote algorithm performed not as good as expected. With only 25% accuracy it is still better than random voting for a label. Though, looking at the voting options for each label there are many disagreements within the three models.

#figure(
kind: table,
align(center)[
    #set text(hyphenate: false)
    #set par(justify: false)
    #table(
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      stroke: (.., y) => {
        if y == 0 or y == 2 {
          (top: 1.5pt)
        } else if y == 1 {
          (top: 1pt)
        } else if y == 4 {
          (bottom: 1.5pt)
        }
      },
      table.cell(rowspan: 2)[], table.cell(colspan: 4)[*CREMA-D*], table.cell(colspan: 4)[*MELD*],
      
      [Accuracy], [Precision], [Recall], [F1],  [Accuracy], [Precision], [Recall], [F1],  
    
      [Neural Network], [*0.759*], [*0.758*], [*0.756*], [*0.751*], [0.470], [0.066], [0.142], [0.090],
      [Brute Force], [0.735], [0.737], [0.736], [0.730], [*0.603*], [*0.594*], [*0.603*], [*0.597*],
      [Major Voting], [0.252], [0.273], [0.250], [0.243], [0.471], [0.067], [0.142], [0.092],
    )
],
caption: [Accuracy for multimodal emotion classification.]
)<fig-accs_mm>

As the audio and video convolution architectures are having a big gap in accuracy of around 30%, there are many labels which are misclassified, leading to the bad voting. In addition to the random annotions to simulate the text classification, there might be a bias where the majority votes for a false positive result. The brute-force algorithm shows, that the weights are mostly given to the video convolution model as it has the highest accuracy out of all three modals. Further, it shows that there are little to no supplementary labels in each unimodal prediction. Therefore, it is the most accurate to do the prediction only with the video model results. The neural network achieved a higher accuracy of 1-2% in total, which is nevertheless very low. It can be the case that the model learned to predict emotions like neutral whenever all three modals are contradicting to each other. However this is also just a rare case or the model is predicting to a not neutral label whenever this case occurs. #linebreak(justify: true)

In contrast to the CREMA-D results, MELD is following most of the behavior of the unimodal evaluation. The neural network is still always predicting the neutral emotion. As before, it achieves an accuracy of around 50% due to the imbalance of the dataset. Followed by this, major voting also only results in neutral. Two of the tree models are continuously calling for the same emotion. Only the text model was able to predict a variety of emotion. Here the brute-force approach also puts all weights on this single modal, as it was the case with CREMA-D. Therefore the results are mostly similar to these from the emotion detection in text with the EmoBERT architecture.

Generally these three multimodal combination are not optimal for this case. Label fusion is a hard task and generally profits from models where different labels are classified true positive and complement each other. It can profit from architectures like mixture of experts, where the same model is trained multiple times in parallel to possible learn different features every time. With a higher amount of labels for major voting or the neural network, better decision could be drawn. Looking back at the related work, Vielzeuf et al. @relwork1 used weighted mean as a kind of label combination and also only achieved an accuracy of 50%. In comparison to the other presented works, they achieved higher accuracy with feature combination within the architectures. Here it will be part of future work while this technique will require more access to different model layers. As the three modals are acting more like a black box with finetuned output heads, it exceeds the scope of this thesis due to the need of building an accessable clone of these architectures and pretrain them first under the same conditions.  