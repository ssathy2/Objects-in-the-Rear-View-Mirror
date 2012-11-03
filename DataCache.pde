class DataCache {
  
  private HashMap<Integer, Crash> crashID;  
  
  public DataCache(){
    crashID = new HashMap<Integer, Crash>();  
  }
  
  public Crash getCrashWithId(int id) {
    return crashID.get(id); 
  }
  
  // Method that returns a crash corresponding to the params...
  // Returns the crash associated with the vals if it exists and null if the crash doesnt exist
  public Crash isInCache(int arf, int drugs, int body, int weather, int age, boolean isM, String state, boolean alc, String lat, String lon, int mon, int d, int yr, int hr) {
    for(Crash c: crashID.values()) {
      // Stand back and admire the 9th wonder of the world...the rediculously long if statement
      if(arf == c.cArf && 
         drugs == c.cDrugs && 
         body == c.cBody && 
         age == c.cAge && 
         isM == c.isMale && 
         state.equals(c.cState) && 
         alc == c.isAlcoholInvolved &&
         ((Double.valueOf(lat) == (c.coordinates.latitude)) || lat.equals("-1")) &&
         ((Double.valueOf(lon) == (c.coordinates.longitude)) || lon.equals("-1")) &&
         ((mon == (c.crashDate.cMonth)) || mon == -1) &&
         ((d == (c.crashDate.cDay)) || d == -1) &&
         yr == (c.crashDate.cYear) &&
         ((hr == (c.crashDate.cHour)) || hr == -1)) {
           return c;
      }
    }
    return null;
  }
  
  public void addToCache(int id, Crash c) {
    if(!crashID.containsKey(id)) {
      crashID.put(id, c);
    }  
  }
}
