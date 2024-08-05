#import "../../template/template.typ": *
#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import fletcher.shapes: diamond

= Evaluation

This chapters will show all results for the before described and discussed implementations. Therefore the setup for the evaluation part is shown with a look on accuracy measuring functions especially the precision under recall curve. After this introduction and overwiev the actual results for the experiments are shown, visualized and further discussed.   

== Setup

As already explained each model is trained on both datasets for 20 epochs and a 90/10 split in training and testing. Each epoch runs through the whole training data which is randomly shuffled every time for better and more efficient training. The preprocessing follows analogous the implementation presented in the chapter before. The normalizaion is done globally to bring the values in an uniform space between -1 and 1. Every training loop consists of the Adam optimizer and the cross entropy loss function to calculate the gradient. After this each trained model is also tested with each datasat to show if a model trained on CREMA-D is capeable to detect emotion in the MELD data and the other way around. The only data which is not tested is the text data from the CREMA dataset. Due to its lack of a variety of sentences it is not necessary. It consists of only twelve different sentences in around 7000 videos. Every expression is actored in the different emotion. So it is neither learnable nor testable for the further evaluation. After this unimodal detection all predictions for the test and trainings datasets are saved in an external dataset for the multimodal emotion classification so they must not be runned each time for the brute-force, neural network or major vote approach. To measure the accuracy different metrics are used. Initially as example for the text classification the precision is calculated by simply counting how many of the predictions are actually equal to the expected output. Besides it is countet how many and which emotion are wrongly labeled by the model to display a heatmap and to analyize if there are easy mix-ups between similar feature spaces. This is also continued for each test scenario. Thus the calculation of the accuracy changed to a more informative and meaningful metric. 



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

In addition the recall shows how accurate the model predictet the classes by looking at the true positive and false negative values.

$ "Recall" = frac(T_P, T_P + F_N) $

At last to measure the quality of the classifcation model the F1-score can be calculated. It describes the harmonic mean between precision and recall and is denoted by 

$ "F1-Score" = 2 dot frac("Precision" dot "Recall", "Precision" + "Recall") $

All in all these metrics are normally used for each label instead of for the whole classifier. Thus for a more clear arrangement of the results regarding the amount of different classifier and multimodal combination methods the following results are calculated for all labels in total showing the precision, accuracy, recall and quality of each classifier. Also this global observation of precision under recall helps to ignore imbalances within the datasets. This problem would otherwise occur while evaluating measurements with the MELD dataset. Furthermore the area under recall (AUC) metric describes the area under the precision-recall curve. A perfect model would have an AUC of 1, showing that the precision under recall is also always 1. In turn a completly untrained model has an AUC of 0. 


=== Experiments 

As already discussed there are several experiments to do for an appropiate showcase of the model functionalities. After they got trained they will be evaluated with their normal test data. Each model will be tested with the MELD data as well as the CEMA data to look if these models are able to understand the data from each other without further training. This will be repeated with the same datasets but with additional artifical noise in each entry to check wether these architectures are still able to extract relevant features from much lower qualities. The best models for each modal will be choosen for the multimodal classification which follows the same testing procedure as before.





== Results

#section("Unimodal Results")

#figure(
kind: table,
align(center)[
    #set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., x, y) => if calc.even(y) { luma(242) },
      hlinex(),
      vlinex(),
      [], vlinex(), colspanx(4)[CREMA-D], colspanx(4)[MELD],
      [], [Accuracy], [Precision], [Recall], [F1], vlinex(), [Accuracy], [Precision], [Recall], [F1], vlinex(),  
      hlinex(),
      [Llama 3], [-], [-], [-], [-], [], [], [], [],
      [Multi-EmoBert], [-], [-], [-], [-], [], [], [], [],
      [T5], [-], [-], [-], [-], [], [], [], [],
      hlinex()
    )
],
caption: [Accuracy for unimodal emotion classification in text.]
)<fig-accs_text>

#lorem(80)



#figure(
kind: table,
gap: 15pt,
stack(
  spacing: 10pt,
  [
#align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      vlinex(),
      [], colspanx(4)[CREMA-D], colspanx(4)[MELD],
      [], [Acc.], [Precision], [Recall], [F1], vlinex(), [Acc.], [Precision], [Recall], [F1],
      hlinex(),
      [Conv.], vlinex(), [*0.409*], [*0.449*], [*0.409*], [*0.387*], [0.143], [0.021], [0.143], [0.036], 
      [Transf.], [], [], [], [], [], [], [], [],
      vlinex(), 
      hlinex()
    )
]], 
[(a) Test dataset: CREMA-D]
,[
#align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      vlinex(),
      [], colspanx(4)[CREMA-D], colspanx(4)[MELD],
      [], [Acc.], [Precision], [Recall], [F1], vlinex(), [Acc.], [Precision], [Recall], [F1],
      hlinex(),
      [Conv.], vlinex(), [0.115], [0.042], [0.115], [0.046], [*0.478*], [*0.223*], [*0.478*], [*0.309*], 
      [Transf.], [], [], [], [], [], [], [], [],
      vlinex(), 
      hlinex()
    )
]],
[(b) Test dataset: MELD]
),
caption: [Accuracy for unimodal emotion classification in audio trained on each dataset.]
)<fig-accs_audio>

#figure(
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
  caption: [Precision-Recall Curve for each label and heatmap distribution from testing with the CREMA-D dataset]
)<fig:audio_crema_pr>

#lorem(80)

#figure(
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
  caption: [Precision-Recall Curve for each label and heatmap distribution from testing with the MELD dataset]
)<fig:audio_meld_pr>

#figure(
kind: table,
gap: 15pt,
stack(
  spacing: 10pt,
  [
#align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      vlinex(),
      [], colspanx(4)[CREMA-D], colspanx(4)[MELD],
      [], [Acc.], [Precision], [Recall], [F1], vlinex(), [Acc.], [Precision], [Recall], [F1],
      hlinex(),
      [Conv.], vlinex(), [], [], [], [], [], [], [], [], 
      [Transf.], [], [], [], [], [], [], [], [],
      vlinex(), 
      hlinex()
    )
]], 
[(a) Test dataset: CREMA-D]
,[
#align(center)[
#set text(hyphenate: false)
    #set par(justify: false)
    #tablex(
      header-rows: 2,
      header-columns: 2,
      columns: 9,
      align: (center + horizon),
      inset: (y: 0.7em, x: 0.75em),
      auto-lines: false,
      stroke: 0.75pt,
      fill: (.., y) => if calc.even(y) { luma(242) },
      hlinex(),
      vlinex(),
      [], colspanx(4)[CREMA-D], colspanx(4)[MELD],
      [], [Acc.], [Precision], [Recall], [F1], vlinex(), [Acc.], [Precision], [Recall], [F1],
      hlinex(),
      [Conv.], vlinex(), [], [], [], [], [], [], [], [], 
      [Transf.], [], [], [], [], [], [], [], [],
      vlinex(), 
      hlinex()
    )
]],
[(b) Test dataset: MELD]
),
caption: [Accuracy for unimodal emotion classification in video trained on each dataset.]
)<fig-accs_video>

#lorem(80)

#section("Multimodal Results")