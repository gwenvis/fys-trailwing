public class Animation {
  private ArrayList<PImage> sprites = new ArrayList<PImage>();
  private int currentImage = 0;
  private int animationSpeed = 10;
  private int animationTime = 0;

  public Animation(String... frames) {
    for(String frame : frames) {
      addImage(frame);
    }
  }
  
  public Animation(int animationSpeed, String... frames) {
    this(frames);
    this.animationSpeed = animationSpeed;
  }

  /*
   * Draws the current frame of the animation.
   *   Also provides optional width and height arguments.
   */
  public void draw(float x, float y, float width, float height) {
    if(width == -1 || height == -1)
      image(sprites.get(currentImage), x, y);
    else
      image(sprites.get(currentImage), x, y, width, height);

    animationTime++;
    boolean newFrame = animationTime > animationSpeed;
    if(newFrame) {
      animationTime = 0;
      currentImage += 1;
      if(currentImage >= sprites.size())
        currentImage = 0;
    }
  }

  public void draw(float x, float y) { draw(x,y,-1,-1); }

  /*
   * Sets the animation speed (in frames)
   */
  public void setAnimationSpeed(int animationSpeed) {
    this.animationSpeed = animationSpeed;
  }

  /*
   * Loads and adds an image
   */
  public void addImage(String imageName) {
    sprites.add(loadImage(imageName));
  }

  /* 
   * Adds an image to the animation directly
   */
  public void addImage(PImage image) {
    sprites.add(image);
  }
}
