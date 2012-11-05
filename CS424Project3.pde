import hypermedia.net.*;
import omicronAPI.*;

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
//float[][] arrayOfFilterArrays;

boolean[] chosenMainFilterArr;

//boolean mainFilterChosen;
int numberOfFiltersChosen;

int currentFiltersCount;

// Keep track of which filters are currently selected...used for getting the appropriate data from DB
ArrayList<String> currentIntoxicants;
ArrayList<String> currentBodyTypes;
ArrayList<String> currentWeatherConds;
ArrayList<String> currentSurfaceConds;
ArrayList<String> currentARF;
ArrayList<Integer> currentAges;
String[] currentMainFilterValues;
String[] currentSubFilterValues;

boolean showMale;
boolean showFemale;
int currentYear;
int currentMonth;
int currentDayOfWeek;
int currentHour;
int startAge;
int endAge;
int numFatal;
String currentState;
// Bool to make sure we don't go to the Data frequently
boolean shouldGetNewData;
// what time frame we're looking at..1: month, 2: day: 3: hour..used for plotting and getting data
int timeScale;

ZoomButton out = new ZoomButton(5*scaleFactor,5*scaleFactor,14*scaleFactor,14*scaleFactor,false);
ZoomButton in = new ZoomButton(22*scaleFactor,5*scaleFactor,14*scaleFactor,14*scaleFactor,true);
PanButton up = new PanButton(14*scaleFactor,25*scaleFactor,14*scaleFactor,14*scaleFactor,UP);
PanButton down = new PanButton(14*scaleFactor,57*scaleFactor,14*scaleFactor,14*scaleFactor,DOWN);
PanButton left = new PanButton(5*scaleFactor,41*scaleFactor,14*scaleFactor,14*scaleFactor,LEFT);
PanButton right = new PanButton(22*scaleFactor,41*scaleFactor,14*scaleFactor,14*scaleFactor,RIGHT);

// all the buttons in one place, for looping:
Button[] buttons = { 
  in, out, up, down, left, right };

//Touch setup
OmicronAPI omicronManager;
TouchListener touchListener;
PApplet applet;
boolean displayOnWall = false;

boolean gui = true;
boolean onWall = true;
double tx, ty, sc;

PVector mapSize;
PVector mapOffset;

Hashtable touchList;

ControlP5 cp5;

InteractiveMap map;

Location locationBerlin = new Location(52.5f, 13.4f);
Location locationLondon = new Location(51.5f, 0f);
Location locationChicago = new Location(41.9f, -87.6f);

Location locationUSA = new Location(38.962f, -93.928); // Use with zoom level 6

boolean heatMap = true;

int dateMin = 2001;
int dateMax = 2010;

public void init() {
  super.init();
  omicronManager = new OmicronAPI(this);      
  if(displayOnWall) {
      omicronManager.setFullscreen(true);
  }
}

