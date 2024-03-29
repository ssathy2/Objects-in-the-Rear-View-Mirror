/* Class file to draw the map graph itself. */
float toggleMapLeft, toggleMapTop, toggleMapRight, toggleMapBottom;

float dataMin = 0;
float dataMax = 50;

String colorLow = "#6ED3E0";
String colorHigh = "#002F36";

String[] states = {"AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID",
"IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY",
"OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"};

int[] statesValue = {50,49,48,47,46,45,44,43,42,41,40,39,38,37,
36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,
14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};

HashMap<Integer, HashMap<Integer, Crash>> statePoints = new HashMap<Integer, HashMap<Integer, Crash>>();

HashMap<String, HashMap<Integer, Integer>> statesValues = new HashMap<String, HashMap<Integer, Integer>>();

//String[] accidents = {"AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID",
//"IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY",
//"OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"};

//String[] accidentsFull = {"State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake",
//"State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake",
//"State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake",
//"State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake","State/Lake"};
//
//int[] accidentsValue = {50,49,48,47,46,45,44,43,42,41,40,39,38,37,
//36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,
//14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};

ArrayList<Crash> accidents = new ArrayList<Crash>();

String[] statesFull = {"Alaska","Alabama","Arkansas","Arizona","California","Colorado","Connecticut","District of Columbia","Delaware","Florida","Georgia","Hawaii","Iowa","Idaho","Illinois","Indiana","Kansas","Kentucky","Louisiana","Massachusetts","Maryland","Maine","Michigan","Minnesota","Missouri","Mississippi","Montana","North Carolina","North Dakota","Nebraska","New Hampshire","New Jersey","New Mexico","Nevada","New York","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Virginia","Vermont","Washington","Wisconsin","West Virginia","Wyoming"};

String selectedState = "Illinois";

float statesListLeft, statesListWidth, statesListHeight, statesListMovement, statesListOldY, statesListButtonLeft, statesListButtonWidth, statesListButtonHeight;
float accidentsListLeft, accidentsListWidth, accidentsListHeight, accidentsListMovement, accidentsListOldY, accidentsListButtonLeft, accidentsListButtonWidth, accidentsListButtonHeight;
float specificAccidentBackButtonLeft, specificAccidentBackButtonTop, specificAccidentBackButtonHeight, specificAccidentBackButtonWidth;

int specificAccident = 0;

boolean viewingSpecificAccident = false;

float friction = 15.0/16.0;

boolean statesListMove = false;
boolean accidentsListMove = false;

float[] statesListTop = new float[states.length];
float[] statesListButtonTop = new float[states.length];

ArrayList<Float> accidentsListTop = new ArrayList<Float>();
ArrayList<Float> accidentsListButtonTop = new ArrayList<Float>();

