/* Class file for the filter menu buttons, linegraph button, map graph button, help button, national comparison button, and any other
 part of the general ui */
float timeSliderLeft, timeSliderRight, timeSliderTop, timeSliderBottom, timeSliderLowLeft, timeSliderButtonTop, timeSliderButtonBottom, timeSliderLowRight, timeSliderHighLeft, timeSliderHighRight, mouseXOld;

boolean timeSliderLowMove = false;
boolean timeSliderHighMove = false;

//Method to draw 6 filter category tabs to the right of the graph... these are actually cp5 buttons, not tabs

boolean mapIsShown;          //boolean toggle for showing linegraph or map graph
boolean filterMenuIsOpen;    //boolean for clear button to show or not
boolean subFilterValueChosen;    //boolean for toggling visibility of subfilters legend in linegraph

boolean potentialMainFilter;
boolean mainFilterChosen;
/*PImage[] imgs = {
 loadImage("contact.png"), loadImage("wheel.png"), loadImage("weather.png"), loadImage("clock.png"), loadImage("emergency.png"), loadImage("drugs.png")
 }; */

float firstFilterTabPlotX, firstFilterTabPlotY;
float graphSwitchTopPlotY, graphSwitchTopPlotX;

float helpX, helpY;

float nationalAvgX, nationalAvgY;

CheckBox driverAge, driverGender;
CheckBox vehiclesRoad, vehiclesNonRoad;
CheckBox weather;
CheckBox accidentAutomobile, accidentSurface;
CheckBox intoxicants;

