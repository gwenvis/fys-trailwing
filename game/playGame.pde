class PlayGame {

  boolean commentOverlayEnabled = false;
  CommentOverlay commentOverlay;
  int distance = 0;
  int currentCommentLoadDistance = 0;
  ArrayList<ScreenComment> screenComments = new ArrayList<ScreenComment>();

  PlayGame() {
  }

  void update()
  {
    // if the comment overlay is enabled, stop updating the game
    if (commentOverlayEnabled)
    {
      return;
    }

    backgroundMusicStartScreen.stop();
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
        screenComments = new ArrayList<ScreenComment>();
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

    // debug keybind for enabling comment overlay
    if (Input.keyClicked('o'))
    {
      commentOverlayEnabled = true;
    }

    hud.updateHUD(player.coinAmount, int(player.score), player.currentArmourLevel, player.shieldAmount);
  }

  private void drawScreenComments()
  {
    if (screenComments == null) return;

    for (ScreenComment comment : screenComments)
    {
      if (comment.shouldAppear(distance)) 
      {
        comment.appear();
      }
      if (!commentOverlayEnabled) comment.update();
      comment.draw();
    }
  }

  void drawCommentOverlay()
  {
    if (commentOverlay == null) commentOverlay = new CommentOverlay();

    if (commentOverlay.update())
    {
      commentOverlayEnabled = false;
      Comment comment = new Comment(commentOverlay.getCommentInput(), distance); // fill out score
      println("Comment placed: \"" + comment.getContent() + "\" at distance: " + comment.getDistance());
      commentDatabase.addComment(comment);
      commentOverlay = null;
    }
    if (commentOverlay != null) commentOverlay.draw();
  }

  void draw()
  {
    background(255);
    drawScreenComments();
    manager.drawGroups();
    player.draw();
    enemy.draw();
    enemy.drawAttack();
    hud.draw();
  }
}
