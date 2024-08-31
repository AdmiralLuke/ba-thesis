#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Evaluation

This chapters presents all results for the described and discussed implementations. Therefore the setup for the evaluation part is shown with a look on accuracy measuring functions especially the precision under recall curve. After this introduction and overwiev the actual results for the experiments are shown, visualized and further discussed.   

== Setup

As already explained each model is trained on both datasets for 20 epochs and a 90/10 split in training and testing. Each epoch runs through the whole training data which is randomly shuffled every time for better and more efficient training. The preprocessing follows analogous the implementation presented in the chapter before. The normalizaion is done globally to bring the values in an uniform space between -1 and 1. Every training loop consists of the Adam optimizer and the cross entropy loss function to calculate the gradient. After this each trained model is also tested with each dataset to show if a model trained on CREMA-D is capable to detect emotion in the MELD data and the other way around. The only data which is not tested is the text data from the CREMA dataset. Due to its lack of a variety of sentences it is not necessary. It consists of only twelve different sentences in around 7000 videos. Every expression is actored in the different emotion. So it is neither learnable nor testable for the further evaluation. After this unimodal detection all predictions for the test and trainings datasets are saved in an external dataset for the multimodal emotion classification so they must not be runned each time for the brute-force, neural network or major vote approach. To measure the accuracy different metrics are used. Initially as example for the text classification the precision is calculated by simply counting how many of the predictions are actually equal to the expected output. Besides it is counted how many and which emotion are wrongly labeled by the model to display a heatmap and to analyze if there are easy mix-ups between similar feature spaces. This is also continued for each test scenario. Thus the calculation of the accuracy changed to a more informative and meaningful metric. 



=== Accuracy Metrics

Precision under recall describes an accuracy metric to evaluate the quality of classification tasks. It provides three scores for the comparability of the values. For the further overview it is necessary to define some variables to later understand the components of this metric.

#set list(indent: 2em)
#grid(
  columns: 3,
  gutter: 1em,
  [- $bold(T_P)$], [$->$ True Positive:], [Amount of all correct classified values.],
  [- *$bold(T_N)$*], [$->$ True Negative:], [Amount of all correct unclassified values.],
  [- *$bold(F_P)$*], [$->$ False Positive:], [Amount of all falsly predicted labels],
  [- *$bold(F_N)$*], [$->$ False Negative:], [Amount of all falsly unpredicted labels]
)

Out of these values the four important metrics can be derived from this. The accuracy shows the proportion of all correct classified labels including the quantity of all true positive and true negative classifcations.

$ "Accuracy" = frac(T_P + T_N, T_P + T_N + F_P + F_N) $

Further while only looking at the true positive values the precision of the model can be calculated. It describes the proportion of all correct classified values.

$ "Precision" = frac(T_P, T_P + F_P) $

In addition the recall shows how accurate the model predicted the classes by looking at the true positive and false negative values.

$ "Recall" = frac(T_P, T_P + F_N) $

At last to measure the quality of the classifcation model the F1-score can be calculated. It describes the harmonic mean between precision and recall and is denoted by 

$ "F1-Score" = 2 dot frac("Precision" dot "Recall", "Precision" + "Recall") $

All in all these metrics are normally used for each label instead of for the whole classifier. Thus for a more clear arrangement of the results regarding the amount of different classifier and multimodal combination methods the following results are calculated for all labels in total showing the precision, accuracy, recall and quality of each classifier. Also this global observation of precision under recall helps to ignore imbalances within the datasets. This problem would otherwise occur while evaluating measurements with the MELD dataset. Furthermore the area under recall (AUC) metric describes the area under the precision-recall curve. A perfect model would have an AUC of 1, showing that the precision under recall is also always 1. In turn a completly untrained model has an AUC of 0. In general it shows how high the precision under the amount of all correct classified labels, to see if there are many missclassification although the model seems to have a high accuracy. 


=== Experiments 

