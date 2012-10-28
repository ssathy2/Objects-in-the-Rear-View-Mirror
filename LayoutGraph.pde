/* Class file to draw labels and controllers associated witht he line graph */

float gPlotX1, gPlotX2, gPlotY1, gPlotY2;

void drawGLayout() {

  rectMode(CORNER);
  strokeWeight(6);
  stroke(0);
  fill(250, 180);
  rect(gPlotX1, gPlotY1, gPlotX2, gPlotY2, scaleFactor * 6);
}

