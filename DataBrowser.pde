import de.bezier.data.sql.*;

class DataBrowser {
  private MySQL msql;
  private String user;
  private String pass;
  private String database;
  private String server;
  
  // Hashmaps to convert from num to string
  private HashMap<String, Integer> atm;
  //HashMap<Stri> cf;
  private HashMap<String, ArrayList<Integer>> body;
  private HashMap<String, ArrayList<Integer>> drugs;
  private HashMap<String, ArrayList<Integer>> arf;
  
  public void initConversionMaps() {
    // Atmospheric conditions data
    atm = new HashMap<String, Integer>();
    atm.put("Blank", -1); atm.put("No Adverse Atmospheric Conditions", 1); atm.put("Rain", 2); atm.put("Sleet (Hail)", 3); atm.put("Snow", 4); atm.put("Fog", 5); atm.put("Rain And Fog", 6); atm.put("Sleet And Fog", 7); atm.put("Other(Smog, Smoke, Blowing Sand Or Dust)", 8); atm.put("Unknown", 9);
    //Crash factors
    //cf = new HashMap<Integer, String>();
    //cf.put("Blank", -1); cf.put("None", 0); cf.put("Inadequate Warning Of Exits, Lanes Narrowing, Traffic Controls, Etc.", 1); cf.put("Shoulder Design Or Condition", 2); cf.put("Other Construction-Created Condition", 3); cf.put("No Or Obscured Pavement Marking", 4); cf.put("Surface Under Water", 5); cf.put("Inadequate Construction Or Poor Design Of Roadway,Bridge, Etc.", 6); cf.put(7,"Surface Washed Out(caved-in, Road Slippage)"); cf.put(14,"Motor Vehicle In Transport Struck By Falling Cargo,or Something That Came Loose From Or Something That Was Set In Motion By A Vehicle"); cf.put(15,"Non-occupant Struck By Falling Cargo, Or Something That Came Loose From, Or Something That Was Set In Motion By A Vehicle"); cf.put(16,"Non-occupant Struck Vehicle"); cf.put(17,"Vehicle Set-in-motion By Non-driver"); cf.put(18, "Date Of Accident And Date Of EMS Notification Were Not The Same Day"); cf.put(19,"Recent/Previous Accident Scene Nearby"); cf.put(20, "Police Pursuit Involved"); cf.put(21,"Within Designated School Zone"); cf.put(22,"Speed Limit Is A Statutory Limit As Recorded Or Was Determined As This State's basic rule"); cf.put(99,"Unknown");
    initializeBodyHashMap();
    initializeDrugsHashMap();
    initializeARFHashMap();
    
    ArrayList<String> w = new ArrayList<String>(atm.keySet());
    ArrayList<String> b = new ArrayList<String>(body.keySet());
    ArrayList<String> a = new ArrayList<String>(arf.keySet());
    ArrayList<String> d = new ArrayList<String>(drugs.keySet());
    
    String blah = generateQueryString("illinois", false, -1, -1, 2003, w, b, a, d, true, true, 12, 69);
    println(blah);
    
  }
  
