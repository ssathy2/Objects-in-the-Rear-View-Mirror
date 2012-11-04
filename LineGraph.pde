/* Class file to draw the line graphs themselves */
HashMap<Integer, Integer> plotData;

void drawGraph() {
  getData();
}

void getData() {
  if(shouldGetNewData) {
    switch(timeScale) {
      case 1: plotData = db.getCrashMonthNumbersForYear(currentState, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 2: plotData = db.getCrashDayNumbersForMonthYear(currentState, currentMonth, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
      case 3: plotData = db.getCrashHourNumbersForMonthDayYear(currentState, currentDay, currentMonth, currentYear, currentSurfaceConds, currentWeatherConds, currentBodyTypes, currentARF, currentIntoxicants, showMale, showFemale, startAge, endAge);
              break;
    }   
    shouldGetNewData = false;  
  }  
}