As already discussed there are several experiments to do for an appropiate showcase of the model functionalities. After they got trained they will be evaluated with their normal test data. Each model will be tested with the MELD data as well as the CEMA data to look if these models are able to understand the data from each other without further training. Additionaly on some models the weighted focus will be shown on some examples to visualize the extracted features. The best models for each modal will be choosen for the multimodal classification which follows the same testing procedure as before. As presented in the chapter before, the training for an output fusion with a simple neural network, major voting system and the bruteforce approach are simulated and evaluated.  





== Results

#section("Unimodal Results for Classification in Text")

As noted in @tbl:fig-accs_text it was not possible to measure the accuracy, precision and other metrics for the CREMA-D dataset with in the text data. This results from the usage of the same sentence for each emotion. Therefore they change the emotionally meaning every time so the model is unable to correctly learn any features from the given training set. Fortunately some results are achieved with the MELD dataset, which features a high variety of different sentences. Starting with the worst performance of the three given models, Llama still performed better than just guessing ($1/7 = 14.3% "accuracy"$) the right emotion. However it shows that the contextual understanding from the chat conversation will not be enough to finetune this architecture. In comparison both real-trained models, EmoBert and T5, perfomed quite better with more than 50% precision and accuracy. Beginning with the only prompt-driven model, LLama performes the worst from all three models with only 37% accuracy. Here the model mostly tried to predict other emotion instead of neutral, leading to a high missclassification rate in every given label which is hightlighted by (b) in @fig:fig-text_pcr. Llama oftenly predicts happiness wrong which shows that it interprets the sentences most of the time as an happier atmosphere showing the missing understanding of the dataset although the context is presented by the prompt before. 

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

Continuing with the Multi-EmoBERT model, this architecture performed the best with a small gap to T5. Further looking at @fig:fig-text_pcr, especially at (c) and (d) the neutral emotion still performed and was learned the best at it is also the most common emotion in the MELD-dataset. However in contrast to Llama, EmoBERT showed in total better results in every category. Further it visualizes the imbalance of the data distribution. 
The precision-recall curve in (c) notes that fear was learned and classified not well at all. But as showcased in the heatmap distribution from (d) it is still a result from the imbalance of the dataset.  Here the fear was missclassified the most but there were only around 100 samples in the test dataset where nearly a third was labeled as neutral. All other emotions are aligned as well as fear and neutral to the distribution in the MELD data. Important to note is the fact that all of the three models, especially EmoBERT are always guessing different emotion even though they will have a high accuracy while only classify every sentence as neutral. This problem will occur again in the video and audio detection. With almost equal results T5 shows mostly similar behavior in training and testing, however the small differences are visible in the emotion with less occurence. In comparison to EmoBERT nearly every other sentiment were missclassified more often thus these amounts are also very small. Interestingly the T5 model was able to label sadness a bit more accurate than every other of the text models which can be a feature from the small yet existing architecture differences and the different datasets for pretaining the weights. The most visible contrast between the two models can be found in the fear and disgust emotion. Here the T5 model tries to classify fewer sentences than these as a further result of the imbalance from MELD data. Llama struggles the most as it is unable to identify the structure of the dataset. In this case it shows the high difference between actual training of the weight and the use of a possible small context memory in these architectures. To look at similarities between the three architectures, both T5 and EmoBERT are able to differ perfectly between disgust and fear while it is the only emotion without any missclassification. As these are very rare labels in the given dataset this can be a random occurence.  

