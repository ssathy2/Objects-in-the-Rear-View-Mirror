/* Class file to draw labels and controllers associated witht he line graph */

float gPlotX1, gPlotX2, gPlotY1, gPlotY2;
float ssPlotX1, ssPlotX2, ssPlotY1, ssPlotY2; 

float hLabelX, hLabelY;
float vLabelX, vLabelY;

ListBox ssListBox;
Textlabel hGraphLabel;
Textlabel vGraphLabel;

/*
float sListLeft, sListWidth, sListHeight, sListMovement, sListOldY, sListButtonLeft, sListButtonWidth, sListButtonHeight;
 float aListLeft, aListWidth, aListHeight, aListMovement, aListOldY, aListButtonLeft, aListButtonWidth, aListButtonHeight;
 boolean sListMove = false;
 boolean aListMove = false;
 
 float[] sListTop;
 float[] sListButtonTop;
 
 float[] aListTop;
 float[] aListButtonTop;
 */


void drawGLayout() {

  rectMode(CORNERS);
  strokeWeight(6);
  stroke(0);
  fill(180);
  rect(gPlotX1, gPlotY1, gPlotX2, gPlotY2, scaleFactor * 6);

  drawXAxisUnits();

  if (!mapIsShown) {
    drawStateSelectionPlot();
  }
}


void drawXAxisUnits() {

  int staticMax;
  int staticMin;
  int totalDifference;

  float floatX1 = 0;
  float floatX2;

  fill(235);
  textFont(toggleFont);
  textAlign(CENTER, TOP);
  textSize(scaleFactor * 12);

  switch(timeScale) {
    case(1):
    staticMax = 2010;
    staticMin = 2001;
    totalDifference = staticMax - staticMin;

    for (int i = 1; i <= 10; i++) {

    floatX1 = map(i, (timeSliderPercentageLeft/100) * (staticMax - staticMin) + 1, (timeSliderPercentageRight/100) * (staticMax - staticMin) + 1, gPlotX1, gPlotX2);
     
      if( floatX1 >= ((timeSliderPercentageLeft/100) * (staticMax - staticMin) + 1)&& 
        (floatX1 <= (timeSliderPercentageRight/100) * (staticMax - staticMin) + 1)) {
        text(2000 + floatX1, floatX1, gPlotY2 + 10);
      }
    }


    break;
    case(2):
    staticMax = 12;
    staticMin = 1;
    break;
    case(3):
    staticMax = 1;
    staticMin = 31;
    break;
    case(4):
    staticMax = 1;
    staticMin = 24;
    break;
  }
}


void drawGraphLabels() {    //Goes in drawLayoutMain

  hLabelX = ((gPlotX2 - gPlotX1) / 2 ) + gPlotX1;
  hLabelY = gPlotY2 + (scaleFactor * 10);

  vLabelX = scaleFactor * 10;
  vLabelY = ((gPlotY2 - gPlotY1) /2) + gPlotY1 - (scaleFactor * 30);

  hGraphLabel = cp5.addTextlabel("hGraphLabel")
    // .setMultiline(true)
    .setText("Years")
  .setPosition(hLabelX, hLabelY)
    .setColorValue(color(235))
    .setFont(pFont)
    ;

  vGraphLabel = cp5.addTextlabel("vGraphLabel")
    //.setMultiline(true)
  .setPosition(vLabelX, vLabelY)
    .setText("Number\nof\nAccidents")
    .setColorValue(color(235))
    .setFont(pFont)
    ;

 
}

void drawStateSelectionPlot() {


  smooth();

  strokeWeight(6);
  stroke(0);
  fill(180);
  strokeCap(ROUND);
  line(ssPlotX1, ssPlotY1, ssPlotX1 + (scaleFactor * 20), ssPlotY2);
  line(ssPlotX2, ssPlotY1, ssPlotX2 -(scaleFactor * 20), ssPlotY2);
  line(ssPlotX1 + (scaleFactor * 20), ssPlotY2 + (scaleFactor * 1), ssPlotX2 -(scaleFactor * 20), ssPlotY2 + (scaleFactor * 1));
}

void drawStateSelectionController() {

  ssPlotX1 = gPlotX1 + (scaleFactor * 400);
  ssPlotX2 = ssPlotX1 + (scaleFactor * 250);
  ssPlotY1 = gPlotY1 + (scaleFactor * 2);
  ssPlotY2 = gPlotY1 + scaleFactor * 30;

  ssListBox = cp5.addListBox("stateSelection")
    .setPosition(ssPlotX1 + scaleFactor * 22, ssPlotY2 - scaleFactor * 2)
    .setSize(int((ssPlotX2 - ssPlotX1) - scaleFactor * 45 ), int(scaleFactor * 200))
    .setItemHeight(scaleFactor* 30)
    .setBarHeight(scaleFactor*22)
    //.hideBar()
  .setColorBackground(color(255, 1))
    .setColorActive(#FC3333)
    .setColorForeground(#FC3333) 
    .setColorLabel(20)
    .setScrollbarWidth(scaleFactor * 20)
    .actAsPulldownMenu(true)
	.addItems(statesFull);
    ;


  ssListBox.captionLabel().setFont(cp5Font);
  ssListBox.captionLabel().setSize(scaleFactor * 15);
  ssListBox.captionLabel().set(statesFull[14]);
  ssListBox.captionLabel().setColor(20);
  ssListBox.captionLabel().style().marginTop = 3;
  ssListBox.valueLabel().style().marginTop = 3;

  for (int i=0;i<statesFull.length;i++) {
    ListBoxItem lbi = ssListBox.getItem(i);
    lbi.setColorBackground(#E8EAE8);
  }
}


