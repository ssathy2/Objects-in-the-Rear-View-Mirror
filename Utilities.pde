class Point {
  double latitude;
  double longitude; 
  
  public Point (String lat, String lon) {
    latitude = Double.valueOf(lat);
    longitude = Double.valueOf(lon); 
  }
}

class Crash {
  int crashId;
  CDate crashDate;
  Point coordinates;
    
  
}

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
