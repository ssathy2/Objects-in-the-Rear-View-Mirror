import controlP5.*;
import java.util.*;

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
  svg.disableStyle();
  
  statesListLeft = 491*scaleFactor+311*scaleFactor;
  statesListWidth = 281*scaleFactor;
  statesListHeight = (gPlotY2 - gPlotY1 - 40*scaleFactor)/5*scaleFactor;
  
  statesListButtonLeft = statesListLeft + 10*scaleFactor;
  statesListButtonWidth = 40*scaleFactor;
  statesListButtonHeight = statesListHeight-4*scaleFactor;
  
  for(int i = 0; i < states.length - 1; i++){
    statesListTop[i] = gPlotY1+16*scaleFactor+((gPlotY2 - gPlotY1 - 40*scaleFactor)/5)*scaleFactor*i;
    statesListButtonTop[i] = statesListTop[i]+2*scaleFactor;
  }
  statesListTop[states.length - 1] = gPlotY2+30*scaleFactor;
  statesListButtonTop[states.length - 1] = statesListTop[states.length-1] + 2*scaleFactor;
  
  
  timeSliderLeft = gPlotX1+15*scaleFactor;
  timeSliderTop = gPlotY2 + 115*scaleFactor;
  timeSliderRight = timeSliderLeft + gPlotX2 - gPlotX1 +72*scaleFactor;
  timeSliderBottom = timeSliderTop + 5*scaleFactor;
  timeSliderButtonTop = timeSliderTop - 45/2*scaleFactor;
  timeSliderButtonBottom = timeSliderButtonTop + 45*scaleFactor;
  timeSliderLowLeft = timeSliderLeft - 15*scaleFactor;
  timeSliderLowRight = timeSliderLeft;
  timeSliderHighLeft = timeSliderRight;
  timeSliderHighRight = timeSliderRight+15*scaleFactor;
}

void draw() {
  
  background(bgImage);
  
  drawGLayout();
  drawHeatMap();
  drawTimeSlider();
}

void mousePressed(){
  if(mouseX >= statesListLeft && mouseX <= statesListLeft + statesListWidth && mouseY >= statesListTop[0] && mouseY <= statesListTop[states.length - 1] + statesListHeight) {
    if(mouseX >= statesListButtonLeft && mouseX <= statesListButtonLeft + statesListButtonWidth){
      if(mouseY >= statesListButtonTop[0] && mouseY <= statesListButtonTop[0] + statesListButtonHeight){
        selectedState = 0;
      }
      else if(mouseY >= statesListButtonTop[states.length-1] && mouseY <= statesListButtonTop[states.length-1] + statesListButtonHeight){
        selectedState = states.length-1;
      }
      else{
        for(int i = 1; i < statesListButtonTop.length-1; i++){
          if(mouseY >= statesListButtonTop[i] && mouseY <= statesListButtonTop[i] + statesListButtonHeight){
            selectedState = i;
          }
        }
      }
    }else{
      statesListOldY = mouseY;
      statesListMove = true;
    }
  }
  else if(mouseY >= timeSliderButtonTop && mouseY <= timeSliderButtonBottom){
    if(mouseX >= timeSliderLowLeft && mouseX <= timeSliderLowRight){
      mouseXOld = mouseX;
      timeSliderLowMove = true;
    }
    else if(mouseX >= timeSliderHighLeft && mouseX <= timeSliderHighRight){
      mouseXOld = mouseX;
      timeSliderHighMove = true;
    }
  }
}

void mouseReleased(){
  statesListMove = false;
  timeSliderLowMove = false;
  timeSliderHighMove = false;
}
