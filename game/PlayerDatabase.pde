//Made by Patrick Eikema

class PlayerDatabase {  
  Database database;
  String nickName;
  int id;

  PlayerDatabase() {
    database = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");
  }

  // if name exists in db, take that id. If it doesn't , make a new one
  void login(String nickName) {    
    if (!doesPlayerExist(nickName)) {
      String date = String.valueOf(year())+"-"+String.valueOf(month()+"-"+String.valueOf(day()));
      database.updateQuery(String.format("INSERT INTO player(name, created_on) VALUES('%s','%s')", nickName, date));
    }
      loadPlayer(nickName);
      println("Nickname: " + nickName + " id: " + id);
    
  }
  //function to check if the name exists in db.
  boolean doesPlayerExist(String nickName) {
    String query = String.format("SELECT COUNT(id) FROM player WHERE name = '%s'", nickName);
    Table output = database.runQuery(query);
    return output.getInt(0, 0) == 1;
  }
  
  //looks in db for nickname, then takes its id
  void loadPlayer(String nickName) {
    // stores existing playerdata locally.
    this.nickName = nickName;
    String query = String.format("SELECT id FROM player WHERE name = '%s'", nickName);
    Table output = database.runQuery(query);
    id = output.getInt(0, 0);
  }
  
  


}
