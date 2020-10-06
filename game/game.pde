TileManager manager;

void setup() {
  size(1920, 1080);

  manager = new TileManager(10);
}

void draw()
{
  background(255);
  Input.update();

  manager.listener();
  manager.moveGroups();
  manager.drawGroups();
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
