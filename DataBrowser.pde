import de.bezier.data.sql.*;
/*
  Class that interacts with DB to get data based on the methods in the class
  TODO: CACHING BRO
*/

class DataBrowser {
  private MySQL msql;
  private String user;
  private String pass;
  private String database;
  private String server;
  
  private String currentState;
  private int currentYear;
  
  //Data cache
  private DataCache dCache;  
  // Hashmaps to convert from num to string
  private HashMap<String, Integer> atm;
  //HashMap<Stri> cf;
  private HashMap<String, Integer> surfCond;
  private HashMap<String, ArrayList<Integer>> body;
  private HashMap<String, ArrayList<Integer>> drugs;
  private HashMap<String, ArrayList<Integer>> arf;
  
  public DataBrowser(PApplet p, String username, String password, String db, String s) {
    user = username;
    pass = password;
    database = db;
    server = s;
    
    dCache = new DataCache();
    currentState = "illinois";
    currentYear = 2001;
    
    try{
      println("Connecting to " + database+":"+server);
      msql = new MySQL(p, server, database, user, pass);
      println("Connected!");
    }
    catch(Exception e) {
      println(e);  
    }
  
    initConversionMaps();
    //loadStateDataIntoCache();
    
    /*ArrayList<String> w = new ArrayList<String>(atm.keySet());
    ArrayList<String> b = new ArrayList<String>(body.keySet());
    ArrayList<String> a = new ArrayList<String>(arf.keySet());
    ArrayList<String> d = new ArrayList<String>(drugs.keySet());
    ArrayList<String> r = new ArrayList<String>(surfCond.keySet());
    HashMap<Integer, Crash> blah = getMonthGeoDataForYear_new("illinois", 2001,r, w, b, a, d, true, true, 12, 69);
    
    println(blah.size());*/
  }
  
  public void initConversionMaps() {
    // Atmospheric conditions data
    atm = new HashMap<String, Integer>();
    atm.put("Blank", -1); atm.put("Good Conditions", 1); atm.put("Rain", 2); atm.put("Sleet (Hail)", 3); atm.put("Snow", 4); atm.put("Fog", 5); atm.put("Rain And Fog", 6); atm.put("Sleet And Fog", 7); atm.put("Other(Smog, Smoke, Blowing Sand Or Dust)", 8); atm.put("Unknown", 9);
    //Crash factors
    //cf = new HashMap<Integer, String>();
    //cf.put("Blank", -1); cf.put("None", 0); cf.put("Inadequate Warning Of Exits, Lanes Narrowing, Traffic Controls, Etc.", 1); cf.put("Shoulder Design Or Condition", 2); cf.put("Other Construction-Created Condition", 3); cf.put("No Or Obscured Pavement Marking", 4); cf.put("Surface Under Water", 5); cf.put("Inadequate Construction Or Poor Design Of Roadway,Bridge, Etc.", 6); cf.put(7,"Surface Washed Out(caved-in, Road Slippage)"); cf.put(14,"Motor Vehicle In Transport Struck By Falling Cargo,or Something That Came Loose From Or Something That Was Set In Motion By A Vehicle"); cf.put(15,"Non-occupant Struck By Falling Cargo, Or Something That Came Loose From, Or Something That Was Set In Motion By A Vehicle"); cf.put(16,"Non-occupant Struck Vehicle"); cf.put(17,"Vehicle Set-in-motion By Non-driver"); cf.put(18, "CDate Of Accident And CDate Of EMS Notification Were Not The Same Day"); cf.put(19,"Recent/Previous Accident Scene Nearby"); cf.put(20, "Police Pursuit Involved"); cf.put(21,"Within Designated School Zone"); cf.put(22,"Speed Limit Is A Statutory Limit As Recorded Or Was Determined As This State's basic rule"); cf.put(99,"Unknown");
    initializeBodyHashMap();
    initializeDrugsHashMap();
    initializeARFHashMap();
    initializeSurfcondHashMap();
  }
  
