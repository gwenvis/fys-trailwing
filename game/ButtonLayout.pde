class ButtonLayout {
  float text1X, text1Y, text2X, text2Y, keyboardX, keyboardY;
  int textSize, textSizeSkip;
  color bgcolor;
  color textColor;
  PImage keyboard;
  float timer, timercd;
  boolean timerSet;
  int alpha, completelyVisible, alphaFadeSpeed;
  float alphaTimer, alphaCD;
  boolean firstAlphaSet;


  ButtonLayout() {
    this.text1X = width/2;
    this.text1Y = height/12;
    this.text2X = width/2;
    this.text2Y = height/10*9.5;
    this.textSize = 50;
    this.textSizeSkip = 20;
    this.bgcolor = color(255);
    this.textColor = color(0);
    this.keyboard = loadImage("control_scheme.png");
    this.keyboardX = width/2;
    this.keyboardY = height/2;
    this.timer = 0;
    this.timercd = 9000;
    this.timerSet = false;
    this.alphaTimer = 0;
    this.alphaCD = 7000;
    this.alpha = 0;
    this.alphaFadeSpeed = 5;
    this.firstAlphaSet = false;
    this.completelyVisible = 250;
  }

  void draw() {
    
    //makes the layout visible at first. 
    if (alpha <= completelyVisible && !firstAlphaSet) {
      alpha += alphaFadeSpeed;
    } else {
      firstAlphaSet = true;
    }

    //sets a timer. after 7 seconds it makes the layout invisible again. after 9 seconds starts the game. 
    if (!timerSet) {
      timer = millis();
      alphaTimer = millis();
      timerSet = true;
    }

    background(bgcolor);
    fill(textColor, alpha);
    textAlign(CENTER);
    textSize(textSize);
    text("Button Layout", text1X, text1Y);
    imageMode(CENTER);
    tint(255, alpha);
    image(keyboard, keyboardX, keyboardY);
    textSize(textSizeSkip);
    text("Press SPACE to skip", text2X, text2Y);
    
    //if alpha timer done, makes the layout invisible.
    if (millis()-alphaTimer > alphaCD) {
      alpha -= 3;
    }

   //if game timr is done, starts the game.
    if (millis()-timer > timercd) {
      noTint();
      gameState = "PLAY";
    }
  }
  
  //if space is clicked, starts the game.
  void spaceCheck() {
    if (Input.keyClicked(' ')) {
      noTint();
      gameState = "PLAY";
    }
  }
}
