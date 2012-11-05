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
  textSize(12);

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
         .setSize(int((ssPlotX2 - ssPlotX1) - scaleFactor * 45 ),int(200))
         .setItemHeight(scaleFactor* 30)
         .setBarHeight(scaleFactor*22)
         //.hideBar()
         .setColorBackground(color(255,1))
         .setColorActive(#FC3333)
         .setColorForeground(#FC3333) 
         .setColorLabel(20)
         .setScrollbarWidth(scaleFactor * 20)
         .actAsPulldownMenu(true)
         .addItems(statesFull);
         ;
         
  
  ssListBox.captionLabel().toUpperCase(true);
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


/*
void setupSList(){
 
 sListTop = new float[states.length];
 sListButtonTop = new float[states.length];
 
 aListTop = new float[states.length];
 aListButtonTop = new float[states.length];
 
 //states
 sListLeft = 842*scaleFactor;
 sListWidth = 281*scaleFactor;
 sListHeight = (gPlotY2 - gPlotY1)/8;
 
 sListButtonLeft = sListLeft + 10*scaleFactor;
 sListButtonWidth = 40*scaleFactor;
 sListButtonHeight = sListHeight-4*scaleFactor;
 
 for (int i = 0; i < states.length - 1; i++) {
 sListTop[i] = gPlotY1+16*scaleFactor+sListHeight*i;
 sListButtonTop[i] = sListTop[i]+2*scaleFactor;
 }
 
 sListTop[states.length - 1] = gPlotY2-45*scaleFactor;
 sListButtonTop[states.length - 1] = sListTop[states.length-1] + 2*scaleFactor;
 
 
 //Accidents
 aListLeft = sListLeft;
 aListWidth = sListWidth;
 aListHeight = sListHeight;
 
 aListButtonLeft = aListLeft + 10*scaleFactor;
 aListButtonWidth = 40*scaleFactor;
 aListButtonHeight = aListHeight-4*scaleFactor;
 
 for (int i = 0; i < accidents.length; i++) {
 aListTop[i] = gPlotY1+16*scaleFactor+aListHeight*i;
 aListButtonTop[i] = aListTop[i]+2*scaleFactor;
 }
 
 sListTop[states.length - 1] = gPlotY2-45*scaleFactor;
 sListButtonTop[states.length - 1] = sListTop[states.length-1] + 2*scaleFactor;
 }
 
 
 
 void drawStateSelectionController(){
 
 setupSList();
 
 //This is the code that controls how it moves.
 // Put this in your drawing method
 if (aListMove){
 aListMovement = mouseY - aListOldY;
 aListOldY = mouseY;
 for (int i = 0; i < accidents.length; i++){
 aListTop[i]+=aListMovement;
 aListButtonTop[i] = aListTop[i] + 2*scaleFactor;
 }
 }
 else {
 if (abs(aListMovement) > 1){
 for (int i = 0; i < accidents.length; i++){
 aListTop[i]+=aListMovement;
 aListButtonTop[i] = aListTop[i] + 2*scaleFactor;
 }
 aListMovement = aListMovement*friction;
 }
 }
 
 noStroke();
 
 fill(0);
 textSize(12*scaleFactor);
 for (int i = accidents.length - 1; i >= 0; i--) {
 PShape state = svg.getChild(accidents[i]);
 if(i < 5){
 fill(#FA8A11);
 }else{
 fill(40);
 }
 if(aListTop[i] <= gPlotY2 - 15*scaleFactor && aListTop[i] >= gPlotY1 - 14*scaleFactor){
 rect(aListLeft, aListTop[i], aListLeft + aListWidth, aListTop[i] + aListHeight);
 fill(240);
 rect(aListButtonLeft, aListButtonTop[i], aListButtonLeft + aListButtonWidth, aListButtonTop[i] + aListButtonHeight);
 fill(40);
 textAlign(LEFT);
 text("View", aListButtonLeft+6*scaleFactor, aListTop[i] + 2*aListHeight/3);
 fill(240);
 textAlign(LEFT);
 text(accidentsFull[i], aListLeft+aListButtonWidth+20*scaleFactor, aListTop[i] + 2*aListHeight/3);
 textAlign(RIGHT);
 text(accidentsValue[i], aListLeft+aListWidth - 10*scaleFactor, aListTop[i] + 2*aListHeight/3);
 }
 }
 
 
 //Pull back into list bounds
 if (accidents.length > 7 && aListTop[accidents.length-1] < gPlotY1+16*scaleFactor + aListHeight*6){
 float temp = gPlotY1+16*scaleFactor + aListHeight*6 - aListTop[accidents.length - 1];
 for(int i = 0; i < accidents.length; i++){
 if (temp < 2){
 aListTop[i]+=temp; 
 }
 else{
 aListTop[i] += temp*friction;
 }
 }
 }
 if (aListTop[0] > gPlotY1 + 16*scaleFactor){
 float temp = aListTop[0] - gPlotY1 - 16*scaleFactor;
 for(int i = 0; i < accidents.length; i++){
 if (temp < 2){
 aListTop[i]-=temp; 
 }
 else{
 aListTop[i] -= temp*friction;
 }
 }
 }
 
 }
 
 */