In total it is showed that text classification models for emotion detection can be suitable in some cases. Generally these large and public models like Llama3 or ChatGPT which are seen as the state-of-art tools for nearly every problem, are not able to correctly recognize the correct sentiment even with many context. However it is currently not public how much context these models can handle, store and use, or if most of the given input was mostly ignored by the architecture. In comparison the directly trained models like EmoBERT and T5, where the user has a chance to fully integrate the context into the given weights, are more suitable for these problems. Nonetheless they are in most cases only able to detect emotion from the specific dataset due to the dependencies with in the data. In fact MELD offers only quite specific sentences with many insider and important context from the series where it finds its origin. While looking at the tokenizer and encoder, there are mostly names from character and specific insider words from this TV-show available. Therefore the model is able to understand the emotional context from this series but it would struggle with for example sentences from a normal conversation. Also shown later is very easy overfitting while training each model. This could also happened here but could not be further evaluated due to the lack of necessary data. The approach to detect emotion within the CREMA-D dataset shows that there are no specific rules for a general classification. There are many sentences with different meanings as stated earlier in the background. Every human-made statement and even statements by artifical intelligence can include irony or can be acted differently. It should be nearly impossible to find general patterns to reduce overfitting by a large scale as text-based emotion detection must always look at the context from the full conversation.  

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

#section("Unimodal Results for Classification in Audio")

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
      [$"Transf. (C)"$], [*0.463*], [*0.456*], [*0.463*], [*0.427*], [], [], [], [],
      [$"Conv. (M)"$], [0.115], [0.042], [0.115], [0.046], [*0.478*], [*0.223*], [*0.478*], [*0.309*],
      
      [$"Transf. (M)"$], [], [], [], [], [*0.461*], [*0.213*], [*0.461*], [*0.291*], 
  
    )
],
caption: [Accuracy for unimodal emotion classification in audio trained on each dataset. \ (C) = tested with CREMA, (M) = tested with MELD]
)<fig-accs_audio>

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_cr_audio_c_pcr.svg"),
        [(a) Precision-Recall Curve for CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_cr_audio_c_hm.svg"),
        [(b) Heatmap classification distribution for CREMA]
      )
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_cr_audio_c_pcr.svg"),
        [(c) Precision-Recall Curve for MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_cr_audio_c_hm.svg"),
        [(d) Heatmap classification distribution for MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio convolution based network and tested with the CREMA-D dataset.]
)<fig:audio_crema_c>

#lorem(80)

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_me_audio_c_pcr.svg"),
        [(a) Precision-Recall Curve for CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_me_audio_c_hm.svg"),
        [(b) Heatmap classification distribution for CREMA]
      )
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_audio_c_pcr.svg"),
        [(c) Precision-Recall Curve for MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_audio_c_hm.svg"),
        [(d) Heatmap classification distribution for MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an audio convolution based network and tested with the MELD dataset.]
)<fig:audio_meld_c>

#pagebreak()
#section("Unimodal Results for Classification in Video")


 
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


Similar to the results for classifcation in audio, these results are aligning mostly the same as before. Thus there was one architecture which performed with a great accuracy. Visible in the following @tbl:fig-accs_video the models are still struggeling with the imbalance of the meld dataset. As for audio classifcation it was the most efficient way to only predict the neutral emotion while always bringing an high accuracy of around 47%. However the precision of only 20% and the low F1-score are still showing this problem underlined by the visualization in @fig:fig-video_meld_c and @fig:fig-video_meld_t. Just as they look similar to each other, they are also alike to the figures from the training of all audio models with MELD. All other emotion except neutral are untrained thus the model never learned features from the video input and only trained to guess neutral. #linebreak(justify: true) 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_video_c_pcr.svg"),
        [(a) Precision-Recall Curve for MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_video_c_hm.svg"),
        [(b) Heatmap classification distribution for MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video convolution based network and tested with the MELD dataset.]
)<fig-video_meld_c>

