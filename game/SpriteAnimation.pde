// Spritesheet class to draw sprite animations
class SpriteAnimation {

  // The image containing the frames and the image to draw
  PImage sourceImage;
  PImage[] frameImage;

  int fps;
  int frame = 0;
  int frameW, frameH;
  int nFrames = 0;
  //int x, y;

  // Contructor takes name of source image and the amount of frames 
  SpriteAnimation(String imageName, int nFrames, int fps) {
    this.fps = fps;
    sourceImage = loadImage(imageName);
    this.nFrames = nFrames;
    frameW = sourceImage.width/nFrames;
    frameH = sourceImage.height;

    //now, FILL the array with parts FROM sourceImage
    frameImage = new PImage[nFrames];
    for (int i = 0; i < nFrames; i++) {
      frameImage[i] = sourceImage.get(i * frameW, 0, frameW, sourceImage.height);
    }
  }


  // draw the target image
  void draw(float x, float y) {
    if ((frameCount % fps) == 0)    
      frame =  (frame + 1) % nFrames;

    image(frameImage[frame], x, y);
  }
}
