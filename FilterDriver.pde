
void drawDriverFilterControllers() {

  Group g1 = cp5.addGroup("g1")//Driver Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 85), firstFilterTabPlotY)
      .setBackgroundHeight(120)
        .setWidth(80)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  cp5.addBang("Age")
    .setSize(60, 30)
      .setPosition(10, 20)
        .setGroup(g1)
          .setId(1)
            .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font)
              ;


  cp5.addBang("Gender")
    .setSize(60, 30)
      .setPosition(10, 70)
        .setGroup(g1)
          .setId(2)
            .getCaptionLabel().align(CENTER, CENTER).setFont(cp5Font)
              ;





  Group g1Second1 = cp5.addGroup("g1Second1")
    .setPosition(firstFilterTabPlotX - (scaleFactor * 180), firstFilterTabPlotY)
      .setBackgroundHeight(235)
        .setWidth(80)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  driverAge = cp5.addCheckBox("driverAge")
    .setPosition(10, 10)
      .setSize(30, 30)
        .setSpacingColumn(90)
          //.setItemsPerRow(2)
          .setColorForeground(#FFFFFF)
            .setColorActive(0xffff0000)
              .setColorBackground(#F2F2F2)
                .setColorLabel(20)
                  .addItem("16 - 25", 0)
                    .addItem("26 - 35", 1)
                      .addItem("36 - 45", 2)
                        .addItem("46 - 55", 3)
                          .addItem("56 - 65", 4)                   
                            .addItem("66 - 75", 5)
                              .addItem("75+", 6)
                                .setGroup(g1Second1)
                                  ;

  Group g1Second2 = cp5.addGroup("g1Second2")
    .setPosition(firstFilterTabPlotX - (scaleFactor * 180), firstFilterTabPlotY + (scaleFactor * 40))
      .setBackgroundHeight(80)
        .setWidth(80)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  driverGender = cp5.addCheckBox("driverGender")
    .setPosition(10, 10)
      .setSize(30, 30)
        .setSpacingColumn(90)
          //.setItemsPerRow(2)
          .setColorForeground(#FFFFFF)
            .setColorActive(0xffff0000)
              .setColorBackground(#F2F2F2)
                .setColorLabel(20)
                  .addItem("Male", 0)
                    .addItem("Female", 1)
                      .setGroup(g1Second2)
                        ;


}

