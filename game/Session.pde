public class SessionDatabase
{
  Database database;

  SessionDatabase()
  {
    database = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");
  }

  /* Start CRUD */

  /*
   * get all sessions
   */
  public ArrayList<Session> getSessions() 
  {
    return formatDefaultList(String.format("SELECT * FROM `session`"));
  }

  /*
   * add session
   */
  public void addSession(Session session)
  {
    database.updateQuery(
      String.format("INSERT INTO `session` (`id`, `coins`, `distance`, `time_played`, `created_on`, `player_id`) VALUES (null, %d, %d, \"%s\", CURRENT_TIMESTAMP, %d);", 
      session.getCoins(), session.getDistance(), session.getDistance(), session.getTimePlayed(), session.getPlayerId()));
  }

  /*
   * update session
   */
  public void updateSession(int id, Session session)
  {
    database.updateQuery(
      String.format("UPDATE `session` SET `coins` = %d', `distance` = %d WHERE `session`.`id` = %d;", session.getCoins(), session.getDistance(), id));
  }

  /*
   * delete session
   */
  public void deleteSession(int id)
  {
    database.updateQuery(
      String.format("DELETE FROM `session` WHERE `session`.`id` = %d", id));
  }

  /* End CRUD */

  public ArrayList<Session> getSessionsPaginated(int page, int amountPerPage) 
  {
    return formatDefaultList(String.format("SELECT * FROM `session` limit %d, %d", page, amountPerPage));
  }

  public ArrayList<Session> getSessionsByUsername(String name) 
  {
    return formatDefaultList(String.format("SELECT `session`.* FROM `session` inner join player on `session`.`player_id` = `player`.`id` where `player`.`name` LIKE %s", name));
  }

  private ArrayList<Session> formatDefaultList(String query) {
    Table sessionTable = database.runQuery(query);
    if (sessionTable.getRowCount() == 0) return null;

    ArrayList<Session> sessions = new ArrayList<Session>();

    for (int row = 0; row < sessionTable.getRowCount(); row++)
    {
      int id = 0;
      int coins = 0;
      int distance = 0;
      String timePlayed = null;
      String createdOn = null;
      int playerId = 0;

      for (int col = 0; col < sessionTable.getColumnCount(); col++)
      {
        if (col == 0) id = sessionTable.getInt(row, col);
        if (col == 1) coins = sessionTable.getInt(row, col);
        if (col == 2) distance = sessionTable.getInt(row, col);
        if (col == 3) timePlayed = sessionTable.getString(row, col);
        if (col == 4) createdOn = sessionTable.getString(row, col);
        if (col == 5) playerId = sessionTable.getInt(row, col);
      }

      sessions.add(new Session(id, coins, distance, timePlayed, createdOn, playerId));
    }

    return sessions;
  }
}

public class Session
{
  public Session(int id, int coins, int distance, String timePlayed, String createdOn, int playerId)
  {
    this.id = id;
    this.coins = coins;
    this.distance = distance;
    this.timePlayed = timePlayed;
    this.createdOn = createdOn;
    this.playerId = playerId;
  }

  private int id;
  private int coins;
  private int distance;
  private String timePlayed;
  private String createdOn;
  private int playerId;

  public int getId() { 
    return id;
  }
  public int getCoins() { 
    return coins;
  }
  public int getDistance() { 
    return distance;
  }
  public String getTimePlayed() { 
    return timePlayed;
  }
  public String getCreatedOn() { 
    return createdOn;
  }
  public int getPlayerId() { 
    return playerId;
  }
}