  private void initializeBodyHashMap() {
    body = new HashMap<String, ArrayList<Integer>>();
    
    ArrayList<Integer> pCars = new ArrayList<Integer>();
    pCars.add(1); pCars.add(2); pCars.add(3); pCars.add(4); pCars.add(5); pCars.add(6); pCars.add(7); pCars.add(8);
    body.put("Passenger Cars", pCars);
    
    ArrayList<Integer> pSuv = new ArrayList<Integer>();
    pSuv.add(14); pSuv.add(15); pSuv.add(16); pSuv.add(19);
    body.put("SUVs", pSuv);
    
    ArrayList<Integer> pMinivan = new ArrayList<Integer>();
    pMinivan.add(20);
    body.put("Minivan", pMinivan);
   
    ArrayList<Integer> pPickuptruck = new ArrayList<Integer>();
    pPickuptruck.add(30); pPickuptruck.add(31); pPickuptruck.add(32); pPickuptruck.add(33); pPickuptruck.add(39);  
    body.put("Pickup Truck", pPickuptruck);
   
    ArrayList<Integer> pSemitruck = new ArrayList<Integer>();
    pSemitruck.add(65); pSemitruck.add(66);    
    body.put("Semi-Truck", pSemitruck);
    
    ArrayList<Integer> pDeliveryvan = new ArrayList<Integer>();
    pDeliveryvan.add(21); pDeliveryvan.add(22); pDeliveryvan.add(28);    
    body.put("Delivery Vans", pDeliveryvan);
    
    ArrayList<Integer> pMotorcycle = new ArrayList<Integer>();
    pMotorcycle.add(80); pMotorcycle.add(81); pMotorcycle.add(82); pMotorcycle.add(88);
    body.put("Motorcycles", pMotorcycle);
    
    ArrayList<Integer> pBuses = new ArrayList<Integer>();
    pBuses.add(50); pBuses.add(51); pBuses.add(52); pBuses.add(58);
    body.put("Buses", pBuses);
    
    ArrayList<Integer> pLargenroad = new ArrayList<Integer>();
    pLargenroad.add(92); pLargenroad.add(93);  
    body.put("Large non-road vehicles", pLargenroad);
  
    ArrayList<Integer> pMediumnroad = new ArrayList<Integer>(); 
    pMediumnroad.add(90); pMediumnroad.add(97); pMediumnroad.add(99);
    body.put("Medium non-road vehicles", pMediumnroad);
    
    ArrayList<Integer> pSmallnroad = new ArrayList<Integer>();
    pSmallnroad.add(97); pSmallnroad.add(83); 
    body.put("Small non-road vehicles", pSmallnroad);
  }

  private void initializeDrugsHashMap() {
    drugs = new HashMap<String, ArrayList<Integer>>();
    
    ArrayList<Integer> pNodrugsNottested = new ArrayList<Integer>();
    pNodrugsNottested.add(0); pNodrugsNottested.add(1); pNodrugsNottested.add(-1); 
    drugs.put("No Drugs/Not Tested", pNodrugsNottested);
    
    ArrayList<Integer> pOpiates = new ArrayList<Integer>();
    pOpiates.add(407); pOpiates.add(128); pOpiates.add(177); pOpiates.add(187);
    drugs.put("Opiates", pOpiates);
    
    ArrayList<Integer> pMarijuana = new ArrayList<Integer>();
    pMarijuana.add(603); pMarijuana.add(601); pMarijuana.add(602); pMarijuana.add(605); pMarijuana.add(606); 
    drugs.put("Marijuana", pMarijuana);
    
    ArrayList<Integer> pPainkillers = new ArrayList<Integer>();
    pPainkillers.add(100); pPainkillers.add(114);
    drugs.put("Painkillers", pPainkillers);
    
    ArrayList<Integer> pPsych = new ArrayList<Integer>();
    pPsych.add(510); pPsych.add(513); pPsych.add(515);
    drugs.put("Psychadelics", pPsych);
    
    ArrayList<Integer> pAmph = new ArrayList<Integer>();
    pAmph.add(400); pAmph.add(401); pAmph.add(417); pAmph.add(408); pAmph.add(500);
    drugs.put("Amphetamines", pAmph);
    
    ArrayList<Integer> pSleep = new ArrayList<Integer>();
    pSleep.add(304); pSleep.add(189);
    drugs.put("Sleeping Drugs", pSleep);
  }

