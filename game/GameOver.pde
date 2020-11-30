//Made by Patrick Eikema

class GameOver {
  color backgroundColor;
  float screenTimer, screenCD;
  boolean timeSet;
  ArrayList<TextButton> backButton;
  float backButtonX, backButtonY;
  int fontSizeBackButton;
  float fontSizeYouDied;
  ButtonManager manager;

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
  }



  void screen() {
    //sets the timer to the current millis()
    background(backgroundColor);
    textAlign(CENTER);
    textSize(fontSizeYouDied);
    fill(255, 0, 0);
    text("Sebastian died...", width/2, height/2);



    if (!timeSet) {
      screenTimer = millis();
      timeSet = true;
    }

    if (millis() - screenTimer > screenCD) {
      setup();
      draw();
    }

    backButton.get(0).drawTextButton();
    if (backButton.get(0).selected == true) {
      setup();
      draw();
    }
  }
}
