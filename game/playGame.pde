class PlayGame {
  PImage background, clouds, landscape, cave;
  boolean commentOverlayEnabled = false;
  CommentOverlay commentOverlay;
  public int distance = 0;
  int currentCommentLoadDistance = 0;
  ArrayList<ScreenComment> screenComments = new ArrayList<ScreenComment>();
  float x1, x2;

  SessionDatabase highscoredb;
  Session session;

  PlayGame() {
    screenComments = new ArrayList<ScreenComment>();
    distance = 0;
    currentCommentLoadDistance = 0;
    x1 = 0;
    x2 = width;

    landscape = loadImage("landscape.png");
    cave = loadImage("caveBackground.png");
    clouds = loadImage("clouds.png");
  }

  void createSession()
  {
    highscoredb = new SessionDatabase();
    Session newSession = new Session(0, 0, 0, "00:00", year() + "/" + month() + "/" + day(), playerdb.id, "");   

    player.session = highscoredb.addSession(newSession);
  }

  void update()
  {

    //updates important variables
    player.manager = manager;
    player.score = manager.score;
    player.update();
    manager.listener();

    //make the player faster if movement cap is higher
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


    move();

    hud.updateHUD(player.coinAmount, int(player.score), player.currentArmourLevel, player.shieldAmount);
  }

  /**
   * handles movement and collision
   */
  void move() {
    manager.moveGroups();
    enemy.attack();
    enemy.movement(player.playerPos.y);
    enemy.collision();
    TileCollision collision = manager.checkCollision(player.playerPos, player.size);
    player.obstacle = manager.ObstacleCheckCollision(player.playerPos, player.size);
    player.tileCollision = collision; 
    manager.playerLocation(player);
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
      if (comment.isDead()) deadComments.add(comment);
      comment.draw();
    }

    if (deadComments.size() == 0) return;
    for (ScreenComment comment : deadComments)
    {
      screenComments.remove(comment);
    }
  }

  void backgroundManager() {
    if (manager.chunkpool == 0) {
      background = clouds;
    } else if (manager.chunkpool == 1) {
      background = landscape;
    } else if (manager.chunkpool == 2) {
      background = cave;
    }



    imageMode(CORNER);

    image(background, x1, 0, width, height);
    image(background, x2, 0, width, height);
    x1-=2;
    x2-=2;
    if (x1 + width < 0) {
      x1 = width;
    } else if (x2 + width < 0 ) {
      x2 = width;
    }
  }

  void draw()
  {
    backgroundManager();
    drawScreenComments();
    manager.drawGroups();
    player.draw();
    enemy.draw();
    enemy.drawAttack();
    hud.draw();
  }
}