void setup() { 
  scaleFactor = 1; // 1 for widescreen monitors and 6 for the wall

  size(8160/6, 2304/6, JAVA2D);
  applet = this;
  touchListener = new TouchListener();
  omicronManager.setTouchListener(touchListener);
  if(displayOnWall) {    
    omicronManager.ConnectToTracker(7001, 7340, "131.193.77.159");
  }
  db = new DataBrowser(this, "cs424", "cs424", "crash_data_group3", "omgtracker.evl.uic.edu");
  // Local DB access for now
  //  db = new DataBrowser(this, "root", "lexmark9", "crash_data", "127.0.0.1");
//  db = new DataBrowser(this, "cs424", "cs424", "crash_data_group3", "131.193.77.110");
  // Local DB access for now
  //db = new DataBrowser(this, "root", "lexmark9", "crash_data", "127.0.0.1");

  cp5 = new ControlP5(this);

  smooth();

  helvetica = createFont("Helvetica-Bold", 14);
  textFont(helvetica);

  bgImage = loadImage("bg.jpg");
  bgImage.resize(8160/6, 2304/6);
  background(bgImage);

  gPlotX1 = scaleFactor * 100;
  gPlotY1 = scaleFactor * 70;
  //  gPlotX2 = displayWidth - 300*scaleFactor;
  //  gPlotY2 = displayHeight - 140*scaleFactor;
  gPlotX2 = width - 190*scaleFactor;
  gPlotY2 = height - 70*scaleFactor;

  chosenMainFilterArr = new boolean[8];       //Holds at most one true element, this element indicates the main filter.

  //Holds True or False for radiobuttons in filter.
  driverAgeArr = new float[7];
  driverGenderArr = new float[2];
  vehiclesRoadArr = new float[8];
  vehiclesNonRoadArr =new float[3];
  weatherArr = new float[9];
  accidentAutomobileArr = new float[7];
  accidentSurfaceArr = new float[5];
  intoxicantsArr = new float[10]; 
  
//  driverAgeArrLast = new float[7];
//  driverGenderArrLast = new float[2];
//  vehiclesRoadArrLast = new float[8];
//  vehiclesNonRoadArrLast =new float[3];
//  weatherArrLast = new float[9];
//  accidentAutomobileArrLast = new float[7];
//  accidentSurfaceArrLast = new float[5];
//  intoxicantsArrLast = new float[10]; 

  svg = loadShape("united_states.svg");
  svg.disableStyle();

  //states
  statesListLeft = 842*scaleFactor;
  statesListWidth = 281*scaleFactor;
  statesListHeight = (gPlotY2 - gPlotY1)/8;
  
  statesListButtonLeft = statesListLeft + 10*scaleFactor;
  statesListButtonWidth = 40*scaleFactor;
  statesListButtonHeight = statesListHeight-4*scaleFactor;
  
  for(int i = 0; i < states.length - 1; i++){
    statesListTop[i] = gPlotY1+16*scaleFactor+statesListHeight*i;
    statesListButtonTop[i] = statesListTop[i]+2*scaleFactor;
  }
  statesListTop[states.length - 1] = gPlotY2-45*scaleFactor;
  statesListButtonTop[states.length - 1] = statesListTop[states.length-1] + 2*scaleFactor;
  
  toggleMapLeft = width/2 - 40*scaleFactor;
  toggleMapTop = height/2 - 40*scaleFactor;
  toggleMapRight = width/2 + 40*scaleFactor;
  toggleMapBottom = height/2 + 40*scaleFactor;
  
  //Accidents
  accidentsListLeft = statesListLeft;
  accidentsListWidth = statesListWidth;
  accidentsListHeight = statesListHeight;
  
  accidentsListButtonLeft = accidentsListLeft + 10*scaleFactor;
  accidentsListButtonWidth = 40*scaleFactor;
  accidentsListButtonHeight = accidentsListHeight-4*scaleFactor;
  
  specificAccidentBackButtonWidth = 40*scaleFactor;
  specificAccidentBackButtonLeft = accidentsListLeft + accidentsListWidth - specificAccidentBackButtonWidth;
  specificAccidentBackButtonTop = gPlotY1+16*scaleFactor;
  specificAccidentBackButtonHeight = accidentsListButtonHeight;

  //Filter mechanic values
  mainFilterChosen = false;
  numberOfFiltersChosen = 0;
  subFilterValueChosen = false;

  currentFiltersCount = 0;

  currentMainFilterValues = new String[MAXNUMBEROFMAINFILTERS];
  currentSubFilterValues = new String[MAXNUMBEROFSUBFILTERS];

  generateMainFilterColors();

  //Plotting Graph
  String template = "http://{S}.mqcdn.com/tiles/1.0.0/osm/{Z}/{X}/{Y}.png";
  String[] subdomains = new String[] { 
    "otile1", "otile2", "otile3", "otile4"
  }; // optional
  
//  mapSize = new PVector( width/2, 2000 );
//  mapOffset = new PVector( width/4, 150 );
    
  map = new InteractiveMap(this, new Microsoft.RoadProvider(), width/3-100*scaleFactor, height/2, 10*scaleFactor, 10*scaleFactor);
  setMapProvider(0);
  map.setCenterZoom(locationUSA, 6); 

  touchList = new Hashtable();

  timeSliderLeft = gPlotX1+15*scaleFactor;
  timeSliderTop = gPlotY2 + 45*scaleFactor; 
  timeSliderRight = gPlotX2 - 15*scaleFactor;
  timeSliderBottom = timeSliderTop + 5*scaleFactor;
  timeSliderButtonTop = timeSliderTop - 15*scaleFactor;
  timeSliderButtonBottom = timeSliderButtonTop + 30*scaleFactor;
  timeSliderLowLeft = timeSliderLeft - 15*scaleFactor;
  timeSliderLowRight = timeSliderLeft;
  timeSliderHighLeft = timeSliderRight;
  timeSliderHighRight = timeSliderRight+15*scaleFactor;

  // lists to keep track of what current filters are selected
  currentIntoxicants = new ArrayList<String>();
  currentBodyTypes = new ArrayList<String>();
  currentWeatherConds = new ArrayList<String>();
  currentSurfaceConds = new ArrayList<String>();
  currentARF = new ArrayList<String>();
  currentAges = new ArrayList<Integer>();
  
  // keep track of some other things - when to load new data, showmale, show female, etc.
  shouldGetNewData = true;
  showMale = true;
  showFemale = true;
  startAge = 0;
  numFatal = 1;
  endAge = Integer.MAX_VALUE;
  currentState = "illinois";
  timeScale = 1;
  currentYear = 2001;
  currentDayOfWeek = 1;
  currentMonth = 1;
  currentHour = 1;

  drawLayoutMain();
  
  clearData();
  updateData();
}

