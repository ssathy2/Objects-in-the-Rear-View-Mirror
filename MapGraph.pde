/* Class file to draw the map graph itself. */
float dataMin = 0;
float dataMax = 49;

String colorLow = "#5BCF63";
String colorHigh = "#062E09";

String[] states = {"AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID",
"IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY",
"OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"};

void drawHeatMap() {
  noStroke();
  
  fill(0);
  for (int i = 0; i < states.length; i++) {
    PShape state = svg.getChild(states[i]);
    fill(heat_red(i), heat_green(i), heat_blue(i));
    svg.disableStyle();
//    shape(state, gPlotX1, gPlotY1, gPlotX1 + 281 * scaleFactor, gPlotY2);
    shape(state, gPlotX1, gPlotY1, gPlotX1 + (gPlotX2 - gPlotX1)/2 * scaleFactor, gPlotY2);
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
