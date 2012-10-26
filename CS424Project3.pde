import controlP5.*;

final static int WALLWIDTH = 8160;
final static int WALLHEIGHT = 2304;
int displayWidth, displayHeight;
static int scaleFactor;
DataBrowser db;
PImage bgImage;
PShape svg;

ControlP5 cp5;

void setup() {
  // init databrowser obj
  db = new DataBrowser(this, "cs424", "cs424", "crash_data_group3", "omgtracker.evl.uic.edu");
  
  scaleFactor = 1; // 1 for widescreen monitors and 6 for the wall
  displayWidth = WALLWIDTH / 6;
  displayHeight = WALLHEIGHT / 6;

  size(scaleFactor * displayWidth, scaleFactor * displayHeight, JAVA2D);
  
  cp5 = new ControlP5(this);
  
  bgImage = loadImage("bg.jpg");
  bgImage.resize(displayWidth * scaleFactor, displayHeight * scaleFactor);
  background(bgImage);
  
  gPlotX1 = scaleFactor * 100;
  gPlotY1 = scaleFactor * 70;
  gPlotX2 = scaleFactor * (displayWidth - 300);
  gPlotY2 = scaleFactor * (displayHeight - 140);
  
  svg = loadShape("united_states.svg");
  
  statesListLeft = gPlotX1 + (gPlotX2 - gPlotX1)/2*scaleFactor + 180*scaleFactor;
  statesListWidth = 320*scaleFactor;
  statesListHeight = (gPlotY2 - gPlotY1 - 40*scaleFactor)/5*scaleFactor;
  for(int i = 0; i < states.length - 1; i++){
    statesListTop[i] = gPlotY1+16*scaleFactor+((gPlotY2 - gPlotY1 - 40*scaleFactor)/5)*scaleFactor*i;
  }
  statesListTop[states.length - 1] = gPlotY2+30*scaleFactor;
}

void draw() {
  
  background(bgImage);
  
  drawGLayout();
  drawHeatMap();
}

void mousePressed(){
  if(mouseX >= statesListLeft && mouseX <= statesListLeft + statesListWidth) {
    statesListOldY = mouseY;
    statesListMove = true;
  }
}

void mouseReleased(){
  statesListMove = false;
}