  private void initializeARFHashMap() {
   arf = new HashMap<String, ArrayList<Integer>>();
   
   ArrayList<Integer> pTires = new ArrayList<Integer>();
   pTires.add(1);
   arf.put("Tires", pTires);
   
   ArrayList<Integer> pBrakes = new ArrayList<Integer>();
   pBrakes.add(2);
   arf.put("Brakes", pBrakes);
   
   ArrayList<Integer> pSteering = new ArrayList<Integer>();
   pSteering.add(3);
   arf.put("Steering", pSteering);
   
   ArrayList<Integer> pEngine = new ArrayList<Integer>();
   pEngine.add(6); 
   arf.put("Engine", pEngine);
   
   ArrayList<Integer> pLights = new ArrayList<Integer>();
   pLights.add(7); pLights.add(8); pLights.add(9);
   arf.put("Lights", pLights);
   
   ArrayList<Integer> pSeatbelt = new ArrayList<Integer>();
   pSeatbelt.add(1); pSeatbelt.add(2); pSeatbelt.add(3); pSeatbelt.add(4); pSeatbelt.add(5); pSeatbelt.add(6);
   arf.put("Seatbelts", pSeatbelt);
    
  } 
  
  public DataBrowser(PApplet p, String username, String password, String db, String s) {
    user = username;
    pass = password;
    database = db;
    server = s;
    
    try{
      msql = new MySQL(p, server, database, user, pass);
    }
    catch(Exception e) {
      println(e);  
    }
  
    initConversionMaps();
  }
  
