boolean helpMenuChosen;


Textlabel timeLineText;
Textlabel yAxisText;
Textlabel xAxisText;

Textlabel filterText;
Textlabel switchText;
Textlabel creditsText;

void drawHelpMenu() {

  Group helpBox = cp5.addGroup("helpBox")
    .setPosition(0, 0)
      .setBackgroundHeight(height)
        .setWidth(width)
          .hideBar()
            .setBackgroundColor(color(255, 99.9999))
              // .activateEvent(false)
              .setVisible(false)
                ;

  cp5.addBang("backButton")
    .setPosition(helpX, helpY)
      .setSize(scaleFactor * 50, scaleFactor * 40)
        .setCaptionLabel("Back")
          .setTriggerEvent(Bang.PRESSED)
            .setColorActive(#F59188)
              .setColorForeground(#ED3322) 
                .setColorLabel(20)
                  .setGroup("helpBox")
                    .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font);



  timeLineText = cp5.addTextlabel("timeLineText")
    .setText("This is an interactive timeline that a user may manipulate to zoom in on data.")
      .setPosition((gPlotX2 - gPlotX1) /2 + gPlotX1 - scaleFactor * 200, gPlotY2 + scaleFactor * 30)
        .setFont(pFont)
          .setColorValue(#000000)
            .setGroup("helpBox");
  ;

  timeLineText = cp5.addTextlabel("yAxisText")
    .setText("< - This is the Y axis. It's measurement is always in No. of accidents.\n     The Y axis scales with the data as it is updated.")
      .setPosition(gPlotX1, gPlotY1 + scaleFactor * 20)
        .setFont(pFont)
          .setColorValue(#000000)
            .setGroup("helpBox");
  ;
  
  xAxisText = cp5.addTextlabel("xAxisText")
    .setText("This is the X axis. It's measurements\ncould change from Year, to month,\n to weekday, to time of day,\ndepending on the filters chosen. Labels\nalong the x-axis scale with the time slider.")
      .setPosition(gPlotX1 + scaleFactor * 20, gPlotY2 - scaleFactor * 110)
        .setFont(pFont)
          .setColorValue(#000000)
            .setGroup("helpBox");
            
  filterText = cp5.addTextlabel("filterText")
     .setText("The user may change different filter\nvalues within the menus to the right.")
      .setPosition(firstFilterTabPlotX - scaleFactor * 320, gPlotY1 +scaleFactor * 20)
        .setFont(pFont)
          .setColorValue(#000000)
            .setGroup("helpBox");
            
      creditsText = cp5.addTextlabel("credits")
     .setText("Credits:\nThe University of Illinois at Chicago\nSiddarth Sathyam - Data Base Mining, Website Construction, and Code Implementation\nGalen Thomas-Ramos - UI Layout, Coding, and pre-planning\nPavle Jovanovic - Map Graphs; both Heat Graph, and Plot Graph\nLibraries Used: ProcessingSQL, OMicron, ControlP5, Modest Maps")
      .setPosition( gPlotX1 +scaleFactor * 400, gPlotY1 + scaleFactor * 100)
        .setFont(creditsFont)
          .setColorValue(#740D0D)
            .setGroup("helpBox");  
  
            
}


/*  DOESNT FUCKING WORK. COOL.
 
 
 float textPlacementPadX, textPlacementPadY;
 
 float overviewButtonPlotX1, overviewButtonPlotY1, overviewButtonPlotX2, overviewButtonPlotY2;
 float overviewMenuPlotX1, overviewMenuPlotX2, overviewMenuPlotY1, overviewMenuPlotY2;
 float overviewExitButtonPlotX1, overviewExitButtonPlotY1, overviewExitButtonPlotX2, overviewExitButtonPlotY2;
 
 void drawHelpMenu() {
 
 println("Entering drawHelpMenu()");
 
 //cp5.getGroup(g2).setVisible(true);
 
 
 
 
 strokeWeight(int(scaleFactor * 10));//overview menu 
 stroke(255, 80, 79);
 fill(0, 60);
 rectMode(CORNERS);
 rect(overviewMenuPlotX1, overviewMenuPlotY1, overviewMenuPlotX2, overviewMenuPlotY2, (scaleFactor * 6));
 
 strokeWeight(int(scaleFactor * 5));// overview menu "back to menus button"
 stroke(255, 80, 79);
 fill(0, 95);
 rectMode(CORNERS);
 rect(overviewExitButtonPlotX1, overviewExitButtonPlotY1, overviewExitButtonPlotX2, overviewExitButtonPlotY2, (scaleFactor * 3));
 
 fill(235);
 textSize(scaleFactor * 18);
 textAlign(LEFT, BOTTOM);
 
 text("Credits:\nSiddarth Sathyam - Data Base Mining, Website Construction, and Code Implementation\nGalen Thomas-Ramos - UI Layout, Coding, and pre-planning\nPavle Jovanovic - Map Graphs; both Heat Graph, and Plot Graph", scaleFactor * 40, height - (scaleFactor * 40));
 
 fill(235);
 textSize(scaleFactor * 20);
 textAlign(LEFT, TOP);
 text("Back to Menus", overviewExitButtonPlotX1 + textPlacementPadX, overviewExitButtonPlotY1 + textPlacementPadY + (scaleFactor * 3));
 
 
 fill(235);
 textSize(scaleFactor * 16);
 textAlign(LEFT, BOTTOM);
 
 text("The Y axis.\nThe unit of measure is always\nthe number of accidents.", gPlotX1 + scaleFactor * 20, ((gPlotY2 - gPlotY1) / 2) + gPlotY1 - scaleFactor * 10);
 arrowLine(gPlotX1 + (scaleFactor * 10), ((gPlotY2 - gPlotY1) / 2) + gPlotY1, gPlotX1 + scaleFactor * 130, ((gPlotY2 - gPlotY1) / 2) + gPlotY1, radians(30), 0, true);  //Arrow to y Axis
 
 text("The X axis.\nThe unit of measure is either in\nyears, months, days of a month,\nor hours of a day.", ((gPlotY2 - gPlotY1) / 2) + gPlotY1 - scaleFactor * 40, gPlotY2 - (scaleFactor * 60));
 arrowLine(((gPlotY2 - gPlotY1) / 2) + gPlotY1 - scaleFactor * 40, gPlotY2 - (scaleFactor * 10), ((gPlotY2 - gPlotY1) / 2) + gPlotY1, gPlotY2 - (scaleFactor * 50), radians(30), 0, true);  //Arrow to X Axis
 
 //arrowLine(overviewButtonPlotX1 - (scaleFactor * 10), overviewButtonPlotY1 + scaleFactor * 10, overviewButtonPlotX1 - (scaleFactor * 100), overviewButtonPlotY1 + scaleFactor * 10, radians(30), 0, true); //overview
 
 fill(235);
 textSize(scaleFactor * 16);
 textAlign(RIGHT, BOTTOM);
 
 text("Filter categories to choose from.", firstFilterTabPlotX - scaleFactor * 90, firstFilterTabPlotY + scaleFactor * 40);
 
 float vertCount = firstFilterTabPlotY + scaleFactor * 15;
 for (int i = 0; i < 6; i++) {
 arrowLine(firstFilterTabPlotX - scaleFactor * 10, vertCount, firstFilterTabPlotX - scaleFactor * 80, (gPlotY2 - gPlotY1)/ 2 + gPlotY1, radians(30), 0, true);// arrows to filter buttons
 vertCount += scaleFactor * 30;
 }
 
 
 
 
 text("Clear button will appear here\n It resets the current graph", clearButtonX - scaleFactor * 60, clearButtonY - scaleFactor * 60);
 arrowLine(clearButtonX, clearButtonY - scaleFactor * 10, clearButtonX - scaleFactor * 50, clearButtonY - scaleFactor * 50, radians(30), 0, true);  //Arrow to Reset button
 
 stroke(255, 34, 90);
 
 text("Switch between map graph and line graph.", graphSwitchTopPlotX - scaleFactor * 140, graphSwitchTopPlotY - scaleFactor * 40);
 arrowLine( graphSwitchTopPlotX - scaleFactor * 10,  graphSwitchTopPlotY, graphSwitchTopPlotX - scaleFactor * 130,  graphSwitchTopPlotY - scaleFactor * 30, radians(30), 0, true); 
 arrowLine( graphSwitchTopPlotX - scaleFactor * 10,  graphSwitchTopPlotY + scaleFactor * 100,  graphSwitchTopPlotX - scaleFactor * 130, graphSwitchTopPlotY - scaleFactor * 30, radians(30), 0, true); // arrow to end of year range slidder
 
 fill(235);
 textSize(scaleFactor * 16);
 textAlign(LEFT, BOTTOM);
 
 text("Time Slider, user can zoom in on a specific X-axis range\nby dragging the side buttons left and right.", (gPlotX2 - gPlotX1)/ 2 + gPlotX1 + scaleFactor * 400, gPlotY2 - (scaleFactor * 60));
 arrowLine((gPlotX2 - gPlotX1)/ 2 + gPlotX1, timeSliderTop - (scaleFactor * 10), (gPlotX2 - gPlotX1)/ 2 + gPlotX1 + scaleFactor * 400, gPlotY2 - (scaleFactor * 50), radians(30), 0, true); // arrow to end of year range slidder
 
 //arrowLine(textEntryButtonPlotX1, resetButtonPlotY1 - scaleFactor * 10, textEntryButtonPlotX1 - scaleFactor * 60, resetButtonPlotY1 - scaleFactor * 90, radians(30), 0, true); //arrow to text entry
 }
 
 */