void draw() {
  omicronManager.process(); //touch
  checkIfAFilterMenuIsOpen(); //to determine if subFilterLegend should appear yet or not.
//  if(filtersHaveBeenChanged()){
//    updateData();
//  }
  if (mapIsShown){
    drawMainFilterLegend();
    if(heatMap){
      background(bgImage);
      drawGLayout();
      drawMainFilterLegend();
      drawTimeSlider();
      drawHeatMap();
    }
    else {
      background(40);
      drawTimeSlider();
      drawPlotMap();
      boolean hand = false;
      if (gui) {
        for (int i = 0; i < buttons.length; i++) {
          buttons[i].draw();
          hand = hand || buttons[i].mouseOver();
        }
      }
      
      if (keyPressed) {
        if (key == CODED) {
          if (keyCode == LEFT) {
            map.tx += 5.0/map.sc;
          }
          else if (keyCode == RIGHT) {
            map.tx -= 5.0/map.sc;
          }
          else if (keyCode == UP) {
            map.ty += 5.0/map.sc;
          }
          else if (keyCode == DOWN) {
            map.ty -= 5.0/map.sc;
          }
        }  
        else if (key == '+' || key == '=') {
          map.sc *= 1.05;
        }
        else if (key == '_' || key == '-' && map.sc > 2) {
          map.sc *= 1.0/1.05;
        }
      }
      drawTimeSlider();
    }
    fill(240);
    rect(toggleMapLeft, toggleMapTop, toggleMapRight, toggleMapBottom);
    fill(40);
    textSize(18*scaleFactor);
    textAlign(CENTER);
    text("View\nState", toggleMapLeft + (toggleMapRight - toggleMapLeft)/2, toggleMapTop + (toggleMapBottom - toggleMapTop)/3);
  }
  else {
    background(bgImage);
    drawGLayout();
    drawMainFilterLegend();
    drawTimeSlider();
    drawLineGraph();
    if (subFilterValueChosen)
      drawSubFilterLegend();
  }
}