  // Gets you a mapping of month crash data to the count for a particular year...TODO: Need to cache data
  public HashMap<Integer, Integer> getCrashMonthNumbersForYear(String state, int yr, ArrayList<String> weather, ArrayList<String> bodyTypesParam, ArrayList<String> arfParam, ArrayList<String> drugsParam, boolean includeMale, boolean includeFemale, int startAge, int endAge)  {
    String query = generateQueryString(state, false, -1, -1, yr, weather, bodyTypesParam, arfParam, drugsParam, includeMale, includeFemale, startAge, endAge);
    
    HashMap<Integer, Integer> monthCount = new HashMap<Integer, Integer>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        int month = msql.getInt(state.toLowerCase()+".iaccmon");
        if(!monthCount.containsKey(month)) {
          monthCount.put(month, 1); 
        } else {
          monthCount.put(month, monthCount.get(month) + 1);
        }        
      }
    }
    
    return monthCount;
  }
  
  public HashMap<Integer, Integer> getCrashDayNumbersForMonthYear(String state, int m, int yr, ArrayList<String> weather, ArrayList<String> bodyTypesParam, ArrayList<String> arfParam, ArrayList<String> drugsParam, boolean includeMale, boolean includeFemale, int startAge, int endAge)  {
    String query = generateQueryString(state, false, -1, m, yr, weather, bodyTypesParam, arfParam, drugsParam, includeMale, includeFemale, startAge, endAge);
    
    HashMap<Integer, Integer> dayCount = new HashMap<Integer, Integer>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        int day = msql.getInt(state.toLowerCase()+".iaccday");
        if(!dayCount.containsKey(day)) {
          dayCount.put(day, 1); 
        } else {
          dayCount.put(day, dayCount.get(day) + 1);
        }        
      }
    }
    
    return dayCount;
  }
  
  // TODO
  public HashMap<Integer, Integer> getCrashHourNumbersForMonthDayYear(String state, int d, int m, int yr, ArrayList<String> weather, ArrayList<String> bodyTypesParam, ArrayList<String> arfParam, ArrayList<String> drugsParam, boolean includeMale, boolean includeFemale, int startAge, int endAge)  {
    String query = generateQueryString(state, false, d, m, yr, weather, bodyTypesParam, arfParam, drugsParam, includeMale, includeFemale, startAge, endAge);
    
    HashMap<Integer, Integer> hourCount = new HashMap<Integer, Integer>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        int hour = msql.getInt(state.toLowerCase()+".iacchr");
        if(!hourCount.containsKey(hour)) {
          hourCount.put(hour, 1); 
        } else {
          hourCount.put(hour, hourCount.get(hour) + 1);
        }        
      }
    }
    
    return hourCount;
  } 
  
  // TODO
  public HashMap<Date, Point> getMonthGeoDataForYear(String state, int yr, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arf, ArrayList<String> drugs, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    return null;
  }
  
  // TODO
  public HashMap<Date, Point> getDayGeoDataForMonthYear(String state, int m, int yr, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arf, ArrayList<String> drugs, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    return null;
  }
  
  // TODO
  public HashMap<Date, Point> getHourGeoDataForMonthYear(String state, int d, int m, int yr, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arf, ArrayList<String> drugs, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    return null;
  }
  
  // This helper method is ungodly messy...man, I could use a drink right about now...
  private String generateQueryString(String state, boolean wantGeoData, int d, int m, int yr, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    String query = "select crashid, iacchr, iaccday, iaccmon, crashyear";
    
    query += (wantGeoData)?(", latitude, longitude from "+state.toLowerCase()+" where "):" from "+state.toLowerCase()+" where";
              
    if(d != -1) {
      query += " iaccday=" + d;       
    }
    if( m != -1) {
      if( d != -1) query += " and iaccmon=" + m;
      else query += " iaccmon=" + m;  
    }
    if( yr != -1) {
      if( m != -1 || d != -1) query += " and crashyear=" + yr;
      else query += " crashyear=" + yr; 
    }
      
    // tack on the weather conditions
    if(!weather.isEmpty()) {
      query += " and iatmcond in (";
      
      for (String atmCond : atm.keySet()) {
        for(int j = 0; j < weather.size(); j++) {
          if(atmCond.toLowerCase().contains(weather.get(j).toLowerCase())) {
            if( j != (weather.size() - 1)) {
              query += atm.get(atmCond) + ",";
            }
            else {
              query += atm.get(atmCond) + ")"; 
            }
          }
        } 
      }  
    }
    
    if(!bodyTypes.isEmpty()) {
      query += " and ibody in (";     
      for (String bodyName : body.keySet()) {
        for(int j = 0; j < bodyTypes.size(); j++) {
          if(bodyName.toLowerCase().contains(bodyTypes.get(j).toLowerCase())) {
              ArrayList<Integer> tmp = body.get(bodyName);
              String p = "";
              for(int i = 0 ; i < tmp.size(); i++) {
                if(j == 0 && i == 0){
                  query += tmp.get(i);  
                }
                else {
                  p += " " + tmp.get(i);                 
                }
              }
              p = p.replace(' ', ',');
              query += p;
            }
          }
        }
       query += ")"; 
      }  
    
    if(!arfArr.isEmpty()) {
      query += " and iarf1 in (";     
      for (String arfName : arf.keySet()) {
        for(int j = 0; j < arfArr.size(); j++) {
          if(arfName.toLowerCase().contains(arfArr.get(j).toLowerCase())) {
              ArrayList<Integer> tmp = arf.get(arfName);
              String p = "";
              for(int i = 0 ; i < tmp.size(); i++) {
                if(j == 0 && i == 0){
                  query += tmp.get(i);  
                }
                else {
                  p += " " + tmp.get(i);                 
                }
              }
              p = p.replace(' ', ',');
              query += p;
            }
          }
        }
       query += ")"; 
      }  
     
     if(!drugsArr.isEmpty()) {
      query += " and idrugres1 in (";     
      for (String drugName : drugs.keySet()) {
        for(int j = 0; j < drugsArr.size(); j++) {
          if(drugName.toLowerCase().contains(drugsArr.get(j).toLowerCase())) {
              ArrayList<Integer> tmp = drugs.get(drugName);
              String p = "";
              for(int i = 0 ; i < tmp.size(); i++) {
                if(j == 0 && i == 0){
                  query += tmp.get(i);  
                }
                else {
                  p += " " + tmp.get(i);                 
                }
              }
              p = p.replace(' ', ',');
              query += p;
            }
          }
        }
        query += ")";
       if (drugsArr.contains("Alcohol")) {
         query += " and ialcres between 8 and 94";
       } 
      }
      
      if(includeMale && !includeFemale) query += " and isex=1";
      else if(!includeMale && includeFemale) query += " and isex=2";
      
      query += " and iage between " + startAge + " and " + endAge;
    
    return query;
  }
  
}
