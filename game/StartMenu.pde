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
  float sliderMaxShowLocX, sliderMaxSHowLocY;
  float sliderStrokeWeight;
  float distanceBall;
  PFont font;


  ArrayList<TextButton> menuButtons;
  ButtonManager manager;


  //for good practice, I should put the global variables like displayWidth, displayHeight, width, height in the constructor.
  StartMenu() {
    this.background = loadImage("./startMenuBackground.jpg");
    this.background.resize(displayWidth, displayHeight);

    //MENU OPTIONS
    this.menuFontSize = 50;
    this.green = color(0, 255, 100);
    this.red = color(245, 42, 42);
    this.white = color(255);
    this.black = color(0);
    this.startX = width/2;
    this.startY = height/2-100;
    this.hiscoreX = width/2;
    this.hiscoreY = height/2;
    this.quitX = width/2;
    this.quitY = height/2+100;
    this.font = createFont("Arial", 64);

    //SOUND STUFF
    this.soundIsPlaying = false;
    this.soundIconSmall = loadImage("soundIconSmall.png");
    this.soundIconBig = loadImage("soundIconBig.png");
    this.soundIconSmallMuted = loadImage("soundIconSmallMuted.png");
    this.soundIconBigMuted = loadImage("soundIconBigMuted.png");
    this.isSoundMuted = false;
    this.smallSoundIconW = 50;
    this.smallSoundIconH = 39;
    this.bigSoundIconW = 55;
    this.bigSoundIconH = 43;
    this.soundIconX = 50;
    this.soundIconY = height-70;
    this.sliderX1 = soundIconX + 70;
    this.sliderX2 = sliderX1+200;
    this.sliderY = soundIconY;
    this.sliderBallX = sliderX2;
    this.sliderBallY = sliderY;
    this.sliderBallR = 20;
    this.sliderMaxShowLocX = width/5;
    this.sliderMaxSHowLocY =  height/10*9;
    this.sliderStrokeWeight = 6;
    this.distanceBall = 1;

    // constructor for buttons = float x, float y, String text, int fontSize
    menuButtons = new ArrayList<TextButton>();
    menuButtons.add(new TextButton(startX, startY, "Start", menuFontSize, color(white), color(green), 0));
    menuButtons.add(new TextButton(hiscoreX, hiscoreY, "Hi-Scores", menuFontSize, color(white), color(green), 1));
    menuButtons.add(new TextButton(quitX, quitY, "Quit", menuFontSize, color(white), color(red), 2));

    this.manager = new ButtonManager(menuButtons);
  }


  void screen() {

    //manages button sellection
    manager.indexSelecterMouse();
    manager.indexSelecterKeysVertical();

    //background image
    imageMode(CENTER);
    image(background, width/2, height/2);

    //draws buttons
    textFont(font);
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
      musicManager.setVolume(0.0);
    } else {
      musicManager.setVolume(distanceBall);
    }
  } 

  //checks what option is selected and when pressed ENTER it changes the gamestate of the selected menu option
  void menuSelecter() {


    if ((Input.keyClicked('z') || Input.keyClicked('Z')) && gameState == "START") {
      soundBank.playSound(SoundType.BUTTON_SELECT);
      for (int i = 0; i < menuButtons.size(); i++) {
        if (menuButtons.get(i).selected) {
          switch(menuButtons.get(i).index)
          {
          case 0:
            gameState = "BUTTONLAYOUT";
            break;
          case 1:          
            hiscore.updateAchievement();
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

  //makes a clickable audio slider.
  void audioSlider() {
    //LEFT and RIGHT key makes sound lower or higher amp
    if (Input.keyCodeClicked(LEFT)) 
    {
      sliderBallX -= 10;
      if (sliderBallX < sliderX1) sliderBallX = sliderX1;
    } else if (Input.keyCodeClicked(RIGHT))
    {
      sliderBallX += 10;
      if (sliderBallX > sliderX2) sliderBallX = sliderX2;
    }


    //makes the actual slider.
    distanceBall = (sliderBallX - sliderX1)/100/2;
    boolean showSlider = mouseX > 0 && mouseX < sliderMaxShowLocX && mouseY > sliderMaxSHowLocY && mouseY < height;
    if (showSlider) {
      //sliderline
      stroke(white);
      strokeWeight(sliderStrokeWeight);
      line(sliderX1, sliderY, sliderX2, sliderY);
      //sliderball
      strokeWeight(1);
      stroke(white);
      fill(black);
      ellipse(sliderBallX, sliderBallY, sliderBallR, sliderBallR);

      //if mouse button pressed, ball follows the mouse
      if (Input.mouseButtonPressed(LEFT) && showSlider) {
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
}
