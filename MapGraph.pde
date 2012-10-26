/* Class file to draw the map graph itself. */
float dataMin = 0;
float dataMax = 49;

String colorLow = "#5BCF63";
String colorHigh = "#062E09";

String[] states = {"AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID",
"IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY",
"OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"};

float statesListLeft, statesListWidth, statesListHeight, statesListMovement, statesListOldY;

float friction = 15.0/16.0;

boolean statesListMove = false;

float[] statesListTop = new float[states.length];

void drawHeatMap() {
  rectMode(CORNER);
  if (statesListMove){
    statesListMovement = mouseY - statesListOldY;
    statesListOldY = mouseY;
    for (int i = 1; i < states.length - 1; i++){
      statesListTop[i]+=statesListMovement;
    }
  }
  else {
    if (abs(statesListMovement) > 1){
      for (int i = 1; i < states.length - 1; i++){
        statesListTop[i]+=statesListMovement;
      }
      statesListMovement = statesListMovement*friction;
    }
  }
  
  noStroke();
  svg.disableStyle();
  
  fill(0);
  for (int i = 1; i < states.length - 1; i++) {
    PShape state = svg.getChild(states[i]);
    fill(heat_red(i), heat_green(i), heat_blue(i));
//    shape(state, gPlotX1, gPlotY1, gPlotX1 + 281 * scaleFactor, gPlotY2);
    shape(state, gPlotX1, gPlotY1, gPlotX1 + (gPlotX2 - gPlotX1)/2 * scaleFactor, gPlotY2);
    if(statesListTop[i] <= gPlotY2 + 30 && statesListTop[i] >= gPlotY1 + 16*scaleFactor){
      rect(statesListLeft, statesListTop[i], statesListWidth, statesListHeight);
      fill(240);
      textAlign(LEFT);
      text(states[i], statesListLeft+10*scaleFactor, statesListTop[i] + 2*statesListHeight/3);
      textAlign(RIGHT);
      text(i, statesListLeft+statesListWidth - 10*scaleFactor, statesListTop[i] + 2*statesListHeight/3);
    }
  }
  
  
    PShape state = svg.getChild(states[0]);
    fill(heat_red(0), heat_green(0), heat_blue(0));
    shape(state, gPlotX1, gPlotY1, gPlotX1 + (gPlotX2 - gPlotX1)/2 * scaleFactor, gPlotY2);
    rect(statesListLeft, statesListTop[0], statesListWidth, statesListHeight);
    fill(240);
    textAlign(LEFT);
    text(states[0], statesListLeft+10*scaleFactor, statesListTop[0] + 2*statesListHeight/3);
    textAlign(RIGHT);
    text(0, statesListLeft+statesListWidth - 10*scaleFactor, statesListTop[0] + 2*statesListHeight/3);
    
    state = svg.getChild(states[states.length-1]);
    fill(heat_red(states.length-1), heat_green(states.length-1), heat_blue(states.length-1));
    shape(state, gPlotX1, gPlotY1, gPlotX1 + (gPlotX2 - gPlotX1)/2 * scaleFactor, gPlotY2);
    rect(statesListLeft, gPlotY2+30*scaleFactor, statesListWidth, statesListHeight);
    fill(240);
    textAlign(LEFT);
    text(states[states.length-1], statesListLeft+10*scaleFactor, statesListTop[states.length-1] + 2*statesListHeight/3);
    textAlign(RIGHT);
    text(states.length-1, statesListLeft+statesListWidth - 10*scaleFactor, statesListTop[states.length-1] + 2*statesListHeight/3);
    
  if (statesListTop[states.length-2] + statesListHeight < statesListTop[states.length - 1]){
      float temp = statesListTop[states.length-1] - statesListTop[states.length - 2] + statesListHeight;
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
  
  fill(40);
  PShape state_lines = svg.getChild("State_Lines");
  PShape separator = svg.getChild("separator");
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
