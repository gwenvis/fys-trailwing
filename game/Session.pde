public class SessionDatabase
{
  Database database;

  /*
  * make connection to the database
   */
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
   * get the new inset id, then create a new record and return it
   */
  public Session addSession(Session session)
  {
    int id = formatDefaultList(String.format("SELECT MAX(`id`) FROM `session`")).get(0).getId() + 1;

    database.updateQuery(
      String.format("INSERT INTO `session` (`id`, `coins`, `distance`, `time_played`, `created_on`, `player_id`) VALUES (%d, %d, %d, \"%s\", CURRENT_TIMESTAMP, %d);", 
      id, session.getCoins(), session.getDistance(), session.getTimePlayed(), session.getPlayerId()));

    Session last = formatDefaultList(String.format("SELECT * FROM `session` WHERE id = %d", id)).get(0);

    return last;
  }

  /*
   * update session by id and Session object
   */
  public void updateSession(int id, Session session)
  {
    database.updateQuery(
      String.format("UPDATE `session` SET `coins` = %d, `distance` = %d WHERE `session`.`id` = %d;", session.getCoins(), session.getDistance(), id));
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

  /*
  *  gets a limited amount of sessions (by page)
   */
  public ArrayList<Session> getSessionsPaginated(int page, int amountPerPage) 
  {
    return formatDefaultList(String.format("SELECT `session`.*, `player`.`name` as name FROM `session` inner join `player` on `session`.`id` = `player`.id LIMIT %d, %d", page, amountPerPage));
  }

  /*
  *  gets a limited amount of the best sessions (by page)
   */
  public ArrayList<Session> getBestSessionsPaginated(int page, int amountPerPage) 
  {
    return formatDefaultList(String.format("SELECT `session`.*, `player`.`name` as name FROM `session` inner join `player` on `session`.`player_id` = `player`.id ORDER BY `session`.distance DESC LIMIT %d, %d", page, amountPerPage));
  }

  /*
  *  gets sessions by distance and coins
   */
  public ArrayList<Session> getSessionsByStats(int distance, int coins) 
  {
    return formatDefaultList(String.format("SELECT * FROM `session` WHERE `distance` >= %d and coins >= %d ORDER BY distance DESC", distance, coins));
  }

  /*
  *  gets sessions by name
   */
  public ArrayList<Session> getSessionsByUsername(String name) 
  {
    return formatDefaultList(String.format("SELECT `session`.* FROM `session` inner join player on `session`.`player_id` = `player`.`id` where `player`.`name` LIKE %s", name));
  }

  /*
  *  makes a neat ArrayList of the database response
   */
  private ArrayList<Session> formatDefaultList(String query) {
    Table sessionTable = database.runQuery(query);
    if (sessionTable.getRowCount() == 0) return null;

    ArrayList<Session> sessions = new ArrayList<Session>();

    for (int row = 0; row < sessionTable.getRowCount(); row++)
    {
      int id = -1;
      int coins = 0;
      int distance = 0;
      String timePlayed = null;
      String createdOn = null;
      int playerId = 0;
      String player = "";

      for (int col = 0; col < sessionTable.getColumnCount(); col++)
      {
        if (col == 0) id = sessionTable.getInt(row, col);
        if (col == 1) coins = sessionTable.getInt(row, col);
        if (col == 2) distance = sessionTable.getInt(row, col);
        if (col == 3) timePlayed = sessionTable.getString(row, col);
        if (col == 4) createdOn = sessionTable.getString(row, col);
        if (col == 5) playerId = sessionTable.getInt(row, col);
        if (col == 6) player = sessionTable.getString(row, col);
      }

      sessions.add(new Session(id, coins, distance, timePlayed, createdOn, playerId, player));
    }

    return sessions;
  }
}

/**
 *  Session object used for easy storage
 */
public class Session
{
  public Session(int id, int coins, int distance, String timePlayed, String createdOn, int playerId, String player)
  {
    this.id = id;
    this.coins = coins;
    this.distance = distance;
    this.timePlayed = timePlayed;
    this.createdOn = createdOn;
    this.playerId = playerId;
    this.player = player;
  }

  private int id;
  private int coins;
  private int distance;
  private String timePlayed;
  private String createdOn;
  private int playerId;
  private String player;

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
  public String getPlayer() { 
    return player;
  }
}
