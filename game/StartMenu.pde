//Made by Patrick Eikema

class StartMenu {
  PImage background;
  //MENU OPTIONS
  float startX, startY;
  float hiscoreX, hiscoreY;
  float quitX, quitY;
  color green;
  color red;
  color white;
  color black;
  int menuFontSize;
  //SOUND STUFF 
  boolean soundIsPlaying;
  PImage soundIconSmall, soundIconBig;
  PImage soundIconSmallMuted, soundIconBigMuted;
  float soundIconX, soundIconY;
  float smallSoundIconW, smallSoundIconH, bigSoundIconW, bigSoundIconH;
  boolean isSoundMuted;
  float sliderX1, sliderX2, sliderY;
  float sliderBallX, sliderBallY, sliderBallR;
  float sliderStrokeWeight;
  float distanceBall;

  ArrayList<TextButton> menuButtons;
  ButtonManager manager;

  StartMenu() {
    background = loadImage("/startMenuBackground.jpg");
    background.resize(displayWidth, displayHeight);

    //MENU OPTIONS
    menuFontSize = 60;
    green = color(0, 255, 100);
    red = color(245, 42, 42);
    white = color(255);
    black = color(0);
    startX = width/2;
    startY = height/2-100;
    hiscoreX = width/2;
    hiscoreY = height/2;
    quitX = width/2;
    quitY = height/2+100;

    //SOUND STUFF
    soundIsPlaying = false;
    soundIconSmall = loadImage("/soundIconSmall.png");
    soundIconBig = loadImage("/soundIconBig.png");
    soundIconSmallMuted = loadImage("/soundIconSmallMuted.png");
    soundIconBigMuted = loadImage("/soundIconBigMuted.png");
    isSoundMuted = false;
    smallSoundIconW = 50;
    smallSoundIconH = 39;
    bigSoundIconW = 55;
    bigSoundIconH = 43;
    soundIconX = 50;
    soundIconY = height-70;
    sliderX1 = soundIconX + 70;
    sliderX2 = sliderX1+200;
    sliderY = soundIconY;
    sliderBallX = sliderX2;
    sliderBallY = sliderY;
    sliderBallR = 20;
    sliderStrokeWeight = 6;
    distanceBall = 1;


    menuButtons = new ArrayList<TextButton>();
    menuButtons.add(new TextButton(startX, startY, "Start", menuFontSize, color(white), color(green), 0));
    menuButtons.add(new TextButton(hiscoreX, hiscoreY, "Hi-Scores", menuFontSize, color(white), color(green), 1));
    menuButtons.add(new TextButton(quitX, quitY, "Quit", menuFontSize, color(white), color(red), 2));
    manager = new ButtonManager(menuButtons);

    // constructor for buttons = float x, float y, String text, int fontSize
  }


  void screen() {
    //Starts the audio
    if (!soundIsPlaying && gameState == "START") { 
      backgroundMusicStartScreen.loop();
      soundIsPlaying = true;
    }  
    manager.indexSelecterMouse();
    manager.indexSelecterKeysVertical();

    //background image
    imageMode(CENTER);
    image(background, width/2, height/2);


    for (int i = 0; i < menuButtons.size(); i++) {
      menuButtons.get(i).drawTextButton();
    }



    //drawing the sound icon, when hovering over it makes it bigger
    if (mouseX > soundIconX - smallSoundIconW/2 && mouseX < soundIconX + smallSoundIconW/2 && mouseY > soundIconY - smallSoundIconH/2 && mouseY < soundIconY + smallSoundIconH/2) {
      if (!isSoundMuted) {
        image(soundIconBig, soundIconX, soundIconY);
      } else {
        image(soundIconBigMuted, soundIconX, soundIconY);
      }
    } else {
      if (isSoundMuted) {
        image(soundIconSmallMuted, soundIconX, soundIconY);
      } else {
        image(soundIconSmall, soundIconX, soundIconY);
      }
    }

    //if hover over sound icon & click, mute it
    if (mouseX > soundIconX - smallSoundIconW/2 && mouseX < soundIconX + smallSoundIconW/2 && mouseY > soundIconY - smallSoundIconH/2 && mouseY < soundIconY + smallSoundIconH/2 && Input.mouseButtonClicked(LEFT)) {
      isSoundMuted = !isSoundMuted;
    }

    if (isSoundMuted) {
      backgroundMusicStartScreen.amp(0.0);
    } else {
      backgroundMusicStartScreen.amp(distanceBall);
    }
  } 

  //checks what option is selected and when pressed ENTER it changes the gamestate of the selected menu option
  void menuSelecter() {


    if ((Input.keyClicked(ENTER) || Input.keyClicked(RETURN)) && gameState == "START")
    {
      for (int i = 0; i < menuButtons.size(); i++) {
        if (menuButtons.get(i).selected == true) {
          switch(menuButtons.get(i).index)
          {
          case 0:
            gameState = "PLAY";
            break;
          case 1:
            gameState = "HISCORE";
            break;
          case 2:
            exit();
            break;
          default:
            println("An error has occurred in StartMenu: menuSelecter()");
            break;
          }
        }
      }
    }
  }


  void audioSlider() {
    distanceBall = (sliderBallX - sliderX1)/100/2;
    if (mouseX > 0 && mouseX < width/5 && mouseY > height/10*9 && mouseY < height) {
      //sliderline
      stroke(white);
      strokeWeight(sliderStrokeWeight);
      line(sliderX1, sliderY, sliderX2, sliderY);
      //sliderball
      strokeWeight(1);
      stroke(white);
      fill(black);
      ellipse(sliderBallX, sliderBallY, sliderBallR, sliderBallR);
    }

    if (Input.mouseButtonPressed(LEFT)) {
      sliderBallX = mouseX;

      //keeps sliderball in bounds
      if (sliderBallX < sliderX1) {
        sliderBallX = sliderX1;
      }
      if (sliderBallX > sliderX2) {
        sliderBallX = sliderX2;
      }
    }
  }
}
