void drawVehicleFilterControllers() {

  Group g2 = cp5.addGroup("g2")//VehicleVariables
    .setPosition(firstFilterTabPlotX - (scaleFactor * 275), firstFilterTabPlotY + (scaleFactor * 25))
      .setBackgroundHeight(210)
        .setWidth(270)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(false)
                ;

  Group subg21 = cp5.addGroup("subg21")//Automobile related accident Variables
    .setPosition(5, 5)
      .setBackgroundHeight(125)
        .setWidth(260)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setGroup(g2)
                .setVisible(false)
                  ;

  Group subg22 = cp5.addGroup("subg22")//road surface related accidentVariables
    .setPosition(5, 135)
      .setBackgroundHeight(70)
        .setWidth(260)
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setGroup(g2)
                .setVisible(false)
                  ;

 vehiclesRoad = cp5.addCheckBox("vehiclesRoad")
    .setPosition(10, 5)
      .setSize(28, 28)
        .setSpacingColumn(90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("Cars", 0)
                      .addItem("SUVs", 1)
                        .addItem("Minivans", 2)
                          .addItem("Pickup Trucks", 3)
                            .addItem("Semi-Trucks", 4)                   
                              .addItem("Delivery Vans", 5)
                                .addItem("Motorcycles", 6)
                                  .addItem("Buses", 7)
                                    .setGroup(subg21)
                                      ;

  vehiclesNonRoad = cp5.addCheckBox("vehiclesNonRoad")
    .setPosition(10, 5)
      .setSize(28, 28)
        .setSpacingColumn(90)
          .setItemsPerRow(2)
            .setColorForeground(#FFFFFF)
              .setColorActive(0xffff0000)
                .setColorBackground(#F2F2F2)
                  .setColorLabel(20)
                    .addItem("Large n/r Vehicles", 0)
                      .addItem("Mid-Size n/r Vehicles", 1)
                        .addItem("Small n/r Vehicles", 2)
                          .setGroup(subg22)
                            ;
}

