void setup() {
  size(800, 600);
}

int score = 0;

void draw()
{
  float r = Input.keyCodePressed(UP) ? 255 : 0;
  float g = Input.mouseButtonPressed(LEFT) ? 255 : 0;
  float b = Input.keyPressed('w') ? 255 : 0;

  if(Input.keyClicked('a')) score++;
  
  background(r,g,b); 
  textSize(32);
  text("Presses: " + score, 10, 30);

  Input.update();
}

void keyPressed() {
  Input.keyPressed(key, CODED, keyCode);
}

void keyReleased() {
  Input.keyReleased(key, CODED, keyCode);
}

void mousePressed() {
  Input.mousePressed(mouseButton);
}

void mouseReleased() {
  Input.mouseReleased(mouseButton);
}