Also similar to emotion detection in audio, the presented models are still overfitting due to the lack of uniform datasets. Even though the preprocessing tried to bring the videos to a similar level with the active speaker detection and cropping, there are still many artefacts. The TV series character from MELD features many movements of the head from the acting person which is not present in the CREMA data where the face is always looking directly straight into the camera. These results can also be seen in @tbl:fig-accs_video. As in audio, the precision for each model tested with the data set with which it was not trained is really low with under 6%. Although the accuracy reaches for the MELD trained models the value which is expected for guessing one of the seven emotion. For this reason the plots are not shown for the cross-testing as they will look the same as (c) and (d) from @fig:fig-video_meld_c  or any figure from audio detection. 

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_video_t_pcr.svg"),
        [(a) Precision-Recall Curve for MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_video_t_hm.svg"),
        [(b) Heatmap classification distribution for MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video transformer based network and tested with the MELD dataset.]
)<fig-video_meld_t>

Interestingly are the higher results from the CREMA-D trained models. Again the overview in  @tbl:fig-accs_video shows that the convolution architecture achieved an accuracy of nearly 75% which is the highest score achieved by any model from earlier. @fig:fig-video_crema_c shows in (b) that the diagonal with the correct classified emotion that the model was quite precise. There are still some missclassification, mostly for anger and fear as well as fear with sadness and anger with sadness which are sharing many facial features. As before the CREMA dataset did not include anysamples with surprise so there were no evaluation for this label possible. 

The graphical representation of the precision-recall curve in (a) from @fig:fig-video_crema_c desribes that the model perfomed best with happy and closed followed by disgust. Due to the overacting by the persons which are shown in the video samples, both emotion are cleary differentiable from each other. Followed by this explanation that the model looks mostly at the strong shown features from the faces, neutral performed much worse than the two other well learned emotions due this sentiment should not cover any features.  Furthermore sadness performed the worst from all of the six labels due to multiple missclassification with fear and anger as they differ mostly in one or two features. Corresponding to Ekmans Facs system which was explained before, all of the three emotion are sharing every information around the eyes and are only differentiable by the lower part of the face. The convolution model might lay his focus more on the upper half which can lead to this kind of training and testing behavior. 

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
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video convolution based network and tested with the CREMA-D dataset.]
)<fig-video_crema_c>

Nearly the same observations can be found within the transformer model. Visible in (b) from @fig:fig-video_crema_t the diagnal line with the correct classified labels is still existing and clearly recognizable. However there are also quite a lot of missclassified outlier, mostly where the actual label is anger, sadness and fear. The problematic follows the explanation from the convolution model but is more visible. It shows that the model did not get the correct features as fast as the convolution model which can result due to the difference in the amount of trainable parameters. With more time in training which was not possible due to the limitations in this thesis, the model could achieve the results from the convolution model. In addition with (a) from

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
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video transformer based network and tested with the CREMA-D dataset.]
)<fig-video_crema_t>

 @fig:fig-video_crema_t it is still clear that happiness was well learned and also followed by disgust. The other emotions are showing that there is more proper training missing to differentiate between the smaller yet important features. 

 In total there are facial features which can be learned by neural networks or similar deep learning architectures. However there are still many problems with the existing datasets as they is no standard or good comparability between each other. This leads to the described overfitting effect which was found in every modal yet since there are different artefacts like shaking heads or other disturbances. With better active speaker recognition, artifical camera stabilzation or interpolation to clean up bad frames there are many possibilities to improve and generalize these models within video based emotion detection.



#section("Multimodal Results")

For multimodal evaluation the best model from each modal was picked as it is not necessary to test the same experiment with less precise results thus identically trained models. For MELD the EmoBERT model, the audio xxxxxxxx #todo[pick the right] and the video convolution are choosen. As there are no metrics and trained text models for CREMA-D only the audio transformer and video convolution models are used for the multimodal evaluation. To simulate the missing results from text detection a random label is picked for each sentence. Without a third modal the major vote strategy would not work properly. 

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
    
      [Neural Network], [0.759], [0.758], [0.756], [0.751], [], [], [], [],
      [Brute Force], [0.735], [0.737], [0.736], [0.730], [], [], [], [],
      [Major Voting], [0.252], [0.273], [0.250], [0.243], [], [], [], [],
    )
],
caption: [Accuracy for multimodal emotion classification.]
)<fig-accs_mm>