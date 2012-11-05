

void drawWeatherFilterControllers() {



  Group g3 = cp5.addGroup("g3")//Weather Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 235), firstFilterTabPlotY + (scaleFactor * 35))
      .setBackgroundHeight(195)
        .setWidth(230)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

 weather = cp5.addCheckBox("weather")
    .setPosition(10, 20)
      .setSize(30, 30)
        .setSpacingColumn(90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("Good Conditions", 0)
                      .addItem("Rain", 1)
                        .addItem("Sleet", 2)
                          .addItem("Snow", 3)
                            .addItem("Fog", 4)                   
                              .addItem("Rain with Fog", 5)
                                .addItem("Sleet with Fog", 6)
                                  .addItem("Other", 7)
                                    .addItem("Unknown", 8)
                                      .setGroup(g3)
                                        ;
}

