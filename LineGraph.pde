/* Class file to draw the line graphs themselves */

HashMap<Integer, Integer> plotData;
int maxVal;

int getMaxOfValues() {
  int max = 0;
  for(Integer i : plotData.values()) {
    if(i > max) { 
      max = i;
    }    
  }
  return max;
}
  
void drawLineGraph() {

  getData();
  
  noFill();
  stroke(#2E5AD8);
  strokeWeight(2); 
  beginShape();

  float x, y;

  /*
  // double curve vertext points
   x = map(0, 0, values.length-1, plotX1, plotX2);
   y = map(values[0], 0, 200, height - topMargin, height - topMargin - plotHeight);
   curveVertex(x, y);
   */
  int startP = 0;
  int endP = 0;
  switch(timeScale) {
    case 1: startP = 2001; endP = 2010; break;
    case 2: startP = 1; endP = 12; break; 
    case 3: startP = 1; endP = 31; break;
    case 4: startP = 1; endP = 24; break;
  }

  for (int i = startP; i <= endP; i++) {
    x = map(i, startP, endP, gPlotX1, gPlotX2);    
    if(plotData.get(i) != null) {
      y = map(plotData.get(i), 0, maxVal, gPlotY2, gPlotY1);
    } else {
      y = map(0, 0, maxVal, gPlotY2, gPlotY1); 
    }
    vertex(x, y);
  }

  /*
  // double curve vertext points
   x = map(values.length-1, 0, values.length-1, plotX1, plotX2);
   y = map(values[values.length-1], 0, 200, height - topMargin, height - topMargin - plotHeight);
   curveVertex(x, y);
   */

  endShape();

  // the below functionality is nice to have...but it's only good if the app is run on a desktop and not on the wall, lets get the other stuff to work first
  /*// draw points on mouse over
  for (int i = 0; i < values.length; i++) {
    x = map(i, 0, values.length-1, plotX1, plotX2);
    y = map(values[i], 0, 200, height - topMargin, height - topMargin - plotHeight);

    // check mouse pos
    // float delta = dist(mouseX, mouseY, x, y);
    float delta = abs(mouseX - x);
    if ((delta < 15) && (y > plotY1) && (y < plotY2)) {
      stroke(255);
      fill(0);
      ellipse(x, y, 8, 8);

      int labelVal = round(values[i]);
      Label label = new Label("" + labelVal, x, y);
    }
  }*/
}


float[] values = new float[20];
float plotX1, plotX2, plotY1, plotY2;
int leftMargin = 20;
int topMargin = 100;
int plotHeight = 250;
float timer = 0.0;
PFont helvetica;


void keyPressed() {
  //generateValues();
}


void getData() {
  if(shouldGetNewData) {
    int preLoadTime = millis();
          println(timeScale);

    switch(timeScale) {
      case 1: plotData = db.getCrashNumbersForYearRange(currentState, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 2: plotData = db.getCrashMonthNumbersForYear(currentState, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 3: plotData = db.getCrashDayNumbersForMonthYear(currentState, currentMonth, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 4: plotData = db.getCrashHourNumbersForMonthDayYear(currentState, currentDay, currentMonth, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
    }
    int endLoadTime = millis();
    println("Took " + (endLoadTime - preLoadTime) + " ms to get data from DB");        
    maxVal = getMaxOfValues(); 
    shouldGetNewData = false;  
  }  
}



