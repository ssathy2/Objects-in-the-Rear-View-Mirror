/**
  Helper class to store a lat and longitude for a geo point
**/
class Point {
  double latitude;
  double longitude; 
  
  public Point (String lat, String lon) {
    if(!lat.equals(".") && !lon.equals(".")){
      latitude = Double.valueOf(lat);
      longitude = Double.valueOf(lon); 
    }
    else {
      latitude = -1;
      longitude = -1;  
    }
  }
}

/**
  Helper class to store all the info associated with a particular crash
**/

class Crash {
  int cArf;
  int cDrugs;
  int cId;
  int cBody;
  int cWeather;
  int cAge;
  boolean isMale;
  
  String cState;
  boolean isAlcoholInvolved;
  CDate crashDate;
  Point coordinates;
  
  public Crash(int id, int arf, int drugs, int body, int weather, int age, boolean isM, String state, boolean alc, CDate date, Point coords ){
    cId = id;
    cArf = arf;
    cDrugs = drugs;
    cBody = body;
    cWeather = weather;
    cAge = age;
    isMale = isM;
    isAlcoholInvolved = alc;
    cState = state;
    crashDate = date;
    coordinates = coords;
  }
  
}

/**
  Helper class to store a month, hour, day, and hour
  Used to ID when a crash happened
**/

class CDate {
 int cMonth;
 int cHour;
 int cDay;
 int cYear;
  
 public CDate(int m, int d, int yr, int hr) {
   cMonth = m;
   cDay = d;
   cYear = yr; 
   cHour = hr;
 } 
}
