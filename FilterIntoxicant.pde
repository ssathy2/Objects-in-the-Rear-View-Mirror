void drawIntoxicantFilterControllers() {
  
  Group g6 = cp5.addGroup("g6")//Intoxicant/altered state Variables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 235), firstFilterTabPlotY + (scaleFactor * 85))
      .setBackgroundHeight(scaleFactor *145)
        .setWidth(scaleFactor *230)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ; 

 intoxicants = cp5.addCheckBox("intoxicants")
    .setPosition(scaleFactor *10,scaleFactor * 10)
      .setSize(scaleFactor *30, scaleFactor *30)
        .setSpacingColumn(scaleFactor *90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("No Drugs\n/Not Tested", 0)
                      .addItem("Alcohol", 1)
                        .addItem("Opiates", 2)
                          .addItem("Marijuana", 3)
                            .addItem("Painkillers", 4)               
                              .addItem("Psychadelics", 5)
                                .addItem("Amphetamines", 6)
                                  .addItem("Sleepy", 7)
                                      .setGroup(g6)
                                        ;
}