void drawLayoutMain() {
  rectMode(CORNERS);
  firstFilterTabPlotX = gPlotX2;
  firstFilterTabPlotY = gPlotY1 + (scaleFactor * 5);

  graphSwitchTopPlotX = firstFilterTabPlotX + (scaleFactor * 91);
  graphSwitchTopPlotY = firstFilterTabPlotY + (scaleFactor * 15);

  //Groups of CP5 controllers for the filtering buttons

  cp5.setColorForeground(#FFFFFF);
  cp5.setColorBackground(#E8EAE8);
  cp5.setColorLabel(20);
  cp5.setColorActive(#FC3333);
  cp5.setColorValue(#FC3333);

  drawFilterTabs();

  drawDriverFilterControllers();
  drawVehicleFilterControllers();
  drawWeatherFilterControllers();
  drawTimeFilterControllers();
  drawAccidentFilterControllers();
  drawIntoxicantFilterControllers();

  drawStateSelectionController();
  drawHelpButton();
  drawNationalAverageButton();

  drawClearFilterValuesButton();

  drawGraphSwitchButtons();
}

void checkIfAFilterMenuIsOpen()
{
  if (cp5.getGroup("g1").isVisible() | cp5.getGroup("g2").isVisible() 
    | cp5.getGroup("g3").isVisible() | cp5.getGroup("g4").isVisible() 
    | cp5.getGroup("g5").isVisible() | cp5.getGroup("g6").isVisible())
    filterMenuIsOpen = true;

  else
    filterMenuIsOpen = false;

  if (filterMenuIsOpen) {
    cp5.getController("clear")
      .setVisible(true);
  }
  else {
    cp5.getController("clear")
      .setVisible(false);
  }
}

void drawNationalAverageButton() {

  nationalAvgX=helpX - scaleFactor * 60;
  nationalAvgY=gPlotY2 + (scaleFactor * 15);
  
  cp5.addBang("nationalAvg")
    .setPosition(nationalAvgX, nationalAvgY)
      .setSize(scaleFactor * 50, scaleFactor * 40)
        .setCaptionLabel("National\nAverage")
          .setTriggerEvent(Bang.PRESSED)
            .setColorActive(#ADEAB4)
              .setColorForeground(#35D148) 
                .setColorLabel(20)
                  .getCaptionLabel().align(CENTER, CENTER)
                    ;
}

void drawHelpButton() {

helpX = graphSwitchTopPlotX + scaleFactor * 30;
helpY = gPlotY2 + (scaleFactor * 15);


  cp5.addBang("Help")
    .setPosition(helpX, helpY)
      .setSize(scaleFactor * 50, scaleFactor * 40)
        .setCaptionLabel("Help")
          .setTriggerEvent(Bang.PRESSED)
            .setColorActive(#F59188)
              .setColorForeground(#ED3322) 
                .setColorLabel(20)
                  .getCaptionLabel().align(CENTER, CENTER)
                    ;
}

void drawClearFilterValuesButton() {

  cp5.addBang("clear")
    .setPosition(gPlotX2 - (scaleFactor * 115), gPlotY2 + (scaleFactor * 4))
      .setSize(100, 30)
        .setCaptionLabel("Clear Filters")
          .setTriggerEvent(Bang.PRESSED)
            .getCaptionLabel().align(CENTER, CENTER)
              ;
}



void drawFilterTabs() {


  Group filterGroup = cp5.addGroup("filterGroup")
    .setPosition(firstFilterTabPlotX, firstFilterTabPlotY + (scaleFactor * 10))
      .setBackgroundHeight(int(scaleFactor * (gPlotY2 - gPlotY1)))
        .setWidth(scaleFactor * 90)
          .hideBar()
            .setBackgroundColor(color(0, 1))// invisible background
              .activateEvent(true)
                ;

  cp5.addButton("Driver\nVariables", 1)
    .setId(1)
      .setPosition(0, 0)
        .setSize(scaleFactor * 90, scaleFactor * 35)
          .setGroup(filterGroup)
            .getCaptionLabel().align(RIGHT, TOP);


  cp5.addButton("Vehicle\nVariables", 2)
    .setId(2)
      .setPosition(0, scaleFactor * 36)
        .setSize(scaleFactor * 90, scaleFactor * 35)
          .setGroup(filterGroup)
            .getCaptionLabel().align(RIGHT, TOP);

  cp5.addButton("Weather\nVariables", 3)
    .setId(3)
      .setPosition(0, scaleFactor * 72)
        .setSize(scaleFactor * 90, scaleFactor * 35)
          .setGroup(filterGroup)
            .getCaptionLabel().align(RIGHT, TOP);

  cp5.addButton("Time\nVariables", 4)
    .setId(4)
      .setPosition(0, scaleFactor * 108)
        .setSize(scaleFactor * 90, scaleFactor * 35)
          .setGroup(filterGroup)
            .getCaptionLabel().align(RIGHT, TOP);

  cp5.addButton("Accident\nVariables", 5)
    .setId(5)
      .setPosition(0, scaleFactor * 144)
        .setSize(scaleFactor * 90, scaleFactor * 35)
          .setGroup(filterGroup)
            .getCaptionLabel().align(RIGHT, TOP);

  cp5.addButton("Intoxicant\nVariables", 6)
    .setId(6)
      .setPosition(0, scaleFactor * 180)
        .setSize(scaleFactor * 90, scaleFactor * 35)
          .setGroup(filterGroup)
            .getCaptionLabel().align(RIGHT, TOP);
}

void drawGraphSwitchButtons() {

  Group graphSwitchGroup = cp5.addGroup("graphSwitchGroup")
    .setPosition(int(graphSwitchTopPlotX), int(graphSwitchTopPlotY))
      .setBackgroundHeight(int(scaleFactor * (gPlotY2 - gPlotY1)))
        .setWidth(scaleFactor * 100)
          .hideBar()
            .setBackgroundColor(color(0, 1))// invisible background
              .activateEvent(true)
                ;

  cp5.addButton("Map")
    .setId(1)
      .setSize(scaleFactor * 100, scaleFactor * 100)
        .setColorForeground(#A9C7FA)
          .setColorBackground(#6D9EF0)
            .setColorValue(#072E05)
              .setPosition(0, 0)
                .setGroup(graphSwitchGroup)
                  .setColorActive(#025CE8);


  cp5.addButton("Graph")
    .setId(2)
      .setSize(scaleFactor * 100, scaleFactor * 100)
        .setColorForeground(#F79B9B)
          .setColorBackground(#EA5050)
            .setColorValue(#072E05)
              .setPosition(0, scaleFactor * 101)
                .setGroup(graphSwitchGroup)
                  .setColorActive(#FC1C1C);
}



void clear() {          // Method to clear enabled filters in currently open filter category

  if (cp5.getGroup("g1").isVisible()) {
    driverAgeArr = new float[7];
    driverGenderArr = new float[2];

    cp5.getGroup("driverAge").setArrayValue(driverAgeArr);
    cp5.getGroup("driverGender").setArrayValue(driverGenderArr);
    showMale = true;
    showFemale = true;
    shouldGetNewData = true;
  }
  else if (cp5.getGroup("g2").isVisible()) {
    vehiclesRoadArr = new float[8];
    vehiclesNonRoadArr = new float[3];
    currentBodyTypes.clear();
    shouldGetNewData = true;
    cp5.getGroup("vehiclesRoad").setArrayValue(vehiclesRoadArr);
    cp5.getGroup("vehiclesNonRoad").setArrayValue(vehiclesNonRoadArr);
  }
  else if (cp5.getGroup("g3").isVisible()) {
    weatherArr = new float[9];
    currentWeatherConds.clear();
    shouldGetNewData = true;
    cp5.getGroup("weather").setArrayValue(weatherArr);
  }
  else if (cp5.getGroup("g4").isVisible()) {
  }
  else if (cp5.getGroup("g5").isVisible()) {
    accidentAutomobileArr = new float[7];
    accidentSurfaceArr = new float[5];
    currentSurfaceConds.clear();
    currentARF.clear();
    shouldGetNewData = true;
    cp5.getGroup("accidentAutomobile").setArrayValue(accidentAutomobileArr);
    cp5.getGroup("accidentSurface").setArrayValue(accidentSurfaceArr);
  }
  else if (cp5.getGroup("g6").isVisible()) {
    intoxicantsArr = new float[8];
    currentIntoxicants.clear();
    shouldGetNewData = true;
    cp5.getGroup("intoxicants").setArrayValue(intoxicantsArr);
  }
}



//
//
// Code to retrieve a controller's group:  theEvent.getController().getParent().getName();

public void controlEvent(ControlEvent theEvent) {


  if (theEvent.isController()) {
    if (theEvent.getController().getParent().getName() == "graphSwitchGroup") {    //Control events for the map/graph switch buttons

      println("Entered graphSwitchGroup group condition.");

      switch(theEvent.getController().getId()) {
        case(1):
        mapIsShown = true;
        ssListBox.setVisible(false);
        break;
        case(2):
        mapIsShown = false;
        ssListBox.setVisible(true);
        break;
      }
    }


    if (theEvent.getController().getParent().getName() == "filterGroup") {    //Control events for filter menu buttons

      determineMainFilterOrSub();

      //println("clicking in filterGroup: potentialMainFilter: " + potentialMainFilter);
      //println("clicking in filterGroup:  mainFilterChosen: " + mainFilterChosen + "\n");

      switch(theEvent.getController().getId()) {
        case(1):    //Driver vars

        if (!cp5.getGroup("g1").isVisible()) 
          resetFilterGroups();

        resetSubFilterGroups();
        cp5.getGroup("g1").setVisible(!cp5.getGroup("g1").isVisible());



        break;
        case(2): //Vehicle vars

        if (!cp5.getGroup("g2").isVisible()) 
          resetFilterGroups();

        resetSubFilterGroups();

        cp5.getGroup("subg21").setVisible(!cp5.getGroup("g2").isVisible());
        cp5.getGroup("subg22").setVisible(!cp5.getGroup("g2").isVisible());

        cp5.getGroup("g2").setVisible(!cp5.getGroup("g2").isVisible());

        break;
        case(3):    //Weather vars

        if (!cp5.getGroup("g3").isVisible()) 
          resetFilterGroups();

        resetSubFilterGroups();
        cp5.getGroup("g3").setVisible(!cp5.getGroup("g3").isVisible());

        break;
        case(4):// Time Vars

        if (!cp5.getGroup("g4").isVisible()) 
          resetFilterGroups();

        resetSubFilterGroups();
        cp5.getGroup("g4").setVisible(!cp5.getGroup("g4").isVisible());

        break;
        case(5): //Accident Vars

        if (!cp5.getGroup("g5").isVisible()) 
          resetFilterGroups();

        resetSubFilterGroups();
        cp5.getGroup("g5").setVisible(!cp5.getGroup("g5").isVisible());

        break;
        case(6):   //Intoxicant vars

        if (!cp5.getGroup("g6").isVisible()) 
          resetFilterGroups();

        resetSubFilterGroups();
        cp5.getGroup("g6").setVisible(!cp5.getGroup("g6").isVisible());

        break;
      }
    }




    if (cp5.getGroup("g1").isVisible() && theEvent.getController().getParent().getName() == "g1") {      //If Driver variables menu is open and the event's controller belongs to the correct group

      determineMainFilterOrSub();

      switch(theEvent.getController().getId()) {
        case(1):

        if ( !cp5.getGroup("g1Second1").isVisible())
          resetSubFilterGroups();

        cp5.getGroup("g1Second1").setVisible(!cp5.getGroup("g1Second1").isVisible());

        if (cp5.getGroup("g1Second1").isVisible() && theEvent.isFrom(driverAge)) {

          driverAgeArr = driverAge.getArrayValue();
          for (float i: driverAgeArr)
            println("Driver Age: " + i);
        }

        break;
        case(2):

        if ( !cp5.getGroup("g1Second2").isVisible())
          resetSubFilterGroups();

        cp5.getGroup("g1Second2").setVisible(!cp5.getGroup("g1Second2").isVisible());

        break;
      }
    }

    if (cp5.getGroup("g5").isVisible() && theEvent.getController().getParent().getName() == "g5") {      //If Accident variables menu is open

      determineMainFilterOrSub();

      switch(theEvent.getController().getId()) {
        case(1):

        if ( !cp5.getGroup("g5Second1").isVisible())
          resetSubFilterGroups();

        cp5.getGroup("g5Second1").setVisible(!cp5.getGroup("g5Second1").isVisible());

        break;
        case(2):

        if ( !cp5.getGroup("g5Second2").isVisible())
          resetSubFilterGroups();

        cp5.getGroup("g5Second2").setVisible(!cp5.getGroup("g5Second2").isVisible());

        break;
        case(3):

        if ( !cp5.getGroup("g5Second3").isVisible())
          resetSubFilterGroups();

        cp5.getGroup("g5Second3").setVisible(!cp5.getGroup("g5Second3").isVisible());

        break;
      }
    }
    if (cp5.getGroup("g4").isVisible() && theEvent.getController().getParent().getName() == "g4") {
      // set timescale for what we're displaying on the graph/map
      if (theEvent.getLabel().equals("Year Range")) {
        timeScale = 1; 
        shouldGetNewData = true;
      }
      else if (theEvent.getLabel().equals("Months of a Year")) {
        timeScale = 2; 
        shouldGetNewData = true;
      }
      else if (theEvent.getLabel().equals("Weekday Averages")) {
        timeScale = 3; 
        shouldGetNewData = true;
      }
      else if (theEvent.getLabel().equals("Time of Day Averages")) {
        timeScale = 4; 
        shouldGetNewData = true;
      }
    }
  }


  if (theEvent.isGroup())
  {

    if(theEvent.name().equals("stateSelection")){
      
      int stateIndex = (int)theEvent.group().value();
      println("New State: " + ssListBox.getItem(stateIndex).getText());
      currentState = ssListBox.getItem(stateIndex).getText();
      shouldGetNewData = true;
      
    }
    if (theEvent.isFrom(driverAge)) {

      driverAgeArr = driverAge.getArrayValue();

      for (int i = 0; i < driverAgeArr.length; i++) {
        println("driverAgeArr[" + i + "] = " + driverAgeArr[i]);
      }
    }

    if (theEvent.isFrom(driverGender)) {

      driverGenderArr = driverGender.getArrayValue();
      showMale = showFemale = false;

      for (int i = 0; i < driverGenderArr.length; i++) {
        println("driverGenderArr[" + i + "] = " + driverGenderArr[i]);
        shouldGetNewData = true;
        if (driverGenderArr[i] == 1) {
          if (i == 0) showMale = true;
          else if (i == 1) showFemale = true;
        }
      }
    }

    if (theEvent.isFrom(vehiclesRoad)) {

      vehiclesRoadArr = vehiclesRoad.getArrayValue();
      for (int i = 0; i < vehiclesRoadArr.length; i++) {
        println("vehiclesRoadArr[" + i + "] = " + vehiclesRoadArr[i]);
        if (vehiclesRoadArr[i] == 1) {
          println(vehiclesRoad.getItem(i).getLabel());
          if (!currentBodyTypes.contains(vehiclesRoad.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentBodyTypes.add(vehiclesRoad.getItem(i).getLabel());
          }
        }
        else {
          println(vehiclesRoad.getItem(i).getLabel());
          if (currentBodyTypes.contains(vehiclesRoad.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentBodyTypes.remove(vehiclesRoad.getItem(i).getLabel());
          }
        }
      }
    }

    if (theEvent.isFrom(vehiclesNonRoad)) {

      vehiclesNonRoadArr = vehiclesNonRoad.getArrayValue();

      for (int i = 0; i < vehiclesNonRoadArr.length; i++) {
        println("vehiclesNonRoadArr[" + i + "] = " + vehiclesNonRoadArr[i]);
        if (vehiclesNonRoadArr[i] == 1) {
          println(vehiclesNonRoad.getItem(i).getLabel());
          if (!currentBodyTypes.contains(vehiclesNonRoad.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentBodyTypes.add(vehiclesNonRoad.getItem(i).getLabel());
          }
        }
        else {
          println(vehiclesNonRoad.getItem(i).getLabel());
          if (currentBodyTypes.contains(vehiclesNonRoad.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentBodyTypes.remove(vehiclesNonRoad.getItem(i).getLabel());
          }
        }
      }
      println(currentBodyTypes.size());
    }

    if (theEvent.isFrom(weather)) {

      weatherArr = weather.getArrayValue();
      for (int i = 0; i < weatherArr.length; i++) {
        println("weatherArr[" + i + "] = " + weatherArr[i]);
        if (weatherArr[i] == 1) {
          println(weather.getItem(i).getLabel());
          if (!currentWeatherConds.contains(weather.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentWeatherConds.add(weather.getItem(i).getLabel());
          }
        }
        else {
          println(weather.getItem(i).getLabel());
          if (currentWeatherConds.contains(weather.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentWeatherConds.remove(weather.getItem(i).getLabel());
          }
        }
      }
    }

    if (theEvent.isFrom(accidentAutomobile)) {

      accidentAutomobileArr = accidentAutomobile.getArrayValue();
      for (int i = 0; i < accidentAutomobileArr.length; i++) {
        println("accidentAutomobileArr[" + i + "] = " + accidentAutomobileArr[i]);
        if (accidentAutomobileArr[i] == 1) {
          println(accidentAutomobile.getItem(i).getLabel());
          if (!currentARF.contains(accidentAutomobile.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentARF.add(accidentAutomobile.getItem(i).getLabel());
          }
        }
        else {
          println(accidentAutomobile.getItem(i).getLabel());
          if (currentARF.contains(accidentAutomobile.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentARF.remove(accidentAutomobile.getItem(i).getLabel());
          }
        }
      }
    }

    if (theEvent.isFrom(accidentSurface)) {


      accidentSurfaceArr = accidentSurface.getArrayValue();

      for (int i = 0; i < accidentSurfaceArr.length; i++) {
        println("accidentSurfaceArr[" + i + "] = " + accidentSurfaceArr[i]);
        if (accidentSurfaceArr[i] == 1) {
          println(accidentSurface.getItem(i).getLabel());
          if (!currentSurfaceConds.contains(accidentSurface.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentSurfaceConds.add(accidentSurface.getItem(i).getLabel());
          }
        }
        else {
          println(accidentSurface.getItem(i).getLabel());
          if (currentSurfaceConds.contains(accidentSurface.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentSurfaceConds.remove(accidentSurface.getItem(i).getLabel());
          }
        }
      }
    }

    if (theEvent.isFrom(intoxicants)) {
      intoxicantsArr = intoxicants.getArrayValue();

      for (int i = 0; i < intoxicantsArr.length; i++) {
        println("intoxicantsArr[" + i + "] = " + intoxicantsArr[i]);
        if (intoxicantsArr[i] == 1) {
          println(intoxicants.getItem(i).getLabel());
          if (!currentIntoxicants.contains(intoxicants.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentIntoxicants.add(intoxicants.getItem(i).getLabel());
          }
        } 
        else {
          println(intoxicants.getItem(i).getLabel());
          if (currentIntoxicants.contains(intoxicants.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentIntoxicants.remove(intoxicants.getItem(i).getLabel());
          }
        }
      }
    }
  }
}

void resetSubFilterGroups() {

  cp5.getGroup("g1Second1")
    .setVisible(false);

  cp5.getGroup("g1Second2")
    .setVisible(false);

  cp5.getGroup("g5Second1")
    .setVisible(false);

  cp5.getGroup("g5Second2")
    .setVisible(false);

  cp5.getGroup("g5Second3")
    .setVisible(false);
}


void resetFilterGroups() {

  cp5.getGroup("g1")
    .setVisible(false);

  cp5.getGroup("g2")
    .setVisible(false);

  cp5.getGroup("g3")
    .setVisible(false);

  cp5.getGroup("g4")
    .setVisible(false);

  cp5.getGroup("g5")
    .setVisible(false);

  /* cp5.getGroup("subg51")
   .setVisible(false);
   
   cp5.getGroup("subg52")
   .setVisible(false); */

  cp5.getGroup("g6")
    .setVisible(false);
}


void drawTimeSlider() {

 
noStroke();
  strokeWeight(0);
  if (timeSliderLowMove && mouseX - mouseXOld < timeSliderHighLeft - timeSliderLowRight && timeSliderLowRight + mouseX - mouseXOld >= timeSliderLeft) {
    timeSliderLowLeft += mouseX - mouseXOld;
    timeSliderLowRight += mouseX - mouseXOld;
    mouseXOld = mouseX;
  }
  if (timeSliderHighMove && mouseX - mouseXOld > timeSliderLowRight - timeSliderHighLeft && timeSliderHighLeft + mouseX - mouseXOld <= timeSliderRight) {
    timeSliderHighLeft += mouseX - mouseXOld;
    timeSliderHighRight += mouseX - mouseXOld;
    mouseXOld = mouseX;
  }

 // println("Entering drawTimeSider(); timeSliderLeft: " + timeSliderLeft + "Time slider right: " + timeSliderRight +
    //"\nTimeSliderTop: " + timeSliderTop + "  Time slider bottom: " + timeSliderBottom);

  fill(40);
  rectMode(CORNERS);
  rect(timeSliderLeft, timeSliderTop, timeSliderRight, timeSliderBottom);
  fill(50);
  rect(timeSliderLowLeft, timeSliderButtonTop, timeSliderLowRight, timeSliderButtonBottom);
  rect(timeSliderHighLeft, timeSliderButtonTop, timeSliderHighRight, timeSliderButtonBottom);
  fill(#FA8A11);
  rect(timeSliderLowRight, timeSliderButtonTop + 15*scaleFactor, timeSliderHighLeft, timeSliderButtonBottom-15*scaleFactor);

  fill(0);
  rect(timeSliderLowLeft - 30*scaleFactor, timeSliderButtonTop - 25*scaleFactor, timeSliderLowRight, timeSliderButtonTop - 5*scaleFactor);
  rect(timeSliderHighLeft, timeSliderButtonTop - 25*scaleFactor, timeSliderHighRight + 30*scaleFactor, timeSliderButtonTop - 5*scaleFactor);
  fill(240);
  textAlign(CENTER);
  textSize(12*scaleFactor);
  
  //TODO make it work for all date ranges (day, month, year)
  if(timeScale == 1){
    int tempDateMin = Math.round((timeSliderLowRight - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(2010-2001)+2001);
    int tempDateMax = Math.round((timeSliderHighLeft - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(2010-2001)+2001);
    text(tempDateMin, timeSliderLowRight - 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    text(tempDateMax, timeSliderHighLeft + 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    if(tempDateMin != dateMin || tempDateMax != dateMax){
      dateMin = tempDateMin;
      dateMax = tempDateMax;
      updateDataNewRange();
    }
  } else if(timeScale == 2){
    int tempDateMin = Math.round((timeSliderLowRight - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(12-1)+1);
    int tempDateMax = Math.round((timeSliderHighLeft - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(12-1)+1);
    text(tempDateMin, timeSliderLowRight - 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    text(tempDateMax, timeSliderHighLeft + 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    if(tempDateMin != dateMin || tempDateMax != dateMax){
      dateMin = tempDateMin;
      dateMax = tempDateMax;
      updateDataNewRange();
    }   
  } else if(timeScale == 3) {
    int tempDateMin = Math.round((timeSliderLowRight - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(31-1)+1);
    int tempDateMax = Math.round((timeSliderHighLeft - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(31-1)+1);
    text(tempDateMin, timeSliderLowRight - 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    text(tempDateMax, timeSliderHighLeft + 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    if(tempDateMin != dateMin || tempDateMax != dateMax){
      dateMin = tempDateMin;
      dateMax = tempDateMax;
      updateDataNewRange();
    }
  } else if(timeScale == 4) {
    int tempDateMin = Math.round((timeSliderLowRight - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(24-1)+1);
    int tempDateMax = Math.round((timeSliderHighLeft - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*(24-1)+1);
    text(tempDateMin, timeSliderLowRight - 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    text(tempDateMax, timeSliderHighLeft + 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
    if(tempDateMin != dateMin || tempDateMax != dateMax){
      dateMin = tempDateMin;
      dateMax = tempDateMax;
      updateDataNewRange();
    }
  }
  
}


int returnNumberOfActiveFilters() {  //Method to determine whether a main filter has been chosen or not

  int filterCount = 0;

  for (float g: driverAgeArr) {
    if (g == 1)
      filterCount++;
  }

  for (float g: driverGenderArr) {
    if (g == 1)
      filterCount++;
  }
  for (float g: vehiclesRoadArr) {
    if (g == 1)
      filterCount++;
  }
  for (float g: vehiclesNonRoadArr) {
    if (g == 1)
      filterCount++;
  }
  for (float g: weatherArr) {
    if (g == 1)
      filterCount++;
  }
  for (float g: accidentAutomobileArr) {
    if (g == 1)
      filterCount++;
  }
  for (float g: accidentSurfaceArr) {
    if (g == 1)
      filterCount++;
  }
  for (float g: intoxicantsArr) {
    if (g == 1)
      filterCount++;
  }



  println("no. of active filters: " + filterCount);

  return filterCount;
}




void scanForEnabledValue() {

  println("Beginning of scanForEnabledValue: ");
  println("potentialMainFilter: " + potentialMainFilter);
  println("mainFilterChosen: " + mainFilterChosen + "\n");
  resetChosenMainFilterArr();
  int indicator = -1;

  for (float g: driverAgeArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[0] = true;
      indicator = 0;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }

  for (float g: driverGenderArr) {
    if (g ==1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[1] = true;
      indicator = 1;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
  for (float g: vehiclesRoadArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[2] = true;
      indicator = 2;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
  for (float g: vehiclesNonRoadArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[3] = true;
      indicator = 3;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
  for (float g: weatherArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[4] = true;
      indicator = 4;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
  for (float g: accidentAutomobileArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[5] = true;
      indicator = 5;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
  for (float g: accidentSurfaceArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[6] = true;
      indicator = 6;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
  for (float g: intoxicantsArr) {
    if (g == 1.0) {
      mainFilterChosen = true;
      potentialMainFilter = false;
      chosenMainFilterArr[7] = true;
      indicator = 7;

      println("potentialMainFilter: " + potentialMainFilter);
      println("mainFilterChosen: " + mainFilterChosen + "\n");
      if (mainFilterChosen) 
        for (int i = 0; i < 8; i++)
          println("Chosen Main filter array [" + i + "] is: " + chosenMainFilterArr[i]);

      return;
    }
  }
}

void determineMainFilterOrSub() {
  checkForPotentialMainStatus();

  if (potentialMainFilter) {
    scanForEnabledValue();
  }
}

void checkForPotentialMainStatus() {
  if (returnNumberOfActiveFilters() == 0) {
    potentialMainFilter = true;
    mainFilterChosen = false;
  }
}

void resetChosenMainFilterArr() {
  chosenMainFilterArr = new boolean[8];
}

