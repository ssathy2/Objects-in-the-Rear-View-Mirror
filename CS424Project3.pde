import com.modestmaps.*;
import com.modestmaps.core.*;
import com.modestmaps.geo.*;
import com.modestmaps.providers.*;

import controlP5.*;

final static int WALLWIDTH = 8160;
final static int WALLHEIGHT = 2304;
int displayWidth, displayHeight;
static int scaleFactor;
DataBrowser db;
PImage bgImage;
PShape svg;

//Boolean arrays to hold values of radiobuttons
float[] driverAgeArr, driverGenderArr;
float[] vehiclesRoadArr, vehiclesNonRoadArr;
float[] weatherArr;
float[] accidentAutomobileArr, accidentSurfaceArr;
float[] intoxicantsArr;

ControlP5 cp5;


InteractiveMap map;

Location locationBerlin = new Location(52.5f, 13.4f);
Location locationLondon = new Location(51.5f, 0f);
Location locationChicago = new Location(41.9f, -87.6f);

Location locationUSA = new Location(38.962f, -93.928); // Use with zoom level 6

void setup() {
  // init databrowser obj
  // db = new DataBrowser(this, "cs424", "cs424", "crash_data_group3", "omgtracker.evl.uic.edu");
  // Local DB access for now
  db = new DataBrowser(this, "root", "lexmark9", "crash_data", "127.0.0.1");
  
  scaleFactor = 1; // 1 for widescreen monitors and 6 for the wall
  displayWidth = WALLWIDTH / 6 * scaleFactor;
  displayHeight = WALLHEIGHT / 6 * scaleFactor;

  size(scaleFactor * displayWidth, scaleFactor * displayHeight, JAVA2D);
  
  cp5 = new ControlP5(this);
  
  bgImage = loadImage("bg.jpg");
  bgImage.resize(displayWidth * scaleFactor, displayHeight * scaleFactor);
  background(bgImage);
  
  gPlotX1 = scaleFactor * 100;
  gPlotY1 = scaleFactor * 70;
//  gPlotX2 = displayWidth - 300*scaleFactor;
//  gPlotY2 = displayHeight - 140*scaleFactor;
  gPlotX2 = displayWidth - 190*scaleFactor;
  gPlotY2 = displayHeight - 70*scaleFactor;
  
  //Holds True or False for radiobuttons in filter.
  driverAgeArr = new float[7];
  driverGenderArr = new float[2];
  vehiclesRoadArr = new float[8];
  vehiclesNonRoadArr =new float[3];
  weatherArr = new float[9];
  accidentAutomobileArr = new float[7];
  accidentSurfaceArr = new float[5];
  intoxicantsArr = new float[8];
  
  svg = loadShape("united_states.svg");
  svg.disableStyle();
  
  
  //states
  statesListLeft = 491*scaleFactor+311*scaleFactor;
  statesListWidth = 281*scaleFactor;
  statesListHeight = (gPlotY2 - gPlotY1)/8;
  
  statesListButtonLeft = statesListLeft + 10*scaleFactor;
  statesListButtonWidth = 40*scaleFactor;
  statesListButtonHeight = statesListHeight-4*scaleFactor;
  
  for(int i = 0; i < states.length - 1; i++){
    statesListTop[i] = gPlotY1+16*scaleFactor+((gPlotY2 - gPlotY1)/8)*scaleFactor*i;
    statesListButtonTop[i] = statesListTop[i]+2*scaleFactor;
  }
  statesListTop[states.length - 1] = gPlotY2-45*scaleFactor;
  statesListButtonTop[states.length - 1] = statesListTop[states.length-1] + 2*scaleFactor;
  
  
  //Accidents
  accidentsListLeft = 491*scaleFactor+311*scaleFactor;
  accidentsListWidth = 281*scaleFactor;
  accidentsListHeight = (gPlotY2 - gPlotY1 - 40*scaleFactor)/5*scaleFactor;
  
  accidentsListButtonLeft = accidentsListLeft + 10*scaleFactor;
  accidentsListButtonWidth = 40*scaleFactor;
  accidentsListButtonHeight = accidentsListHeight-4*scaleFactor;
  
  for(int i = 0; i < accidents.length; i++){
    accidentsListTop[i] = gPlotY1+16*scaleFactor+((gPlotY2 - gPlotY1 - 40*scaleFactor)/5)*scaleFactor*i;
    accidentsListButtonTop[i] = accidentsListTop[i]+2*scaleFactor;
  }
  
  //Plotting Graph
  String template = "http://{S}.mqcdn.com/tiles/1.0.0/osm/{Z}/{X}/{Y}.png";
  String[] subdomains = new String[] { "otile1", "otile2", "otile3", "otile4" }; // optional
  map = new InteractiveMap(this, new Microsoft.RoadProvider(), width/3-100, height/2, 10, 10);
  setMapProvider(0);
  map.setCenterZoom(locationUSA, 3);
  
  
  
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


  drawLayoutMain();
}

void draw() {
  
  background(bgImage);
  drawGLayout();
  if (mapIsShown){
    drawHeatMap();
  }
  else{
  }
  drawTimeSlider();
}

void setMapProvider(int newProviderID){
  switch( newProviderID ){
    case 0: map.setMapProvider( new Microsoft.RoadProvider() ); break;
    case 1: map.setMapProvider( new Microsoft.HybridProvider() ); break;
    case 2: map.setMapProvider( new Microsoft.AerialProvider() ); break;
  }
}

void mousePressed(){
  //if(false){
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
//  }else if(true){
//    if(mouseX >= accidentsListLeft && mouseX <= accidentsListLeft + accidentsListWidth && mouseY >= accidentsListTop[0] && mouseY <= accidentsListTop[accidents.length - 1] + accidentsListHeight) {
//      if(mouseX >= accidentsListButtonLeft && mouseX <= accidentsListButtonLeft + accidentsListButtonWidth){
//        if(mouseY >= accidentsListButtonTop[0] && mouseY <= accidentsListButtonTop[0] + accidentsListButtonHeight){
//          selectedState = 0;
//        }
//        else if(mouseY >= accidentsListButtonTop[accidents.length-1] && mouseY <= accidentsListButtonTop[accidents.length-1] + accidentsListButtonHeight){
//          selectedState = accidents.length-1;
//        }
//        else{
//          for(int i = 1; i < accidentsListButtonTop.length-1; i++){
//            if(mouseY >= accidentsListButtonTop[i] && mouseY <= accidentsListButtonTop[i] + accidentsListButtonHeight){
//              selectedState = i;
//            }
//          }
//        }
//      }else{
//        accidentsListOldY = mouseY;
//        accidentsListMove = true;
//      }
//    }
//  }
}

void mouseReleased(){
  statesListMove = false;
  accidentsListMove = false;
  timeSliderLowMove = false;
  timeSliderHighMove = false;
}
