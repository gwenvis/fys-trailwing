IScreen currentScreen;

void setup() {
  background(255);
  fullScreen();
  frameRate(60);
  switchScreen(new MainMenuScreen());
  smooth();
}

void draw() {
  currentScreen.draw();
  Input.update();
}

void switchScreen(IScreen screen) {
  if(currentScreen != null) {
    currentScreen.destroy();
  }

  currentScreen = screen;
  currentScreen.setup();
}

void keyPressed() {
  //send pressed key to input class
  Input.keyPressed(key, CODED, keyCode);
  if(key == ESC) key = 0;
}

void keyReleased() {
  //send released key to input class
  Input.keyReleased(key, CODED, keyCode);
  if(key == ESC) key = 0;
}

void mousePressed() {
  //send pressed mouseside to input class
  Input.mousePressed(mouseButton);
}

void mouseReleased() {
  //send released mouseside to input class
  Input.mouseReleased(mouseButton);
}