void drawHeatMap() {
  rectMode(CORNERS);
  if (statesListMove){
    statesListMovement = mouseY - statesListOldY;
    statesListOldY = mouseY;
    for (int i = 1; i < states.length - 1; i++){
      statesListTop[i]+=statesListMovement;
      statesListButtonTop[i] = statesListTop[i] + 2*scaleFactor;
    }
  }
  else {
    if (abs(statesListMovement) > 1){
      for (int i = 1; i < states.length - 1; i++){
        statesListTop[i]+=statesListMovement;
        statesListButtonTop[i] = statesListTop[i] + 2*scaleFactor;
      }
      statesListMovement = statesListMovement*friction;
    }
  }
  
  noStroke();
  
  fill(0);
  textSize(12*scaleFactor);
  for (int i = states.length - 2; i > 0; i--) {
    PShape state = svg.getChild(states[i]);
    if(statesFull[i] == selectedState){
      fill(#FA8A11);
    }
    else{
      fill(heat_red(statesValue[i]), heat_green(statesValue[i]), heat_blue(statesValue[i]));
    }
    shape(state, gPlotX1, gPlotY1, gPlotX1 + 281 * scaleFactor, gPlotY2 - gPlotY1);
    if(statesListTop[i] <= gPlotY2 - 45*scaleFactor && statesListTop[i] >= gPlotY1 + 16*scaleFactor){
      rect(statesListLeft, statesListTop[i], statesListLeft + statesListWidth, statesListTop[i] + statesListHeight);
      fill(240);
      rect(statesListButtonLeft, statesListButtonTop[i], statesListButtonLeft + statesListButtonWidth, statesListButtonTop[i] + statesListButtonHeight);
      fill(40);
      textAlign(LEFT);
      text("Pick", statesListButtonLeft+6*scaleFactor, statesListTop[i] + 2*statesListHeight/3);
      fill(240);
      textAlign(LEFT);
      text(statesFull[i], statesListLeft+statesListButtonWidth+20*scaleFactor, statesListTop[i] + 2*statesListHeight/3);
      textAlign(RIGHT);
      text(statesValue[i], statesListLeft+statesListWidth - 10*scaleFactor, statesListTop[i] + 2*statesListHeight/3);
    }
  }
  
  
    PShape state = svg.getChild(states[0]);
    if(statesFull[0] == selectedState){
      fill(#FA8A11);
    }
    else{
      fill(heat_red(statesValue[0]), heat_green(statesValue[0]), heat_blue(statesValue[0]));
    }
    shape(state, gPlotX1, gPlotY1, gPlotX1 + 281 * scaleFactor, gPlotY2-gPlotY1);
    rect(statesListLeft, statesListTop[0], statesListLeft + statesListWidth, statesListTop[0] + statesListHeight);
    fill(240);
    rect(statesListButtonLeft, statesListButtonTop[0], statesListButtonLeft + statesListButtonWidth, statesListButtonTop[0] + statesListButtonHeight);
    fill(40);
    textAlign(LEFT);
    text("Pick", statesListButtonLeft+6*scaleFactor, statesListTop[0] + 2*statesListHeight/3);
    fill(240);
    textAlign(LEFT);
    text(statesFull[0], statesListLeft+statesListButtonWidth+20*scaleFactor, statesListTop[0] + 2*statesListHeight/3);
    textAlign(RIGHT);
    text(statesValue[0], statesListLeft+statesListWidth - 10*scaleFactor, statesListTop[0] + 2*statesListHeight/3);
    
    state = svg.getChild(states[states.length-1]);
    if(statesFull[states.length-1] == selectedState){
      fill(#FA8A11);
    }
    else{
      fill(heat_red(statesValue[states.length-1]), heat_green(statesValue[states.length-1]), heat_blue(statesValue[states.length-1]));
    }
    shape(state, gPlotX1, gPlotY1, gPlotX1 + 281 * scaleFactor, gPlotY2 - gPlotY1);
    rect(statesListLeft, statesListTop[states.length-1], statesListLeft + statesListWidth, statesListTop[states.length-1] + statesListHeight);
    fill(240);
    rect(statesListButtonLeft, statesListButtonTop[states.length-1], statesListButtonLeft + statesListButtonWidth, statesListButtonTop[states.length-1] + statesListButtonHeight);
    fill(40);
    textAlign(LEFT);
    text("Pick", statesListButtonLeft+6*scaleFactor, statesListTop[states.length-1] + 2*statesListHeight/3);
    fill(240);
    textAlign(LEFT);
    text(statesFull[states.length-1], statesListLeft+statesListButtonWidth+20*scaleFactor, statesListTop[states.length-1] + 2*statesListHeight/3);
    textAlign(RIGHT);
    text(statesValue[states.length-1], statesListLeft+statesListWidth - 10*scaleFactor, statesListTop[states.length-1] + 2*statesListHeight/3);
    
  if (statesListTop[states.length-2] + statesListHeight < statesListTop[states.length - 1]){
    float temp = statesListTop[states.length-1] - statesListTop[states.length - 2] - statesListHeight;
    for(int i = 1; i < states.length-1; i++){
      if (temp < 2){
        statesListTop[i]+=temp; 
      }
      else{
        statesListTop[i] += temp*friction;
      }
    }
  }
  if (statesListTop[1] > statesListTop[0] + statesListHeight){
    float temp = statesListTop[0] + statesListHeight - statesListTop[1];
    for(int i = 1; i < states.length - 1; i++){
      if (temp > -2){
        statesListTop[i]+=temp; 
      }
      else{
        statesListTop[i] += temp*friction;
      }
    }
  }
  //cp5?
//  fill(240);
//  textSize(28*scaleFactor);
//  fill(40);
//  textAlign(CENTER);
//  text(selectedState, 511*scaleFactor+257*scaleFactor/2, gPlotY1 + 37*scaleFactor);
//  textSize(18*scaleFactor);
//  textAlign(LEFT);
//  text("Accidents", 511*scaleFactor, gPlotY1 + 70*scaleFactor);
//  textAlign(RIGHT);
//  text(selectedState, 511*scaleFactor + 257*scaleFactor, gPlotY1 + 70*scaleFactor);
//  fill(110);
//  textAlign(LEFT);
//  text("Primary Filter1", 511*scaleFactor, gPlotY1 + 100*scaleFactor);
//  text("Primary Filter2", 511*scaleFactor, gPlotY1 + 130*scaleFactor);
//  text("Primary Filter3", 511*scaleFactor, gPlotY1 + 160*scaleFactor);
//  text("Primary Filter4", 511*scaleFactor, gPlotY1 + 190*scaleFactor);
//  text("Primary Filter5", 511*scaleFactor, gPlotY1 + 220*scaleFactor);
//  fill(#FA8A11);
//  textSize(24*scaleFactor);
//  textAlign(RIGHT);
//  text("50%", 511*scaleFactor + 257*scaleFactor, gPlotY1 + 102*scaleFactor);
//  text("10%", 511*scaleFactor + 257*scaleFactor, gPlotY1 + 132*scaleFactor);
//  text("9%", 511*scaleFactor + 257*scaleFactor, gPlotY1 + 162*scaleFactor);
//  text("8%", 511*scaleFactor + 257*scaleFactor, gPlotY1 + 192*scaleFactor);
//  text("5%", 511*scaleFactor + 257*scaleFactor, gPlotY1 + 222*scaleFactor);
  
  fill(40);
  PShape state_lines = svg.getChild("State_Lines");
  PShape separator = svg.getChild("separator");
}


void drawPlotMap(){
  strokeWeight((float)((map.sc) * scaleFactor) / (33 * scaleFactor));
  rectMode(CORNERS);
  map.draw();
  fill(#FA8A11);
  stroke(#FA8A11);
  //loadPixels();
  for(int i = dateMin; i <= dateMax; i++){
    System.out.println(i + " " + dateMin + " " + dateMax);
    Crash[] year_points = statePoints.get(i).values().toArray(new Crash[0]);
    for(int j = 0; j < year_points.length; j++){
      Point p = year_points[j].coordinates;
      Point2f lp = map.locationPoint(new Location((float)p.latitude, (float)p.longitude));
      int temp = Math.round(lp.y*width+lp.x);
      point(lp.x, lp.y);
    }
  }
  strokeWeight(0);
  stroke(0);
  //updatePixels();
//  Point2f p = map.locationPoint(locationChicago);
//  fill(#FA8A11);
//  rect(p.x, p.y, p.x + 10*scaleFactor, p.y+10*scaleFactor, 5*scaleFactor);
  if(viewingSpecificAccident){
    textSize(12*scaleFactor);
    fill(240);
    rect(specificAccidentBackButtonLeft, specificAccidentBackButtonTop, specificAccidentBackButtonLeft + specificAccidentBackButtonWidth, specificAccidentBackButtonTop + specificAccidentBackButtonHeight);
    fill(40);
    textAlign(LEFT);
    text("Back", specificAccidentBackButtonLeft+6*scaleFactor, specificAccidentBackButtonTop + 2*specificAccidentBackButtonHeight/3);
    
    fill(220);
    textSize(12*scaleFactor);
    textAlign(LEFT);
    text(accidents.get(specificAccident).coordinates.latitude + ", " + accidents.get(specificAccident).coordinates.longitude, accidentsListLeft, specificAccidentBackButtonTop + 2*specificAccidentBackButtonHeight/3);
    textSize(18*scaleFactor);
    textAlign(LEFT);
    text("Date", accidentsListLeft, gPlotY1 + 70*scaleFactor);
    textAlign(RIGHT);
    text(accidents.get(specificAccident).crashDate.cMonth + "/" + accidents.get(specificAccident).crashDate.cDay +"/"+accidents.get(specificAccident).crashDate.cYear, accidentsListLeft + accidentsListWidth, gPlotY1 + 70*scaleFactor);
    fill(240);
    textAlign(LEFT);
    text("Age", accidentsListLeft, gPlotY1 + 100*scaleFactor);
    text("Gender", accidentsListLeft, gPlotY1 + 130*scaleFactor);
    text("Drugs?", accidentsListLeft, gPlotY1 + 160*scaleFactor);
    text("Alcohol?", accidentsListLeft, gPlotY1 + 190*scaleFactor);
    fill(#FA8A11);
    textSize(24*scaleFactor);
    textAlign(RIGHT);
    text(accidents.get(specificAccident).cAge, accidentsListLeft + accidentsListWidth, gPlotY1 + 102*scaleFactor);
    text(accidents.get(specificAccident).isMale ? "Male" : "Female", accidentsListLeft + accidentsListWidth, gPlotY1 + 132*scaleFactor);
    text(accidents.get(specificAccident).cDrugs > 0 ? "Yes" : "No", accidentsListLeft + accidentsListWidth, gPlotY1 + 162*scaleFactor);
    text(accidents.get(specificAccident).isAlcoholInvolved ? "Yes" : "No", accidentsListLeft + accidentsListWidth, gPlotY1 + 192*scaleFactor);
  }else{
    if (accidentsListMove){
      accidentsListMovement = mouseY - accidentsListOldY;
      accidentsListOldY = mouseY;
      for (int i = 0; i < accidents.size(); i++){
        accidentsListTop.set(i, accidentsListTop.get(i)+accidentsListMovement);
        accidentsListButtonTop.set(i, accidentsListTop.get(i) + 2*scaleFactor);
      }
    }
    else {
      if (abs(accidentsListMovement) > 1){
        for (int i = 0; i < accidents.size(); i++){
          accidentsListTop.set(i, accidentsListTop.get(i)+accidentsListMovement);
          accidentsListButtonTop.set(i, accidentsListTop.get(i) + 2*scaleFactor);
        }
        accidentsListMovement = accidentsListMovement*friction;
      }
    }
    
    noStroke();
    
    fill(0);
    textSize(12*scaleFactor);
    for (int i = accidents.size() - 1; i >= 0; i--) {
      fill(#FA8A11);
      if(accidentsListTop.get(i) <= gPlotY2 - 15*scaleFactor && accidentsListTop.get(i) >= gPlotY1 - 14*scaleFactor){
        rect(accidentsListLeft, accidentsListTop.get(i), accidentsListLeft + accidentsListWidth, accidentsListTop.get(i) + accidentsListHeight);
        fill(240);
        rect(accidentsListButtonLeft, accidentsListButtonTop.get(i), accidentsListButtonLeft + accidentsListButtonWidth, accidentsListButtonTop.get(i) + accidentsListButtonHeight);
        fill(40);
        textAlign(LEFT);
        text("More", accidentsListButtonLeft+6*scaleFactor, accidentsListTop.get(i) + 2*accidentsListHeight/3);
        fill(240);
        textAlign(LEFT);
        text(accidents.get(i).coordinates.latitude + ", " + accidents.get(i).coordinates.longitude, accidentsListLeft+accidentsListButtonWidth+20*scaleFactor, accidentsListTop.get(i) + accidentsListHeight/2);
        fill(220);
        text(accidents.get(i).crashDate.cMonth + "/" + accidents.get(i).crashDate.cDay +"/"+accidents.get(i).crashDate.cYear, accidentsListLeft+accidentsListButtonWidth+20*scaleFactor, accidentsListTop.get(i) + 7*accidentsListHeight/8);
      }
    }
    
    
    //Pull back into list bounds
    if (accidents.size() > 7 && accidentsListTop.get(accidents.size()-1) < gPlotY1+16*scaleFactor + accidentsListHeight*6){
      float temp = gPlotY1+16*scaleFactor + accidentsListHeight*6 - accidentsListTop.get(accidents.size() - 1);
      for(int i = 0; i < accidents.size(); i++){
        if (temp < 2){
          accidentsListTop.set(i, accidentsListTop.get(i) + temp); 
        }
        else{
          accidentsListTop.set(i, accidentsListTop.get(i) + temp*friction);
        }
      }
    }
    if (accidentsListTop.size() > 0){
      if (accidentsListTop.get(0) > gPlotY1 + 16*scaleFactor){
        float temp = accidentsListTop.get(0) - gPlotY1 - 16*scaleFactor;
        for(int i = 0; i < accidents.size(); i++){
          if (temp < 2){
            accidentsListTop.set(i, accidentsListTop.get(i) - temp); 
          }
          else{
            accidentsListTop.set(i, accidentsListTop.get(i) - temp*friction);
          }
        }
      }
    }
    
    fill(40);
    rect(accidentsListLeft, gPlotY1-14*scaleFactor, accidentsListLeft + accidentsListWidth, gPlotY1 + 16*scaleFactor);
    rect(accidentsListLeft, gPlotY2-15*scaleFactor, accidentsListLeft + accidentsListWidth, gPlotY2 +15*scaleFactor);
  }
}

float heat_red(int a){
  return((dataMax - a)/(dataMax - dataMin))*(hexToR(colorLow)-hexToR(colorHigh))+hexToR(colorHigh);
}

float heat_green(int a){
  return((dataMax - a)/(dataMax - dataMin))*(hexToG(colorLow)-hexToG(colorHigh))+hexToG(colorHigh);
}

float heat_blue(int a){
  return((dataMax - a)/(dataMax - dataMin))*(hexToB(colorLow)-hexToB(colorHigh))+hexToB(colorHigh);
}

int hexToR(String h){ 
  return Integer.parseInt((cutHex(h)).substring(0,2),16);
}
int hexToG(String h){
  return Integer.parseInt((cutHex(h)).substring(2,4),16);
}
int hexToB(String h){ 
  return Integer.parseInt((cutHex(h)).substring(4,6),16);
}
String cutHex(String h) {
  return (h.charAt(0)=='#') ? h.substring(1,7) : h;
}
