void drawTimeFilterControllers() {

  Group g4 = cp5.addGroup("g4")//Time Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 115), firstFilterTabPlotY+ scaleFactor * 20)
      .setBackgroundHeight(215)
        .setWidth(110)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  cp5.addBang("Year Range")
    .setSize(90, 30)
      .setPosition(10, 20)
        .setGroup(g4)
          .setId(1)
            .getCaptionLabel().align(CENTER, CENTER)
              ;


  cp5.addBang("Months of a Year")
    .setSize(90, 30)
      .setPosition(10, 70)
        .setGroup(g4)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER)
              ;

  cp5.addBang("Weekday Averages")
    .setSize(90, 30)
      .setPosition(10, 120)
        .setGroup(g4)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER)
              ;

  cp5.addBang("Time of Day Averages")
    .setSize(90, 30)
      .setPosition(10, 170)
        .setGroup(g4)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER)
              ;
}

