float imageX = 0;
float cloudX = 0;
float caveX = 0;

class Parallux {

  void background() {
    image(sky, 0, 0);
    image(backgroundImage, imageX, 0);
    image(clouds, cloudX, 0);
  }

  void init() {
    if (imageX <= 0) {
      image(backgroundImage, imageX+backgroundImage.width, 0);
      if (imageX == -3840) {
        imageX=0;
      }
    }
    imageX = imageX - 0.5;

    if (cloudX <= 0) {
      image(clouds, cloudX+clouds.width, 0);
      if (cloudX == -1920) {
        cloudX=0;
      }
    }
    cloudX = cloudX - 2;
  }
  
  void setCave() {
    image(cave, caveX, 0);
  }
  
  void cave() {
    if (caveX <= 0) {
      image(cave, caveX+cave.width, 0);
      if (caveX == -1920) {
        caveX=0;
      }
    }
    caveX = caveX - 0.5;
  }
}
