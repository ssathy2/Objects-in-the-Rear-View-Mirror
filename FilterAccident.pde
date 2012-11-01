void drawAccidentFilterControllers() {
  Group g5 = cp5.addGroup("g5")//Driver Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 135), firstFilterTabPlotY + (scaleFactor * 60))
      .setBackgroundHeight(scaleFactor * 170)
        .setWidth(scaleFactor * 130)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ; 


  cp5.addBang("No. of People Involved")
    .setSize(scaleFactor * 110,scaleFactor *  30)
      .setPosition(scaleFactor * 10,scaleFactor *  20)
        .setGroup(g5)
          .setId(1)
            .getCaptionLabel().align(CENTER, CENTER)
              ;


  cp5.addBang("Vehicle Related factors")
    .setSize(scaleFactor * 110, scaleFactor * 30)
      .setPosition(scaleFactor * 10,scaleFactor *  70)
        .setGroup(g5)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER)
              ;

  cp5.addBang("Surface Conditions")
    .setSize(scaleFactor * 110,scaleFactor *  30)
      .setPosition(scaleFactor * 10, scaleFactor *  120)
        .setGroup(g5)
          .setId(3)
            .getCaptionLabel().align(CENTER, CENTER)
              ;


  Group g5Second1 = cp5.addGroup("g5Second1")//Number of People Involved menu
    .setPosition(firstFilterTabPlotX - (scaleFactor * 215), firstFilterTabPlotY + (scaleFactor * 30))
      .setBackgroundHeight(scaleFactor * 200)
        .setWidth(scaleFactor * 70)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false) 
              .setVisible(false)
                ;

  Group g5Second2 = cp5.addGroup("g5Second2")//Automobile related accident Menu
    .setPosition(firstFilterTabPlotX - (scaleFactor * 350), firstFilterTabPlotY + (scaleFactor * 105))
      .setBackgroundHeight(scaleFactor * 125)
        .setWidth(scaleFactor * 210)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  Group g5Second3 = cp5.addGroup("g5Second3")//Road Condition Related Menu
    .setPosition(firstFilterTabPlotX - (scaleFactor * 350), firstFilterTabPlotY + (scaleFactor * 130))
      .setBackgroundHeight(scaleFactor * 100)
        .setWidth(scaleFactor * 210)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)             
              .setVisible(false)
                ;



  //cp5.add

  cp5.addSlider("Number of\nPeople\nInvolved")
    .setPosition(scaleFactor * 20,scaleFactor *  5)
      .setSize(scaleFactor * 20,scaleFactor *  160)
        .setRange(0, 10)
          .setNumberOfTickMarks(10)
            .setGroup(g5Second1)
              ;


  accidentAutomobile = cp5.addCheckBox("accidentAutomobile")
    .setPosition(scaleFactor * 10,scaleFactor *  5)
      .setSize(scaleFactor * 28,scaleFactor *  28)
        .setSpacingColumn(scaleFactor * 90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("Tires", 0)
                      .addItem("Brakes", 1)
                        .addItem("Steering", 2)
                          .addItem("Engine", 3)
                            .addItem("Lights", 4)                   
                              .addItem("Seatbelt", 5)
                                .addItem("Other Factor", 6)
                                  .setGroup(g5Second2)
                                    ;

 accidentSurface = cp5.addCheckBox("accidentSurface")
    .setPosition(scaleFactor * 10,scaleFactor *  5)
      .setSize(scaleFactor * 28,scaleFactor *  28)
        .setSpacingColumn(scaleFactor * 90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("Wet", 0)
                      .addItem("Snowy", 1)
                        .addItem("Icy", 2)
                          .addItem("Dirt", 3)
                            .addItem("Other Condition", 4)                   
                              .setGroup(g5Second3)
                                ;
}

