RadioButton monthSelectedRBtn;
RadioButton weekdaySelectedRBtn;
RadioButton timeOfDaySelectedRBtn;

void drawTimeFilterControllers() {

  Group g4 = cp5.addGroup("g4")//Time Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 115), firstFilterTabPlotY+ scaleFactor * 20)
      .setBackgroundHeight(scaleFactor *215)
        .setWidth(scaleFactor *110)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  cp5.addBang("Year Range")
    .setSize(scaleFactor *90, scaleFactor * 30)
      .setPosition(scaleFactor *10, scaleFactor * 20)
        .setGroup(g4)
          .setId(1)
            .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font)
              ;


  cp5.addBang("Month of a Year")
    .setSize(scaleFactor *90, scaleFactor * 30)
      .setPosition(scaleFactor *10, scaleFactor * 70)
        .setGroup(g4)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font)
              ;

  cp5.addBang("Weekday of a Month")
    .setSize(scaleFactor *90, scaleFactor *30)
      .setPosition(scaleFactor *10, scaleFactor * 120)
        .setGroup(g4)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font)
              ;

  cp5.addBang("Time of a Weekday")
    .setSize(scaleFactor *90, scaleFactor * 30)
      .setPosition(scaleFactor *10, scaleFactor * 170)
        .setGroup(g4)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font)
              ;


  cp5.addGroup("g4Second1")//Time Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 320), firstFilterTabPlotY+ scaleFactor * 20)
      .setBackgroundHeight(scaleFactor *155)
        .setWidth(scaleFactor *200)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  monthSelectedRBtn = cp5.addRadioButton("selectAYear")
    .setPosition(scaleFactor *10, scaleFactor* 5)
      .setSize(scaleFactor *28, scaleFactor * 28)
        .setSpacingColumn(scaleFactor *90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("2001", 0)
                      .addItem("2002", 1)
                        .addItem("2003", 2)
                          .addItem("2004", 3)
                            .addItem("2005", 4)                   
                              .addItem("2006", 5)
                                .addItem("2007", 6)
                                  .addItem("2008", 7)
                                    .addItem("2009", 8)
                                      .addItem("2010", 9)
                                        .setGroup("g4Second1")
                                          ;

  cp5.addGroup("g4Second2")//Time Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 330), firstFilterTabPlotY+ scaleFactor * 20)
      .setBackgroundHeight(scaleFactor *185)
        .setWidth(scaleFactor *210)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  weekdaySelectedRBtn = cp5.addRadioButton("selectAMonth")
    .setPosition(scaleFactor *10, scaleFactor* 5)
      .setSize(scaleFactor *28, scaleFactor * 28)
        .setSpacingColumn(scaleFactor *90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("January", 0)
                      .addItem("February", 1)
                        .addItem("March", 2)
                          .addItem("April", 3)
                            .addItem("May", 4)                   
                              .addItem("June", 5)
                                .addItem("July", 6)
                                  .addItem("August", 7)
                                    .addItem("September", 8)
                                      .addItem("October", 9)
                                        .addItem("November", 10)
                                          .addItem("December", 11)
                                            .setGroup("g4Second2")
                                              ;

  cp5.addGroup("g4Second3")//Time Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 330), firstFilterTabPlotY+ scaleFactor * 60)
      .setBackgroundHeight(scaleFactor *125)
        .setWidth(scaleFactor *210)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  timeOfDaySelectedRBtn = cp5.addRadioButton("selectAWeekDay")
    .setPosition(scaleFactor *10, scaleFactor* 5)
      .setSize(scaleFactor *28, scaleFactor * 28)
        .setSpacingColumn(scaleFactor *90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("Monday", 0)
                      .addItem("Tuesday", 1)
                        .addItem("Wednesday", 2)
                          .addItem("Thursday", 3)
                            .addItem("Friday", 4)                   
                              .addItem("Saturday", 5)
                                .addItem("Sunday", 6)
                                  .setGroup("g4Second3")
                                    ;
}

