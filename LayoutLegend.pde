final int MAXNUMBEROFMAINFILTERS = 5;
final int MAXNUMBEROFSUBFILTERS = 10;

float mLegendPlotX1, mLegendPlotX2, mLegendPlotY1, mLegendPlotY2;
float sLegendPlotX1, sLegendPlotX2, sLegendPlotY1, sLegendPlotY2;

Group gMainLegend;
Group gSubLegend;

color[] mainFilterColorsArr;

void drawMainFilterLegend() {  //Called in draw()

  mLegendPlotX1 = gPlotX1;
  mLegendPlotX2 = mLegendPlotX1 + (scaleFactor * 200);
  mLegendPlotY2 = gPlotY1 - scaleFactor * 10;
  mLegendPlotY1 = mLegendPlotY2 - (scaleFactor * 50);

  rectMode(CORNERS);
  strokeWeight(4);
  stroke(0);
  fill(180);
  rect(mLegendPlotX1, mLegendPlotY1, mLegendPlotX2, mLegendPlotY2, scaleFactor * 4);
}



void generateMainFilterColors(){  //Called in setup()
  mainFilterColorsArr = new color[5];
 float lerpTemp = 0.0;
 color red = #F22A2A;
 color blue = #383FE8;
  
   for(int i = 0; i < mainFilterColorsArr.length; i++){    //Populate Color array for main filter value coloring
   
     mainFilterColorsArr[i] = lerpColor(red, blue, lerpTemp);
     println("mainFilterColorsArr: " + mainFilterColorsArr[i]);
    lerpTemp+= 0.25;
   }
}



void drawSubFilterLegend() {    //Called in draw()

  sLegendPlotX1 = mLegendPlotX2 + (scaleFactor * 20);
  sLegendPlotX2 = sLegendPlotX1 + (scaleFactor * 400);
  sLegendPlotY1 = mLegendPlotY1;
  sLegendPlotY2 = mLegendPlotY2;

  rectMode(CORNERS);
  strokeWeight(4);
  stroke(0);
  fill(180);
  rect(sLegendPlotX1, sLegendPlotY1, sLegendPlotX2, sLegendPlotY2, scaleFactor * 4);
}



void drawMainFilterLegendText(ArrayList passedArrayList) {  //Ultimately, Called in setup()
/*
  
  float inc = scaleFactor * 10;
  
  Group gMainLegend = cp5.addGroup("gMainLegend")
    .setPosition((int)mLegendPlotX1, (int)mLegendPlotY1)
      .setBackgroundHeight(int(mLegendPlotY2 - mLegendPlotY1))
        .setWidth(int(sLegendPlotX2 - sLegendPlotX1))
          .hideBar()
            .setBackgroundColor(color(240, 90))
              // .activateEvent(false)
              .setVisible(true)
                ;
                
  for(int i = 0; i < passedArrayList.size(); i++){
   
    Integer temp = new Integer(i);
    
    
    if((i + 1) % 2 == 0){
       cp5.addTextLabel(temp.toString())
               .setText(String(passedArrayList[i]))
               .setPosition(10, inc)
               .setColorValue(mainFilterColorsArr[i]).lineBreak()
               .setGroup(gMainLegend)               ;
    }
    else{
   cp5.addTextLabel(temp.toString())
               .setText(String(passedArrayList[i]))
               .setPosition(10, inc)
               .setColorValue(mainFilterColorsArr[i])
               .setGroup(gMainLegend)
               ;
    }
    
    inc += scaleFactor * 14;
  }
  /*
  for(int i = 0; i < mainFilterStrings.length; i++){
    if(mainFilterStrings[i] != null){
      cp5.addTextlabel(mainFilterStrings[i])
                    .setText(mainFilterStrings[i])
                    .setPosition(mLegendPlotY1 + inc ,mLegendPlotX1 + scaleFactor * 10)
                    .setColorValue(mainFilterColorsArr[i])
                    .setFont(createFont("Georgia", 10 * scaleFactor))
                    ;
                    inc+= scaleFactor * 12;
    }  */
  }




void drawSubFilterLegendText() {  //Ultimately, Called in setup
  
  
  
}