void setMapProvider(int newProviderID){
  switch( newProviderID ){
    case 0: map.setMapProvider( new Microsoft.RoadProvider() ); break;
    case 1: map.setMapProvider( new Microsoft.HybridProvider() ); break;
    case 2: map.setMapProvider( new Microsoft.AerialProvider() ); break;
  }
}

//boolean filtersHaveBeenChanged(){
//  float[] driverAgeArr, driverGenderArr;
//float[] vehiclesRoadArr, vehiclesNonRoadArr;
//float[] weatherArr;
//float[] accidentAutomobileArr, accidentSurfaceArr;
//float[] intoxicantsArr;
//}

void crashClicked(float xPos , float yPos){
  //fill accidents with points,
  accidents.clear();
  accidentsListTop.clear();
  accidentsListButtonTop.clear();
  for(int i = dateMin; i <= dateMax; i++){
    System.out.println(i + " " + dateMin + " " + dateMax);
    Crash[] year_points = statePoints.get(i).values().toArray(new Crash[0]);
    for(int j = 0; j < year_points.length; j++){
      Point p = year_points[j].coordinates;
      Point2f lp = map.locationPoint(new Location((float)p.latitude, (float)p.longitude));
      //System.out.println(sqrt(sq(xPosMap - lp.x) + sq(yPosMap - lp.y)));
      if(sqrt(sq(xPos - lp.x) + sq(yPos - lp.y)) < 4*scaleFactor){
        accidents.add(year_points[j]);
      }
    }
  }
  for(int i = 0; i < accidents.size(); i++){
    accidentsListTop.add(gPlotY1+16*scaleFactor+accidentsListHeight*i);
    accidentsListButtonTop.add(accidentsListTop.get(i)+2*scaleFactor);
  }
  viewingSpecificAccident = false;
}

void clearData(){
  dataMin = 0;
  dataMax = 0;
  for(int i = 0; i < states.length; ++i){
    statesValue[i] = 0;
  }
}

