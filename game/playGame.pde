class PlayGame {

  boolean commentOverlayEnabled = false;
  CommentOverlay commentOverlay;
  public int distance = 0;
  int currentCommentLoadDistance = 0;
  ArrayList<ScreenComment> screenComments = new ArrayList<ScreenComment>();

  PlayGame() {
      screenComments = new ArrayList<ScreenComment>();
      distance = 0;
      currentCommentLoadDistance = 0;
  }

  void update()
  {

    player.manager = manager;
    player.score = manager.score;
    player.update();
    manager.listener();
    if (manager.speed <= manager.speedCap) {
      manager.speed += Config.CAMERA_SPEED_UP_SPEED;
    }
    manager.speedCap = player.currentArmourSpeedMultiplier;

    distance++;
    if (currentCommentLoadDistance < distance)
    {
      currentCommentLoadDistance = distance + Config.MAX_COMMENT_LOAD_DISTANCE;
      ArrayList<Comment> comments = commentDatabase.getComments(distance, currentCommentLoadDistance);
      if (comments != null)
      {
        for (Comment comment : comments)
        {
          screenComments.add(new ScreenComment(comment));
        }
        println(String.format("Loaded %d comments", screenComments.size()));
      }
    }


    manager.moveGroups();
    enemy.attack();
    enemy.movement();
    enemy.collision();
    TileCollision collision = manager.checkCollision(player.playerPos, player.size);
    player.obstacle = manager.ObstacleCheckCollision(player.playerPos, player.size);
    player.tileCollision = collision; 
    manager.playerLocation(player);

    hud.updateHUD(player.coinAmount, int(player.score), player.currentArmourLevel, player.shieldAmount);
  }

  private void drawScreenComments()
  {
    if (screenComments == null) return;

    ArrayList<ScreenComment> deadComments = new ArrayList<ScreenComment>();

    for (ScreenComment comment : screenComments)
    {
      if (comment.shouldAppear(distance)) 
      {
        comment.appear();
      }
      if (!commentOverlayEnabled) comment.update();
      if(comment.isDead()) deadComments.add(comment);
      comment.draw();
    }

    if(deadComments.size() == 0) return;
    for(ScreenComment comment : deadComments)
    {
      screenComments.remove(comment);
    }
  }

  void draw()
  {
    background(21, 19, 39);
    drawScreenComments();
    manager.drawGroups();
    player.draw();
    enemy.draw();
    enemy.drawAttack();
    hud.draw();
  }
}
