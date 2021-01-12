//Made by Patrick Eikema, all comment stuff is made by Anton

class GameOver {
  color backgroundColor, red, white;
  float screenTimer, screenCD;
  boolean timeSet;
  ArrayList<TextButton> backButton;
  float backButtonX, backButtonY;
  int fontSizeBackButton;
  float fontSizeYouDied;
  float commentFontSize = 32;
  ButtonManager manager;

  public boolean drawCommentOverlay = false;
  private CommentOverlay commentOverlay;

  GameOver() {
    this.backgroundColor = color(0);
    this.screenCD = 5400;
    this.timeSet = false;
    backButton = new ArrayList<TextButton>();
    this.backButtonX = width/2+150;
    this.backButtonY = height/2+30;
    this.fontSizeBackButton = 20;
    this.backButton.add(new TextButton(backButtonX, backButtonY, "Back to start", fontSizeBackButton, color(255), color(200), 1));
    this.fontSizeYouDied = 80;
    this.manager = new ButtonManager(backButton);
    this.red = color(255,0,0);
    this.white = color(255);
  }

  void draw() {
    //sets the timer to the current millis()
    background(backgroundColor);
    textAlign(CENTER);
    textSize(fontSizeYouDied);
    fill(red);
    text("Sebastian died...", width/2, height/2);

    fill(white);
    textAlign(LEFT);
    textSize(commentFontSize);
    text("Press 'X' to add a death reaction...", textWidth('_'), height - fontSizeYouDied+fontSizeYouDied/8);

    backButton.get(0).drawTextButton();
  }


  void update()
  {
    if(drawCommentOverlay) return;
    
    //sets timer to eventually reset to start.
    if (!timeSet) {
      screenTimer = millis();
      timeSet = true;
    }
    //if timer is done, restart the game.
    if (millis() - screenTimer > screenCD) {
      setup();
    }
    
    //if X is pressed, give comment overlay.
    if(Input.keyPressed('x'))
    {
      drawCommentOverlay = true;
    }

    if (backButton.get(0).selected == true) {
      setup();
    }
  }

  void drawCommentOverlay()
  {
    if (commentOverlay == null) commentOverlay = new CommentOverlay();
    
    CommentOverlayState state = commentOverlay.update();

    if (state == CommentOverlayState.SUBMITTED)
    {
      drawCommentOverlay = false;
      Comment comment = new Comment(commentOverlay.getCommentInput(), play.distance); // fill out score
      println("Comment placed: \"" + comment.getContent() + "\" at distance: " + comment.getDistance());
      commentDatabase.addComment(comment);
      commentOverlay = null;
    }
    else if(state == CommentOverlayState.DISCARDED)
    {
      drawCommentOverlay = false;
      commentOverlay = null;
    }

    if (commentOverlay != null) commentOverlay.draw();
  }

  
}