  private void initializeSurfcondHashMap() {
    surfCond = new HashMap<String, Integer>();
    surfCond.put("Wet", 2); surfCond.put("Snowy", 3); surfCond.put("Icy", 4); surfCond.put("Dirt", 5); surfCond.put("Other", 8);      
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
  
  private void loadStateDataIntoCache(){
    String query = "select crashid, iacchr, iaccday, iaccmon, crashyear, ibody, idrugres1, iatmcond, iarf1, isex, iage, ialcres, latitude, longitude from "+currentState+" where crashyear="+currentYear;
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        int cid = msql.getInt(currentState.toLowerCase()+".crashid");
        boolean isM = true;
        boolean isDrunk = false;
        
        if(msql.getInt(currentState.toLowerCase()+".isex") == 2) isM = false;
        if(msql.getInt(currentState.toLowerCase()+".isex") > 8) isDrunk = true;
        
        Point p = new Point(msql.getString(currentState.toLowerCase()+".latitude"), msql.getString(currentState.toLowerCase()+".longitude"));
        CDate d = new CDate(msql.getInt(currentState.toLowerCase()+".iaccmon"), msql.getInt(currentState.toLowerCase()+".iaccday"), msql.getInt(currentState.toLowerCase()+".crashyear"), msql.getInt(currentState.toLowerCase()+".iacchr"));
        Crash c = new Crash(cid, msql.getInt(currentState.toLowerCase()+".isurfcond"), msql.getInt(currentState.toLowerCase()+".iarf1"), msql.getInt(currentState.toLowerCase()+".idrugres1"), msql.getInt(currentState.toLowerCase()+".ibody"), msql.getInt(currentState.toLowerCase()+".iatmcond"), msql.getInt(currentState.toLowerCase()+".iage"), isM, currentState, isDrunk, d, p); 
        dCache.addToCache(cid, c);
      }
    }
  }
  
  // Gets you a mapping of month crash data to the count for a particular year...TODO: Need to cache data
  public HashMap<Integer, Integer> getCrashMonthNumbersForYear(String state, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypesParam, ArrayList<String> arfParam, ArrayList<String> drugsParam, boolean includeMale, boolean includeFemale, int startAge, int endAge)  {
    state = state.replace(' ', '_');    
    String query = generateQueryString(state, false, -1, -1, yr, weather, roadConditions, bodyTypesParam, arfParam, drugsParam, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");
    
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
  
  public HashMap<Integer, Integer> getCrashDayNumbersForMonthYear(String state, int m, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypesParam, ArrayList<String> arfParam, ArrayList<String> drugsParam, boolean includeMale, boolean includeFemale, int startAge, int endAge)  {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, false, -1, m, yr, weather, roadConditions, bodyTypesParam, arfParam, drugsParam, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");

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
  public HashMap<Integer, Integer> getCrashHourNumbersForMonthDayYear(String state, int d, int m, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypesParam, ArrayList<String> arfParam, ArrayList<String> drugsParam, boolean includeMale, boolean includeFemale, int startAge, int endAge)  {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, false, d, m, yr, weather, bodyTypesParam, roadConditions, arfParam, drugsParam, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");

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
  
  // Gets you all of the crash points and CDate for each crash for that entire year with the factos passed in
  public HashMap<Integer, Crash> getMonthGeoDataForYear_new(String state, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, true, -1, -1, yr, roadConditions, weather, bodyTypes, arfArr, drugsArr, includeMale, includeFemale, startAge, endAge);    
    println("Query: " + query + "\n");

    HashMap<Integer, Crash> monthCount = new HashMap<Integer, Crash>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
          int cid = msql.getInt(state.toLowerCase()+".crashid");
          boolean isM = true;
          boolean isDrunk = false;
        
          if(msql.getInt(state.toLowerCase()+".isex") == 2) isM = false;
          if(msql.getInt(state.toLowerCase()+".isex") > 8) isDrunk = true;
        
          Point p = new Point(msql.getString(state.toLowerCase()+".latitude"), msql.getString(state.toLowerCase()+".longitude"));
          CDate d = new CDate(msql.getInt(state.toLowerCase()+".iaccmon"), msql.getInt(state.toLowerCase()+".iaccday"), msql.getInt(state.toLowerCase()+".crashyear"), msql.getInt(state.toLowerCase()+".iacchr"));
          Crash c = new Crash(cid, msql.getInt(state.toLowerCase()+".isurfcond"), msql.getInt(state.toLowerCase()+".iarf1"), msql.getInt(state.toLowerCase()+".idrugres1"), msql.getInt(state.toLowerCase()+".ibody"), msql.getInt(state.toLowerCase()+".iatmcond"), msql.getInt(state.toLowerCase()+".iage"), isM, state, isDrunk, d, p); 
          dCache.addToCache(cid, c);
          monthCount.put(cid, c);                
        }        
      }
    return monthCount;
  }
  
  // TODO - Gets you all of the crash points and CDate for each crash for that entire month for the year with the factos passed in
  public HashMap<Integer, Crash> getDayGeoDataForMonthYear_new(String state, int m, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, true, -1, m, yr, roadConditions, weather, bodyTypes, arfArr, drugsArr, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");
    
    HashMap<Integer, Crash> dayCount = new HashMap<Integer, Crash>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        int cid = msql.getInt(state.toLowerCase()+".crashid");
          boolean isM = true;
          boolean isDrunk = false;
        
          if(msql.getInt(state.toLowerCase()+".isex") == 2) isM = false;
          if(msql.getInt(state.toLowerCase()+".isex") > 8) isDrunk = true;
        
          Point p = new Point(msql.getString(state.toLowerCase()+".latitude"), msql.getString(state.toLowerCase()+".longitude"));
          CDate d = new CDate(msql.getInt(state.toLowerCase()+".iaccmon"), msql.getInt(state.toLowerCase()+".iaccday"), msql.getInt(state.toLowerCase()+".crashyear"), msql.getInt(state.toLowerCase()+".iacchr"));
          Crash c = new Crash(cid, msql.getInt(state.toLowerCase()+".isurfcond"), msql.getInt(state.toLowerCase()+".iarf1"), msql.getInt(state.toLowerCase()+".idrugres1"), msql.getInt(state.toLowerCase()+".ibody"), msql.getInt(state.toLowerCase()+".iatmcond"), msql.getInt(state.toLowerCase()+".iage"), isM, state, isDrunk, d, p); 
          dCache.addToCache(cid, c);
          dayCount.put(cid, c);                                           
        }
      }
    return dayCount;
  }
  
  // TODO
  public HashMap<Integer, Crash> getHourGeoDataForMonthYear_new(String state, int d, int m, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, true, d, m, yr, roadConditions, weather, bodyTypes, arfArr, drugsArr, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");
    
    HashMap<Integer, Crash> dayCount = new HashMap<Integer, Crash>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        int cid = msql.getInt(state.toLowerCase()+".crashid");
          boolean isM = true;
          boolean isDrunk = false;
        
          if(msql.getInt(state.toLowerCase()+".isex") == 2) isM = false;
          if(msql.getInt(state.toLowerCase()+".isex") > 8) isDrunk = true;
        
          Point p = new Point(msql.getString(state.toLowerCase()+".latitude"), msql.getString(state.toLowerCase()+".longitude"));
          CDate cd = new CDate(msql.getInt(state.toLowerCase()+".iaccmon"), msql.getInt(state.toLowerCase()+".iaccday"), msql.getInt(state.toLowerCase()+".crashyear"), msql.getInt(state.toLowerCase()+".iacchr"));
          Crash c = new Crash(cid, msql.getInt(state.toLowerCase()+".isurfcond"), msql.getInt(state.toLowerCase()+".iarf1"), msql.getInt(state.toLowerCase()+".idrugres1"), msql.getInt(state.toLowerCase()+".ibody"), msql.getInt(state.toLowerCase()+".iatmcond"), msql.getInt(state.toLowerCase()+".iage"), isM, state, isDrunk, cd, p); 
          dCache.addToCache(cid, c);
          dayCount.put(cid, c);                                   
        }
      }
    return dayCount;
  }
  
  // This helper method is ungodly messy...man, I could use a drink right about now...
  private String generateQueryString(String state, boolean wantGeoData, int d, int m, int yr,ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    String query = "select crashid, iacchr, iaccday, iaccmon, crashyear, ibody, idrugres1, iatmcond, iarf1, isex, iage, ialcres, isurfcond";
    
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
      
    // tack on roadConditions
    if(!roadConditions.isEmpty()) {
      query += " and isurfcond in (";
      
      for (String rName : surfCond.keySet()) {
        for(int j = 0; j < roadConditions.size(); j++) {
          if(roadConditions.get(j).toLowerCase().contains(rName.toLowerCase())) {
            if( j != (roadConditions.size() - 1)) {
              query += surfCond.get(rName) + ",";
            }
            else {
              query += surfCond.get(rName) + ")"; 
            }
          }
        } 
      }  
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
  
  // Gets you all of the crash points and CDate for each crash for that entire year with the factos passed in
  public HashMap<CDate, Point> getMonthGeoDataForYear(String state, int yr, ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, true, -1, -1, yr, roadConditions, weather, bodyTypes, arfArr, drugsArr, includeMale, includeFemale, startAge, endAge);    
    println("Query: " + query + "\n");

    HashMap<CDate, Point> monthCount = new HashMap<CDate, Point>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        String lat = msql.getString(state.toLowerCase()+".latitude");
        String longitude = msql.getString(state.toLowerCase()+".longitude");
        
        if( !lat.equals(".") && !longitude.equals(".")) {
          Point p = new Point(lat, longitude);
          CDate d = new CDate(msql.getInt(state.toLowerCase()+".iaccmon"),
                            -1,
                            yr,
                            -1);
          monthCount.put(d, p);                
        }        
      }
    }
    return monthCount;
  }
  
  // TODO - Gets you all of the crash points and CDate for each crash for that entire month for the year with the factos passed in
  public HashMap<CDate, Point> getDayGeoDataForMonthYear(String state, int m, int yr,  ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, true, -1, m, yr, roadConditions, weather, bodyTypes, arfArr, drugsArr, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");
    
    HashMap<CDate, Point> dayCount = new HashMap<CDate, Point>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        String lat = msql.getString(state.toLowerCase()+".latitude");
        String longitude = msql.getString(state.toLowerCase()+".longitude");
        
        if( !lat.equals(".") && !longitude.equals(".")) {
          Point p = new Point(lat, longitude);
          CDate d = new CDate(m,
                              msql.getInt(state.toLowerCase()+".iaccday"),
                              yr,
                              -1);
          dayCount.put(d, p);                             
        }
      }
    }
    return dayCount;
  }
  
  // TODO
  public HashMap<CDate, Point> getHourGeoDataForMonthYear(String state, int d, int m, int yr,  ArrayList<String> roadConditions, ArrayList<String> weather, ArrayList<String> bodyTypes, ArrayList<String> arfArr, ArrayList<String> drugsArr, boolean includeMale, boolean includeFemale, int startAge, int endAge) {
    state = state.replace(' ', '_');
    String query = generateQueryString(state, true, d, m, yr, weather, roadConditions, bodyTypes, arfArr, drugsArr, includeMale, includeFemale, startAge, endAge);
    println("Query: " + query + "\n");
    
    HashMap<CDate, Point> dayCount = new HashMap<CDate, Point>();
    if (msql.connect()) {
      msql.query(query);
      while(msql.next()) {
        String lat = msql.getString(state.toLowerCase()+".latitude");
        String longitude = msql.getString(state.toLowerCase()+".longitude");
        
        if( !lat.equals(".") && !longitude.equals(".")) {
          Point p = new Point(lat, longitude);
          CDate c = new CDate(m,
                              d,
                              yr,
                              msql.getInt(state.toLowerCase()+".iacchr"));
          dayCount.put(c, p);                             
        }
      }
    }
    return dayCount;
  }
 
 private ArrayList<Integer> getAtmNumbers(ArrayList<String> factors) {
   ArrayList<Integer> nums = new ArrayList<Integer>();
   //1: atm, 2 body, 3: arf, 4:drugs
    for (String atmCond : atm.keySet()) {
        for(int j = 0; j < factors.size(); j++) {
          if(factors.get(j).toLowerCase().contains(atmCond.toLowerCase())) {
            nums.add(atm.get(atmCond));
          }
        }
    }
  return nums;
 }
 
 private ArrayList<Integer> getBodyNumbers(ArrayList<String> factors) {
   ArrayList<Integer> nums = new ArrayList<Integer>();
   //1: atm, 2 body, 3: arf, 4:drugs
   for (String bName : body.keySet()) {
        for(int j = 0; j < factors.size(); j++) {
          if(factors.get(j).toLowerCase().contains(bName.toLowerCase())) {
              ArrayList<Integer> tmp = body.get(bName);
              for(int i = 0; i < tmp.size(); i++) {
                nums.add(tmp.get(i)); 
              }
          }
        }
   }
  return nums;
 }
 
 private ArrayList<Integer> getArfNumbers(ArrayList<String> factors) {
  ArrayList<Integer> nums = new ArrayList<Integer>();
   //1: atm, 2 body, 3: arf, 4:drugs
   for (String aName : arf.keySet()) {
        for(int j = 0; j < factors.size(); j++) {
          if(factors.get(j).toLowerCase().contains(aName.toLowerCase())) {
              ArrayList<Integer> tmp = arf.get(aName);
              for(int i = 0; i < tmp.size(); i++) {
                nums.add(tmp.get(i)); 
              }
          }
        }
   }
  return nums;    
 }
 
 public Crash getCrashWithId(int id) {
   return dCache.getCrashWithId(id);   
 }
 
 private ArrayList<Integer> getDrugNumbers(ArrayList<String> factors) {
  ArrayList<Integer> nums = new ArrayList<Integer>();
   //1: atm, 2 body, 3: arf, 4:drugs
   for (String dName : drugs.keySet()) {
        for(int j = 0; j < factors.size(); j++) {
          if(factors.get(j).toLowerCase().contains(dName.toLowerCase())) {
              ArrayList<Integer> tmp = drugs.get(dName);
              for(int i = 0; i < tmp.size(); i++) {
                nums.add(tmp.get(i)); 
              }
          }
        }
   }
  return nums; 
   
 }
 
}
