class PlayGame {
 PlayGame(){
   
 }
 
 
 void playGame(){
  backgroundMusicStartScreen.stop();
  background(255);
  player.manager = manager;
  player.init();
  manager.listener();
  if (manager.speed <= manager.speedCap) {
    manager.speed += Config.CAMERA_SPEED_UP_SPEED;
  }
  manager.speedCap = player.currentArmourSpeedMultiplier;

  manager.moveGroups();
  manager.drawGroups();

  enemy.attack();
  enemy.collision();
  enemy.draw();
  enemy.movement();

  //print(manager.ObstacleCheckCollision(player.playerPos, new PVector(100, 100)));
  TileCollision collision = manager.checkCollision(player.playerPos, player.size);
  //print(collision.direction);
  //print("\n");
  player.obstacle = manager.ObstacleCheckCollision(player.playerPos, player.size);
  player.tileCollision = collision; 

 }
}
