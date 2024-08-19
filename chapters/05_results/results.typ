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

All in all these metrics are normally used for each label instead of for the whole classifier. Thus for a more clear arrangement of the results regarding the amount of different classifier and multimodal combination methods the following results are calculated for all labels in total showing the precision, accuracy, recall and quality of each classifier. Also this global observation of precision under recall helps to ignore imbalances within the datasets. This problem would otherwise occur while evaluating measurements with the MELD dataset. Furthermore the area under recall (AUC) metric describes the area under the precision-recall curve. A perfect model would have an AUC of 1, showing that the precision under recall is also always 1. In turn a completly untrained model has an AUC of 0. 


=== Experiments 

As already discussed there are several experiments to do for an appropiate showcase of the model functionalities. After they got trained they will be evaluated with their normal test data. Each model will be tested with the MELD data as well as the CEMA data to look if these models are able to understand the data from each other without further training. Additionaly on some models the weighted focus will be shown on some examples to visualize the extracted features. The best models for each modal will be choosen for the multimodal classification which follows the same testing procedure as before. As presented in the chapter before, the training for an output fusion with a simple neural network, major voting system and the bruteforce approach are simulated and evaluated.  





== Results

#section("Unimodal Results")

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
    
      [Llama], [nA], [nA], [nA], [nA], [], [], [], [],
      [Multi-EmoBert], [nA], [nA], [nA], [nA], [*0.603*], [*0.594*], [*0.603*], [*0.597*],
      [T5], [nA], [nA], [nA], [nA], [0.559], [0.581], [0.556], [0.559],
    )
],
caption: [Accuracy for unimodal emotion classification in text.]
)<fig-accs_text>

As noted in @tbl:fig-accs_text it was not possible to measure the accuracy, precision and other metrics for the CREMA-D dataset with in the text data. This results from the usage of the same sentence for each emotion. Therefore they change the emotionally meaning every time so the model is unable to correctly learn any features from the given training set.  Fortunat

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_t5_pcr.svg"),
        [(a) Precision-Recall Curve for Llama3]
      )
    ],
    [
      #stack(
        image("heatm/meld_t5_hm.svg"),
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
)<fig:text_pcr>


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
      [$"Transf. (C)"$], [], [], [], [], [], [], [], [],
      [$"Conv. (M)"$], [0.115], [0.042], [0.115], [0.046], [*0.478*], [*0.223*], [*0.478*], [*0.309*],
      
      [$"Transf. (M)"$], [], [], [], [], [], [], [], [], 
  
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
      [$"Transf. (C)"$], [], [], [], [], [], [], [], [],
      [$"Conv. (M)"$], [0.049], [0.295], [0.049], [0.043], [*0.473*], [*0.223*], [*0.473*], [*0.303*], 
      [$"Transf. (M)"$], [], [], [], [], [], [], [], [], 
  
    )
]
,
caption: [Accuracy for unimodal emotion classification in video trained on each dataset. \ (C) = tested with CREMA, (M) = tested with MELD]
)<fig-accs_video>

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
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_cr_video_c_pcr.svg"),
        [(c) Precision-Recall Curve for MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_cr_video_c_hm.svg"),
        [(d) Heatmap classification distribution for MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video convolution based network and tested with the CREMA-D dataset.]
)<fig:video_crema_c>

#lorem(80)

#figure(
  gap: 20pt,
  grid(
    columns: 2,
    [
      #stack(
        spacing: 12pt,
        image("curves/crema_me_video_c_pcr.svg"),
        [(a) Precision-Recall Curve for CREMA]
      )
    ],
    [
      #stack(
        image("heatm/crema_me_video_c_hm.svg"),
        [(b) Heatmap classification distribution for CREMA]
      )
    ],
    [
      #stack(
        spacing: 12pt,
        image("curves/meld_me_video_c_pcr.svg"),
        [(c) Precision-Recall Curve for MELD]
      )
    ],
    [
      #stack(
        image("heatm/meld_me_video_c_hm.svg"),
        [(d) Heatmap classification distribution for MELD]
      )
    ],
    
  ),
  caption: [Precision-Recall Curve for each label and their heatmap distribution from training on an video convolution based network and tested with the MELD dataset.]
)<fig:video_meld_c>

#section("Multimodal Results")