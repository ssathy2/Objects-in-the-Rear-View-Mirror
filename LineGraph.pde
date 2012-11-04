/* Class file to draw the line graphs themselves */

HashMap<Integer, Integer> plotData;

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

  for (int i = 0; i < values.length; i++) {
    x = map(i, 0, values.length-1, gPlotX1, gPlotX2);
    y = map(values[i], 0, 200, gPlotY1, gPlotY2);
    vertex(x, y);
  }

  /*
  // double curve vertext points
   x = map(values.length-1, 0, values.length-1, plotX1, plotX2);
   y = map(values[values.length-1], 0, 200, height - topMargin, height - topMargin - plotHeight);
   curveVertex(x, y);
   */

  endShape();

  // draw points on mouse over
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
  }
}


float[] values = new float[20];
float plotX1, plotX2, plotY1, plotY2;
int leftMargin = 20;
int topMargin = 100;
int plotHeight = 250;
float timer = 0.0;
PFont helvetica;


void keyPressed() {
  generateValues();
}


void generateValues() {
  for (int i = 0; i < values.length; i++) {
    //values[i] = (int) random(200);
    values[i] = noise(timer) * 200;
    timer += 0.7;
  }
   
}


void getData() {
  if(shouldGetNewData) {
    int preLoadTime = millis();
    switch(timeScale) {
      case 1: plotData = db.getCrashMonthNumbersForYear(currentState, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 2: plotData = db.getCrashDayNumbersForMonthYear(currentState, currentMonth, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 3: plotData = db.getCrashHourNumbersForMonthDayYear(currentState, currentDay, currentMonth, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
    }
    int endLoadTime = millis();
    println("Took " + (endLoadTime - preLoadTime) + " ms to get data from DB");   
    shouldGetNewData = false;  
  }  
}



