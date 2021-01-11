/* 
 * @author Chantal Boodt 
 */

class AchievementsDatabase { 
  /*
   *Declaration of variables/objects
   */
  Database database;

  private boolean currentlyAchieved;
  private int playerId, achievementId, active, nonActive, achieved;
  private String date;

  AchievementsDatabase() {
    /*
     *Initialization of variables/objects
     */
    date = Config.DATE;
    active = Config.ACTIVE;
    nonActive = Config.NON_ACTIVE;
    currentlyAchieved = false;

    /*
     * Make connection to database
     */
    database = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");
  }

  /*
   * Checks whether achievement exists, updated, needs to be added or read
   */
  void achievementCheck(int distance, int coinsTotal, int level, boolean fireballHit) {
    achieved = 0;
    playerId = playerdb.id;


    for (achievementId = 1; achievementId <= Config.ACHIEVEMENT_AMOUNT; achievementId++ ) {

      /*
       * Checks if the achievement exists
       */
      currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);

      if (currentlyAchieved) {
        /*
         * Currently exists means it needs to be activated
         */
        achieved++;
        updateAchievement(active, achievementId);
      } else if (achievementId == 1 && distance > 500) {
        /* 
         * Achievement 1 has been achieved
         * Achievement tag: distance higher than 500
         * Achievement name: Member
         */
        achieved++;
        uploadAchievement(playerId, achievementId, date);
      } else if (achievementId == 2 && coinsTotal > 100) {
        /* 
         * Achievement 2 has been achieved
         * Achievement tag: collected more than a 100 coins
         * Achievement name: Officer
         */
        achieved++;
        uploadAchievement(playerId, achievementId, date);
      } else if (achievementId == 3 && level ==  Config.MAX_CHUNCK_LEVEL) {
        /* Achievement 3 has been achieved
         * Achievement tag: reached the last level
         * Achievement name: Commander
         */
        achieved++;
        uploadAchievement(playerId, achievementId, date);
      } else if (achievementId == 4 && !fireballHit) {
        /* Achievement 4 has been achieved
         * Achievement tag: was not hit by a fireball
         * Achievement name: Knight and Dame Commander
         */
        achieved++;
        uploadAchievement(playerId, achievementId, date);
      } else if (achieved >= 4) {
        /*
         * Achievement 5 has been achieved
         * Achievement tag: achieved all other achievements
         * Achievement name: Knight and Dame Grand Cross
         */
        uploadAchievement(playerId, achievementId, date);
      } else {      
        /*
         * Currently does NOT exist in table playerachievement
         * Means it needs to be deactivated in table achievements
         */
        updateAchievement(nonActive, achievementId);
      }
    }
  }

  /*
   * Indicates whether the achievement is active or not and makes sure it is saved into the achievements table
   */
  void updateAchievement(int activity, int achievementId) {
    database.updateQuery(String.format("UPDATE `achievements` SET `achievements`.`active` = %s WHERE id = %s", activity, achievementId));
  }

  /*
   * Adds achievement into the playerachievement table in the database
   */
  void uploadAchievement(int playerId, int achievementId, String date) {
    database.updateQuery(String.format("INSERT INTO playerachievement(player_id, achievement_id, created_on) VALUES('%s','%s','%s')", playerId, achievementId, date));
  }

  /*
   * Joins multiple tables, makes sure all variables exist and returns them in a table
   */
  Table readPlayerAchievement() {
    String query = String.format("SELECT  `achievements`.`name`, `playerachievement`.`created_on` FROM `player` inner join playerachievement on `player`.`id` = `playerachievement`.`player_id` inner join achievements on `playerachievement`.`achievement_id` = `achievements`.`id` WHERE `player`.`id` = %s AND `achievements`.`active`= %s  ORDER BY `playerachievement`.`created_on` ASC", playerId, active);
    Table output = database.runQuery(query);
    return output;
  }

  /*
   * Reads table, searches for the achievement and returns a true or false value which indicates whether it exists or not
   */
  boolean achievementAlreadyAchieved(int playerId, int achievementId) { 
    String query = String.format("SELECT COUNT(*) FROM playerachievement WHERE achievement_id = '%s' AND player_id = '%s'", achievementId, playerId);
    Table output = database.runQuery(query);
    return output.getInt(0, 0) == 1;
  }
}
