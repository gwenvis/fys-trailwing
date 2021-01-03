class AchievementsDatabase {  
  Database database;
  int playerId, achievementId, active;
  boolean currentlyAchieved;

  AchievementsDatabase() {
    currentlyAchieved = false;
    database = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");
  }


  void achievementCheck(int distance, int coinsTotal, int level, boolean fireballHit) {
    int achieved = 0;
    playerId = lastPlayer();

    if (distance > 500) {
      achievementId = 1;
      currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
      if (currentlyAchieved) {
      } else {
        achieved++;
        uploadAchievement(playerId, achievementId, 1);
        //database.updateQuery(String.format("INSERT INTO achieved_achievements(String query = String.format(SELECT `player`.`id`, `achieved_achievements`.`id`, `achievements`.`active` FROM `player` inner join achieved_achievements on `player`.`id` = `achieved_achievements`.`player_id` inner join achievements on `achieved_achievements`.`achievement_id` = `achievements`.`id` WHERE `achievements`.`active` = 1 "));
      }
    }
    if (coinsTotal > 15) {
      achievementId = 2;      
      currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
      uploadAchievement(playerId, achievementId, 1);

      achieved++;
    }

    if (level ==  Config.MAX_CHUNCK_LEVEL) {
      achievementId = 3;      
      currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);        
      uploadAchievement(playerId, achievementId, 1);

      achieved++;
    }

    if (!fireballHit) {
      achievementId = 4;      
      currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);        
      uploadAchievement(playerId, achievementId, 1);
      achieved++;
    }

    if (achieved == 4) {
      achievementId = 5;      
      currentlyAchieved = achievementAlreadyAchieved(playerId, achievementId);
      uploadAchievement(playerId, achievementId, 1);
    }
  }
  void uploadAchievement(int playerId, int achievementId, int active) {
    database.updateQuery(String.format("INSERT INTO achieved_achievements(player_id, achievement_id, achievement_active) VALUES('%s','%s')", playerId, achievementId, active));
  }

  boolean achievementAlreadyAchieved(int playerId, int achievementId) { 
    String query = String.format("SELECT achievement_Id, player_Id FROM achieved_achievements WHERE achievement_id = '%s' AND player_id = '%s'", achievementId, playerId);

    //String query = String.format("SELECT `player`.`id`, `achieved_achievements`.`id`, `achievements`.`active` FROM `player` inner join achieved_achievements on `player`.`id` = `achieved_achievements`.`player_id` inner join achievements on `achieved_achievements`.`achievement_id` = `achievements`.`id` WHERE `player`.`id` = %s AND `achievements`.`id`= %s ", playerId, achievementId);
    Table output = database.runQuery(query);
    return output.getInt(0, 0) == 1;
  }

  int lastPlayer() {
    String query = String.format("SELECT MAX(id) FROM `player`");
    Table output = database.runQuery(query);
    playerId = output.getInt(0, 0);
    return playerId;
  }
}
