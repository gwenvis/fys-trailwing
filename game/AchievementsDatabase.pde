class AchievementsDatabase {  
  Database database;
  int playerId, achievementId, active, nonActive;
  boolean currentlyAchieved;

  AchievementsDatabase() {
    active = 1;
    nonActive = 0;
    currentlyAchieved = false;
    database = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");
  }


  void achievementCheck(int distance, int coinsTotal, int level, boolean fireballHit) {
    int achieved = 0, achievementId = 0;
    String date = String.valueOf(year())+"-"+String.valueOf(month()+"-"+String.valueOf(day()));
    playerId = playerdb.id;

    achievementId = 1;
    currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
    if (currentlyAchieved) {
      achieved++;
      updateAchievement(active, achievementId);
    } else if (distance > 500) {
      uploadAchievement(playerId, achievementId, date);
    } else {      
      updateAchievement(nonActive, achievementId);
    }

    achievementId = 2;      
    currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
    if (currentlyAchieved) {
      achieved++;
      updateAchievement(active, achievementId);
    } else if (coinsTotal > 100) {
      uploadAchievement(playerId, achievementId, date);
    } else {      
      updateAchievement(nonActive, achievementId);
    }

    achievementId = 3; 
    currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
    if (currentlyAchieved) {
      achieved++;
      updateAchievement(active, achievementId);
    } else if (level ==  Config.MAX_CHUNCK_LEVEL) {
      uploadAchievement(playerId, achievementId, date);
    } else {      
      updateAchievement(nonActive, achievementId);
    }

    achievementId = 4; 
    currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
    if (currentlyAchieved) {
      achieved++;
      updateAchievement(active, achievementId);
    } else if (!fireballHit) {
      uploadAchievement(playerId, achievementId, date);
    } else {      
      updateAchievement(nonActive, achievementId);
    }

    achievementId = 5; 
    currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
    if (currentlyAchieved) {
      achieved++;
      updateAchievement(active, achievementId);
    } else if (achieved == 4) {
      uploadAchievement(playerId, achievementId, date);
    } else {      
      updateAchievement(nonActive, achievementId);
    }
  }

  void updateAchievement(int activity, int achievementId) {
    //Indicates whether the achievement is active or not and makes sure it is saved into the achievements table
    database.updateQuery(String.format("UPDATE `achievements` SET `achievements`.`active` = %s WHERE id = %s", activity, achievementId));
  }

  void uploadAchievement(int playerId, int achievementId, String date) {
    //Adds achievement into the playerachievement table in the database
    database.updateQuery(String.format("INSERT INTO playerachievement(player_id, achievement_id, created_on) VALUES('%s','%s','%s')", playerId, achievementId, date));
  }

  Table readPlayerAchievement() {
    //Joins multiple tables, makes sure all variables exist and returns them
    String query = String.format("SELECT  `achievements`.`name`, `playerachievement`.`created_on` FROM `player` inner join playerachievement on `player`.`id` = `playerachievement`.`player_id` inner join achievements on `playerachievement`.`achievement_id` = `achievements`.`id`WHERE `player`.`id` = %s AND `achievements`.`active`= %s  ORDER BY `achievements`.`id` ASC", playerId, active);
    Table output = database.runQuery(query);
    return output;
  }

  boolean achievementAlreadyAchieved(int playerId, int achievementId) { 
    //Reads table, searches for the achievement and returns a true or false value which indicates if it exists
    String query = String.format("SELECT COUNT(*) FROM playerachievement WHERE achievement_id = '%s' AND player_id = '%s'", achievementId, playerId);
    Table output = database.runQuery(query);
    return output.getInt(0, 0) == 1;
  }

}
