class StartMenu {
  PImage background;
  float x;
  float x2;
  float w;
  color fillStart;
  color fillQuit;
  color fillHiScore;
  int indexSelecter;
  boolean soundIsPlaying;
  PImage soundIconSmall, soundIconBig;
  PImage soundIconSmallMuted, soundIconBigMuted;
  boolean isSoundMuted;

  StartMenu() {
    background = loadImage("/startMenuBackground.jpg");
    background.resize(displayWidth, displayHeight);
    fillStart = color(0, 255, 100);
    fillQuit = color(255);
    fillHiScore = color(255);
    indexSelecter = 0;
    soundIsPlaying = false;
    soundIconSmall = loadImage("/soundIconSmall.png");
    soundIconBig = loadImage("/soundIconBig.png");
    soundIconSmallMuted = loadImage("/soundIconSmallMuted.png");
    soundIconBigMuted = loadImage("/soundIconBigMuted.png");
    isSoundMuted = false;
  }


  void screen() {
    //Starts the audio
    if (!soundIsPlaying && gameState == "START") { 
      backgroundMusicStartScreen.loop();
      soundIsPlaying = true;
    }  
    
    

    //background image
    imageMode(CENTER);
    image(background, width/2, height/2);

    //draws the start or quit menu options
    textSize(60);
    textAlign(CENTER);
    fill(fillStart);
    text("Start", width/2, height/2-100); 
    fill(fillHiScore);
    text("Hi-Scores", width/2, height/2);
    fill(fillQuit);
    text("Quit", width/2, height/2+100);

    //Audio icon
    if (mouseX > 50-45/2 && mouseX < 50 + 45/2 && mouseY > height-60-45/2 && mouseY < height-60+45/2) {
      if (!isSoundMuted) {
        image(soundIconBig, 50, height-70);
      } else {
        image(soundIconBigMuted, 50,height-70);
      }
    } else {
      if (isSoundMuted) {
        image(soundIconSmallMuted, 50, height-70);
      } else {
        image(soundIconSmall, 50, height-70);
      }
    }
    
    if(mouseX > 50-45/2 && mouseX < 50 + 45/2 && mouseY > height-60-45/2 && mouseY < height-60+45/2 && Input.mouseButtonClicked(LEFT)){
     isSoundMuted = !isSoundMuted;
    }
    
    if(isSoundMuted){
     backgroundMusicStartScreen.amp(0.0);
    } else {
     backgroundMusicStartScreen.amp(1.0); 
    } 
  } 


  void keyPress() {
    if (keyCode == ENTER && gameState == "START" && indexSelecter == 0) {
      gameState = "PLAY";
    } else if (keyCode == ENTER && gameState == "START" && indexSelecter == 1) {
      gameState = "HISCORE";
    } else if (keyCode == ENTER && gameState == "START" && indexSelecter == 2) {
      exit();
    }
  }


  void menuSelecter() {

    if (Input.keyClicked('s'))
    {
      if (indexSelecter < 2) {
        indexSelecter += 1;
      }
    } else if (Input.keyClicked('w')) {
      if (indexSelecter > 0) {
        indexSelecter -= 1;
      }
    }

    if (indexSelecter == 0) {
      fillStart = color(0, 255, 100);
    } else {
      fillStart = color(255);
    }

    if (indexSelecter == 1) {
      fillHiScore = color(0, 255, 100);
    } else {
      fillHiScore = color(255);
    }

    if (indexSelecter == 2) {
      fillQuit = color(245, 42, 42);
    } else {

      fillQuit = color(255);
    }
  }
}