void updateDataState(){
  statePoints.clear();
  if(timeScale == 1){
    //All crashes grouped by years for a single state
    for(int i = 2001; i <= 2010; i++){
      statePoints.put((Integer)i, db.getMonthGeoDataForYear_new(selectedState, numFatal, i, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
    }
  }
  else if(timeScale == 2){
    for(int i = 1; i <= 12; i++){
      statePoints.put((Integer)i, db.getDayGeoDataForMonthYear_new(selectedState, numFatal, i, currentYear, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
    }
  }
  else if(timeScale == 3){
    for(int i = 1; i <= 7; i++){
      statePoints.put((Integer)i, db.getHourGeoDataForMonthYear_new(selectedState, numFatal, i, currentMonth, currentYear, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
    }
  }
}

void updateData(){
  statesValues.clear();
  if(timeScale == 1){
    //HeatMap of all states
    for(int i = 0; i < states.length; i++){
      statesValues.put(statesFull[i], db.getCrashNumbersForYearRange(statesFull[i], numFatal, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
    }
  }
  else if(timeScale == 2){
    for(int i = 0; i < states.length; i++){
      statesValues.put(statesFull[i], db.getCrashMonthNumbersForYear(statesFull[i], numFatal, currentYear, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
    }
  }
  else if(timeScale == 3){
    for(int i = 0; i < states.length; i++){
    statesValues.put(statesFull[i], db.getCrashDayNumbersForMonthYear(statesFull[i], numFatal, currentMonth, currentYear, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
    }
  }
//  else if(timeScale == 4){
//    for(int i = 0; i < states.length; i++){
//    statesValues.put(statesFull[i], db.getCrashNumbersForYearRange(statesFull[i], numFatal, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
//    }
//    for(int i = 1; i <= 24; i++){
//      statePoints.put((Integer)i, db.getHourGeoDataForYear_new(selectedState, numFatal, i, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
//    }
//  }
  updateDataState();
  updateDataNewRange();
}

void updateDataNewRange(){
  clearData();
  for(int i = 0; i < states.length; i++){
    int total = 0;
    for(int j = dateMin; j <= dateMax; j++){
      if (statesValues.get(statesFull[i]).get(j) != null){
        total += statesValues.get(statesFull[i]).get(j);
      }
    }
    statesValue[i] += total;
  }
  
  for(int i = 0; i < states.length-1; i++){
    for(int j = 0; j < states.length; j++){
      if (statesValue[i] < statesValue[i + 1]){
        int temp = statesValue[i+1];
        statesValue[i+1] = statesValue[i];
        statesValue[i] = temp;
        
        String tempString = statesFull[i+1];
        statesFull[i+1] = statesFull[i];
        statesFull[i] = tempString;
        
        tempString = states[i+1];
        states[i+1] = states[i];
        states[i] = tempString;
      }
    }
  }
  
  boolean swap = true;
  while(swap){
    swap = false;
    for(int i = 1; i < states.length; i++){
      if (statesValue[i-1] < statesValue[i]){
        int temp = statesValue[i-1];
        statesValue[i-1] = statesValue[i];
        statesValue[i] = temp;
        
        String tempString = statesFull[i-1];
        statesFull[i-1] = statesFull[i];
        statesFull[i] = tempString;
        
        tempString = states[i-1];
        states[i-1] = states[i];
        states[i] = tempString;
        swap = true;
      }
    }
  } 
  
  dataMin = statesValue[states.length-1];
  dataMax = statesValue[0];
}

//void mousePressed(){
//  if(mapIsShown){
//    if(heatMap){
//      if(mouseX >= statesListLeft && mouseX <= statesListLeft + statesListWidth && mouseY >= statesListTop[0] && mouseY <= statesListTop[states.length - 1] + statesListHeight) {
//        if(mouseX >= statesListButtonLeft && mouseX <= statesListButtonLeft + statesListButtonWidth){
//          if(mouseY >= statesListButtonTop[0] && mouseY <= statesListButtonTop[0] + statesListButtonHeight){
//            selectedState = statesFull[0];
//            updateDataState();
//          }
//          else if(mouseY >= statesListButtonTop[states.length-1] && mouseY <= statesListButtonTop[states.length-1] + statesListButtonHeight){
//            selectedState = statesFull[states.length-1];
//            updateDataState();
//          }
//          else{
//            for(int i = 1; i < statesListButtonTop.length-1; i++){
//              if(mouseY >= statesListButtonTop[i] && mouseY <= statesListButtonTop[i] + statesListButtonHeight){
//                selectedState = statesFull[i];
//                updateDataState();
//              }
//            }
//          }
//        }else{
//          statesListOldY = mouseY;
//          statesListMove = true;
//        }
//      }
//      else if(mouseX >= toggleMapLeft && mouseX <= toggleMapRight && mouseY >= toggleMapTop && mouseY <= toggleMapBottom){
//        heatMap = !heatMap;
//      }
//    }
//    else{
//      if(viewingSpecificAccident){
//        if(mouseX >= specificAccidentBackButtonLeft && mouseX <= specificAccidentBackButtonLeft + specificAccidentBackButtonWidth && mouseY >= specificAccidentBackButtonTop && mouseY <= specificAccidentBackButtonTop + specificAccidentBackButtonHeight){
//          viewingSpecificAccident = false;
//        }
//        else if(mouseX >= 0 && mouseX < width/2){
//          crashClicked(mouseX, mouseY);
//        }
//      }
//      else{
//        if(accidents.size() > 0){
//          if(mouseX >= accidentsListLeft && mouseX <= accidentsListLeft + accidentsListWidth && mouseY >= accidentsListTop.get(0) && mouseY <= accidentsListTop.get(accidents.size() - 1) + accidentsListHeight) {
//            if(mouseX >= accidentsListButtonLeft && mouseX <= accidentsListButtonLeft + accidentsListButtonWidth){
//              for(int i = 0; i < accidentsListButtonTop.size(); i++){
//                if(mouseY >= accidentsListButtonTop.get(i) && mouseY <= accidentsListButtonTop.get(i) + accidentsListButtonHeight){
//                  viewingSpecificAccident = true;
//                  specificAccident = i;
//                }
//              }
//            }else{
//              accidentsListOldY = mouseY;
//              accidentsListMove = true;
//            }
//          }
//          else if(mouseX >= 0 && mouseX <= width/2){
//            crashClicked(mouseX, mouseY);
//          }
//        }
//        else if(mouseX >= 0 && mouseX <= width/2){
//          crashClicked(mouseX, mouseY);
//        }
//      }
//    }
//  }
//  if(mouseY >= timeSliderButtonTop && mouseY <= timeSliderButtonBottom){
//    if(mouseX >= timeSliderLowLeft && mouseX <= timeSliderLowRight){
//      mouseXOld = mouseX;
//      timeSliderLowMove = true;
//    }
//    else if(mouseX >= timeSliderHighLeft && mouseX <= timeSliderHighRight){
//      mouseXOld = mouseX;
//      timeSliderHighMove = true;
//    }
//  }
//}
//
//void mouseReleased(){
//  statesListMove = false;
//  accidentsListMove = false;
//  timeSliderLowMove = false;
//  timeSliderHighMove = false;
//}

void keyReleased() {
  if (key == 'g' || key == 'G') {
    gui = !gui;
  }
  else if (key == 's' || key == 'S') {
    save("modest-maps-app.png");
  }
  else if (key == 'z' || key == 'Z') {
    map.sc = pow(2, map.getZoom());
  }
  else if (key == ' ') {
    map.sc = 2.0;
    map.tx = -128;
    map.ty = -128; 
  }
}

PVector lastTouchPos = new PVector();
PVector lastTouchPos2 = new PVector();
int touchID1;
int touchID2;

PVector initTouchPos = new PVector();
PVector initTouchPos2 = new PVector();

void touchDown(int ID, float xPos, float yPos, float xWidth, float yWidth){
  noFill();
  stroke(255,0,0);
  ellipse( xPos, yPos, xWidth * 2, yWidth * 2 );
  
  // Update the last touch position
  lastTouchPos.x = xPos;
  lastTouchPos.y = yPos;
  
  // Add a new touch ID to the list
  Touch t = new Touch( ID, xPos, yPos, xWidth, yWidth );
  touchList.put(ID,t);
  
  if( touchList.size() == 1 ){ // If one touch record initial position (for dragging). Saving ID 1 for later
    touchID1 = ID;
    initTouchPos.x = xPos;
    initTouchPos.y = yPos;
    if(yPos >= timeSliderButtonTop && yPos <= timeSliderButtonBottom){
      if(xPos >= timeSliderLowLeft && xPos <= timeSliderLowRight){
        mouseXOld = xPos;
        timeSliderLowMove = true;
      }
      else if(xPos >= timeSliderHighLeft && xPos <= timeSliderHighRight){
        mouseXOld = xPos;
        timeSliderHighMove = true;
      }
    }
    else if(mapIsShown){
      if(heatMap){
        if(xPos >= statesListLeft && xPos <= statesListLeft + statesListWidth && yPos >= statesListTop[0] && yPos <= statesListTop[states.length - 1] + statesListHeight) {
          if(xPos >= statesListButtonLeft && xPos <= statesListButtonLeft + statesListButtonWidth){
            if(yPos >= statesListButtonTop[0] && yPos <= statesListButtonTop[0] + statesListButtonHeight){
              selectedState = statesFull[0];
              updateDataState();
            }
            else if(yPos >= statesListButtonTop[states.length-1] && yPos <= statesListButtonTop[states.length-1] + statesListButtonHeight){
              selectedState = statesFull[states.length-1];
              updateDataState();
            }
            else{
              for(int i = 1; i < statesListButtonTop.length-1; i++){
                if(yPos >= statesListButtonTop[i] && yPos <= statesListButtonTop[i] + statesListButtonHeight){
                  selectedState = statesFull[i];
                  updateDataState();
                }
              }
            }
          }else{
            statesListOldY = yPos;
            statesListMove = true;
          }
        }
      }
      else{
        if(xPos >= 0 && xPos < width/2){
          map.tx += (xPos - lastTouchPos.x)/map.sc;
          map.ty += (yPos - lastTouchPos.y)/map.sc;
        }
        if(viewingSpecificAccident){
          if(xPos >= specificAccidentBackButtonLeft && xPos <= specificAccidentBackButtonLeft + specificAccidentBackButtonWidth && yPos >= specificAccidentBackButtonTop && yPos <= specificAccidentBackButtonTop + specificAccidentBackButtonHeight){
            viewingSpecificAccident = false;
          }
          else if(xPos >= 0 && xPos < width/2){
            crashClicked(xPos, yPos);
          }
        }
        else{
          if(accidents.size() > 0){
            if(xPos >= accidentsListLeft && xPos <= accidentsListLeft + accidentsListWidth && yPos >= accidentsListTop.get(0) && yPos <= accidentsListTop.get(accidents.size() - 1) + accidentsListHeight) {
              if(xPos >= accidentsListButtonLeft && xPos <= accidentsListButtonLeft + accidentsListButtonWidth){
                for(int i = 0; i < accidentsListButtonTop.size(); i++){
                  if(yPos >= accidentsListButtonTop.get(i) && yPos <= accidentsListButtonTop.get(i) + accidentsListButtonHeight){
                    viewingSpecificAccident = true;
                    specificAccident = i;
                  }
                }
              }else{
                accidentsListOldY = yPos;
                accidentsListMove = true;
              }
            }
            else if(xPos >= 0 && xPos <= width/2){
              crashClicked(xPos, yPos);
            }
          }
          else if(xPos >= 0 && xPos <= width/2){
            crashClicked(xPos, yPos);
          }
        }
      }
      if(xPos >= toggleMapLeft && xPos <= toggleMapRight && yPos >= toggleMapTop && yPos <= toggleMapBottom){
          heatMap = !heatMap;
      }
    }
  }
  else if( touchList.size() == 2 ){ // If second touch record initial position (for zooming). Saving ID 2 for later
    touchID2 = ID;
    initTouchPos2.x = xPos;
    initTouchPos2.y = yPos;
  }
}// touchDown

void touchMove(int ID, float xPos, float yPos, float xWidth, float yWidth){
  noFill();
  stroke(0,255,0);
  ellipse( xPos, yPos, xWidth * 2, yWidth * 2 );
  
  if( touchList.size() < 2 && !timeSliderLowMove && !timeSliderHighMove){
    // Only one touch, drag map based on last position
    map.tx += (xPos - lastTouchPos.x)/map.sc;
    map.ty += (yPos - lastTouchPos.y)/map.sc;
  }
  
  // Update touch IDs 1 and 2
  if( ID == touchID1 ){
    lastTouchPos.x = xPos;
    lastTouchPos.y = yPos;
  } else if( ID == touchID2 ){
    lastTouchPos2.x = xPos;
    lastTouchPos2.y = yPos;
  } 
  
  // Update touch list
  Touch t = new Touch( ID, xPos, yPos, xWidth, yWidth );
  touchList.put(ID,t);
}// touchMove

void touchUp(int ID, float xPos, float yPos, float xWidth, float yWidth){
  noFill();
  stroke(0,0,255);
  ellipse( xPos, yPos, xWidth * 2, yWidth * 2 );
  
  // Remove touch and ID from list
  touchList.remove(ID);
  statesListMove = false;
  accidentsListMove = false;
  timeSliderLowMove = false;
  timeSliderHighMove = false;
}// touchUp
