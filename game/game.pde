void setup() {
  size(800, 600);
}

void draw()
{
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
