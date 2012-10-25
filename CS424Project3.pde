import controlP5.*;

final static int WALLWIDTH = 8160;
final static int WALLHEIGHT = 2304;
int displayWidth, displayHeight;
static int scaleFactor;
PImage bgImage;
PShape svg;


ControlP5 cp5;

void setup() {

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
}

void draw() {
  
  background(bgImage);
  
  drawGLayout();
  drawHeatMap();
}

