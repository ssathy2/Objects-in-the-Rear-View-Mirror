/* Class file for the filter menu buttons, linegraph button, map graph button, help button, national comparison button, and any other
part of the general ui */
float timeSliderLeft, timeSliderRight, timeSliderTop, timeSliderBottom, timeSliderLowLeft, timeSliderButtonTop, timeSliderButtonBottom, timeSliderLowRight, timeSliderHighLeft, timeSliderHighRight, mouseXOld;

boolean timeSliderLowMove = false;
boolean timeSliderHighMove = false;

//Method to draw 6 filter category tabs to the right of the graph... these are actually cp5 buttons, not tabs

boolean mapIsShown;

/*PImage[] imgs = {
 loadImage("contact.png"), loadImage("wheel.png"), loadImage("weather.png"), loadImage("clock.png"), loadImage("emergency.png"), loadImage("drugs.png")
 }; */

float firstFilterTabPlotX, firstFilterTabPlotY;
float graphSwitchTopPlotY, graphSwitchTopPlotX;

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

  drawFilterTabs();

  drawDriverFilterControllers();
  drawVehicleFilterControllers();
  drawWeatherFilterControllers();
  drawTimeFilterControllers();
  drawAccidentFilterControllers();
  drawIntoxicantFilterControllers();

  drawGraphSwitchButtons();
}

void drawFilterTabs() {

  cp5.setColorForeground(#FFFFFF);
  cp5.setColorBackground(#F2F2F2);
  cp5.setColorLabel(20);
  cp5.setColorValue(#072E05);
  cp5.setColorActive(0xffff0000);

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
        break;
        case(2):
        mapIsShown = false;
        break;
      }
    }


    if (theEvent.getController().getParent().getName() == "filterGroup") {    //Control events for filter menu buttons
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




    if (cp5.getGroup("g1").isVisible() && theEvent.getController().getParent().getName() == "g1") {      //If Driver variables menu is open and the event's controller belongs to the right group


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
      if(theEvent.getLabel().equals("Year Range")) {timeScale = 1; shouldGetNewData = true;}
      else if(theEvent.getLabel().equals("Months of a Year")) {timeScale = 2; shouldGetNewData = true;}
      else if(theEvent.getLabel().equals("Weekday Averages")) {timeScale = 3; shouldGetNewData = true;}
      else if(theEvent.getLabel().equals("Time of Day Averages")) {timeScale = 4; shouldGetNewData = true;}
    }
  }

  if (theEvent.isGroup())
  {

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
        if(driverGenderArr[i] == 1) {
          if(i == 0) showMale = true;
          else if(i == 1) showFemale = true;  
        }
      }
    }

    if (theEvent.isFrom(vehiclesRoad)) {

      vehiclesRoadArr = vehiclesRoad.getArrayValue();
      for (int i = 0; i < vehiclesRoadArr.length; i++) {
        println("vehiclesRoadArr[" + i + "] = " + vehiclesRoadArr[i]);
        if(vehiclesRoadArr[i] == 1) {
          println(vehiclesRoad.getItem(i).getLabel());
          if(!currentBodyTypes.contains(vehiclesRoad.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentBodyTypes.add(vehiclesRoad.getItem(i).getLabel());
          }
        }
        else {
          println(vehiclesRoad.getItem(i).getLabel());
          if(currentBodyTypes.contains(vehiclesRoad.getItem(i).getLabel())) {
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
        if(vehiclesNonRoadArr[i] == 1) {
          println(vehiclesNonRoad.getItem(i).getLabel());
          if(!currentBodyTypes.contains(vehiclesNonRoad.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentBodyTypes.add(vehiclesNonRoad.getItem(i).getLabel());
          } 
        }
        else {
          println(vehiclesNonRoad.getItem(i).getLabel());
          if(currentBodyTypes.contains(vehiclesNonRoad.getItem(i).getLabel())) {
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
        if(weatherArr[i] == 1) {
          println(weather.getItem(i).getLabel());
          if(!currentWeatherConds.contains(weather.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentWeatherConds.add(weather.getItem(i).getLabel());
          }
        } 
        else {
          println(weather.getItem(i).getLabel());
          if(currentWeatherConds.contains(weather.getItem(i).getLabel())) {
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
        if(accidentAutomobileArr[i] == 1) {
          println(accidentAutomobile.getItem(i).getLabel());
          if(!currentARF.contains(accidentAutomobile.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentARF.add(accidentAutomobile.getItem(i).getLabel());
          }
        }
        else {
          println(accidentAutomobile.getItem(i).getLabel());
          if(currentARF.contains(accidentAutomobile.getItem(i).getLabel())) {
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
        if(accidentSurfaceArr[i] == 1) {
          println(accidentSurface.getItem(i).getLabel());
          if(!currentSurfaceConds.contains(accidentSurface.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentSurfaceConds.add(accidentSurface.getItem(i).getLabel());
          }
        }
        else {
          println(accidentSurface.getItem(i).getLabel());
          if(currentSurfaceConds.contains(accidentSurface.getItem(i).getLabel())) {
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
        if(intoxicantsArr[i] == 1) {
          println(intoxicants.getItem(i).getLabel());
          if(!currentIntoxicants.contains(intoxicants.getItem(i).getLabel())) {
            shouldGetNewData = true;
            currentIntoxicants.add(intoxicants.getItem(i).getLabel());  
          }
        } 
        else {
          println(intoxicants.getItem(i).getLabel());
          if(currentIntoxicants.contains(intoxicants.getItem(i).getLabel())) {
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


void drawTimeSlider(){
  strokeWeight(0);
  if(timeSliderLowMove && mouseX - mouseXOld < timeSliderHighLeft - timeSliderLowRight && timeSliderLowRight + mouseX - mouseXOld >= timeSliderLeft){
    timeSliderLowLeft += mouseX - mouseXOld;
    timeSliderLowRight += mouseX - mouseXOld;
    mouseXOld = mouseX;
  }
  if(timeSliderHighMove && mouseX - mouseXOld > timeSliderLowRight - timeSliderHighLeft && timeSliderHighLeft + mouseX - mouseXOld <= timeSliderRight){
    timeSliderHighLeft += mouseX - mouseXOld;
    timeSliderHighRight += mouseX - mouseXOld;
    mouseXOld = mouseX;
  }
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
  text(Math.round((timeSliderLowRight - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*100) + "%", timeSliderLowRight - 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
  text(Math.round((timeSliderHighLeft - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*100) + "%", timeSliderHighLeft + 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
}
