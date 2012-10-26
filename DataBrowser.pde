import de.bezier.data.sql.*;

class DataBrowser {
  MySQL msql;
  String user;
  String pass;
  String database;
  String server;
  
  // Hashmaps to convert from num to string
  HashMap<Integer, String> atm;
  HashMap<Integer, String> cf;
 
  public void initConversionMaps() {
    // Atmospheric conditions data
    atm= new HashMap<Integer, String>();
    atm.put(-1, "Blank"); atm.put(1,"No Adverse Atmospheric Conditions"); atm.put(2,"Rain"); atm.put(3, "Sleet (Hail)"); atm.put(4, "Snow"); atm.put(5, "Fog"); atm.put(6, "Rain And Fog"); atm.put(7, "Sleet And Fog"); atm.put(8, "Other(Smog, Smoke, Blowing Sand Or Dust)"); atm.put(9, "Unknown");
    //Crash factors
    cf = new HashMap<Integer, String>();
    cf.put(-1, "Blank"); cf.put(0,"None"); cf.put(1,"Inadequate Warning Of Exits, Lanes Narrowing, Traffic Controls, Etc."); cf.put(2,"Shoulder Design Or Condition"); cf.put(3,"Other Construction-Created Condition"); cf.put(4,"No Or Obscured Pavement Marking"); cf.put(5, "Surface Under Water"); cf.put(6, "Inadequate Construction Or Poor Design Of Roadway,Bridge, Etc."); cf.put(7,"Surface Washed Out(caved-in, Road Slippage)"); cf.put(14,"Motor Vehicle In Transport Struck By Falling Cargo,or Something That Came Loose From Or Something That Was Set In Motion By A Vehicle"); cf.put(15,"Non-occupant Struck By Falling Cargo, Or Something That Came Loose From, Or Something That Was Set In Motion By A Vehicle"); cf.put(16,"Non-occupant Struck Vehicle"); cf.put(17,"Vehicle Set-in-motion By Non-driver"); cf.put(18, "Date Of Accident And Date Of EMS Notification Were Not The Same Day"); cf.put(19,"Recent/Previous Accident Scene Nearby"); cf.put(20, "Police Pursuit Involved"); cf.put(21,"Within Designated School Zone"); cf.put(22,"Speed Limit Is A Statutory Limit As Recorded Or Was Determined As This State's basic rule"); cf.put(99,"Unknown");
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
  
}
