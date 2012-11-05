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

ControlP5 cp5;

InteractiveMap map;

Location locationBerlin = new Location(52.5f, 13.4f);
Location locationLondon = new Location(51.5f, 0f);
Location locationChicago = new Location(41.9f, -87.6f);

Location locationUSA = new Location(38.962f, -93.928); // Use with zoom level 6

boolean heatMap = true;

int dateMin = 2001;
int dateMax = 2010;

void setup() {
  // init databrowser obj
<<<<<<< HEAD
  db = new DataBrowser(this, "cs424", "cs424", "crash_data_group3", "omgtracker.evl.uic.edu");
  // Local DB access for now
  //  db = new DataBrowser(this, "root", "lexmark9", "crash_data", "127.0.0.1");
=======
  db = new DataBrowser(this, "cs424", "cs424", "crash_data_group3", "131.193.77.110");
  // Local DB access for now
  //db = new DataBrowser(this, "root", "lexmark9", "crash_data", "127.0.0.1");
>>>>>>> 3101d43dd71e19a7ea5fe3ff3577e27d30333507

  scaleFactor = 1; // 1 for widescreen monitors and 6 for the wall
  displayWidth = WALLWIDTH / 6 * scaleFactor;
  displayHeight = WALLHEIGHT / 6 * scaleFactor;

  size(scaleFactor * displayWidth, scaleFactor * displayHeight, JAVA2D);

  cp5 = new ControlP5(this);

  smooth();

  helvetica = createFont("Helvetica-Bold", 14);
  textFont(helvetica);

  bgImage = loadImage("bg.jpg");
  bgImage.resize(displayWidth * scaleFactor, displayHeight * scaleFactor);
  background(bgImage);

  gPlotX1 = scaleFactor * 100;
  gPlotY1 = scaleFactor * 70;
  //  gPlotX2 = displayWidth - 300*scaleFactor;
  //  gPlotY2 = displayHeight - 140*scaleFactor;
  gPlotX2 = displayWidth - 190*scaleFactor;
  gPlotY2 = displayHeight - 70*scaleFactor;

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
  
  toggleMapLeft = statesListLeft + statesListWidth + 15*scaleFactor;
  toggleMapTop = statesListTop[0];
  toggleMapRight = toggleMapLeft + 15*scaleFactor;
  toggleMapBottom = toggleMapTop + 15*scaleFactor;
  
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
  map = new InteractiveMap(this, new Microsoft.RoadProvider(), width/3-100*scaleFactor, height/2, 10*scaleFactor, 10*scaleFactor);
  setMapProvider(0);
  map.setCenterZoom(locationUSA, 6); 

  timeSliderLeft = gPlotX1+15*scaleFactor;
  timeSliderTop = gPlotY2 + 45*scaleFactor; 
  timeSliderRight = gPlotX2 - 15*scaleFactor;
  timeSliderBottom = timeSliderTop + 5*scaleFactor;
  timeSliderButtonTop = timeSliderTop - 45/2*scaleFactor;
  timeSliderButtonBottom = timeSliderButtonTop + 45*scaleFactor;
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
      drawHeatMap();
    }
    else {
      background(40);
      drawPlotMap();
    }
  }
  else {
    background(bgImage);
    drawGLayout();
    drawMainFilterLegend();
    drawLineGraph();
    if (subFilterValueChosen)
      drawSubFilterLegend();
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

void updateData(){
  statesValues.clear();
  statePoints.clear();
  for(int i = 0; i < states.length; i++){
    statesValues.put(statesFull[i], db.getCrashNumbersForYearRange(statesFull[i], numFatal, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
  }
  for(int i = 2001; i < 2010; i++){
    statePoints.put((Integer)i, db.getMonthGeoDataForYear_new(selectedState, numFatal, i, currentAges, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge));
  }
  
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

void mousePressed(){
  if(mapIsShown){
    if(heatMap){
      if(mouseX >= statesListLeft && mouseX <= statesListLeft + statesListWidth && mouseY >= statesListTop[0] && mouseY <= statesListTop[states.length - 1] + statesListHeight) {
        if(mouseX >= statesListButtonLeft && mouseX <= statesListButtonLeft + statesListButtonWidth){
          if(mouseY >= statesListButtonTop[0] && mouseY <= statesListButtonTop[0] + statesListButtonHeight){
            selectedState = statesFull[0];
          }
          else if(mouseY >= statesListButtonTop[states.length-1] && mouseY <= statesListButtonTop[states.length-1] + statesListButtonHeight){
            selectedState = statesFull[states.length-1];
          }
          else{
            for(int i = 1; i < statesListButtonTop.length-1; i++){
              if(mouseY >= statesListButtonTop[i] && mouseY <= statesListButtonTop[i] + statesListButtonHeight){
                selectedState = statesFull[i];
              }
            }
          }
        }else{
          statesListOldY = mouseY;
          statesListMove = true;
        }
      }
      else if(mouseX >= toggleMapLeft && mouseX <= toggleMapRight && mouseY >= toggleMapTop && mouseY <= toggleMapBottom){
        heatMap = !heatMap;
      }
    }
    else{
      if(viewingSpecificAccident){
        if(mouseX >= specificAccidentBackButtonLeft && mouseX <= specificAccidentBackButtonLeft + specificAccidentBackButtonWidth && mouseY >= specificAccidentBackButtonTop && mouseY <= specificAccidentBackButtonTop + specificAccidentBackButtonHeight){
          viewingSpecificAccident = false;
        }
        else if(mouseX >= 0){
          crashClicked(mouseX, mouseY);
        }
      }
      else{
        if(accidents.size() > 0){
          if(mouseX >= accidentsListLeft && mouseX <= accidentsListLeft + accidentsListWidth && mouseY >= accidentsListTop.get(0) && mouseY <= accidentsListTop.get(accidents.size() - 1) + accidentsListHeight) {
            if(mouseX >= accidentsListButtonLeft && mouseX <= accidentsListButtonLeft + accidentsListButtonWidth){
              for(int i = 0; i < accidentsListButtonTop.size(); i++){
                if(mouseY >= accidentsListButtonTop.get(i) && mouseY <= accidentsListButtonTop.get(i) + accidentsListButtonHeight){
                  viewingSpecificAccident = true;
                  specificAccident = i;
                }
              }
            }else{
              accidentsListOldY = mouseY;
              accidentsListMove = true;
            }
          }
          else if(mouseX >= 0){
            crashClicked(mouseX, mouseY);
          }
        }
        else if(mouseX >= 0){
          crashClicked(mouseX, mouseY);
        }
      }
    }
  }
  if(mouseY >= timeSliderButtonTop && mouseY <= timeSliderButtonBottom){
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
  accidentsListMove = false;
  timeSliderLowMove = false;
  timeSliderHighMove = false;
}
