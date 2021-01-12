/*
 * @author Antonio Bottelier
 *
 * Class for creating animations and playing them automatically.
 */
public class Animation {
  private ArrayList<PImage> sprites = new ArrayList<PImage>();
  private int currentImage = 0;
  private int animationSpeed = 10;
  private int animationTime = 0;

  private boolean isSpriteSheet = false;
  private int xCells;
  private int yCells;
  private PImage spriteSheetImage;

  public Animation(String... frames) {
    for (String frame : frames) {
      addImage(frame);
    }
  }

  /*
   * Constructor for creating animation with separate image files
   */
  public Animation(int animationSpeed, String... frames) {
    this(frames);
    this.animationSpeed = animationSpeed;
  }

  /*
   * Constructor for creating an animation with spritesheets.
   */
  public Animation(String fileName, int xCells, int yCells)
  {
    isSpriteSheet = true;
    spriteSheetImage = loadImage(fileName);
    this.xCells = xCells;
    this.yCells = yCells;
  }

  private void drawSpriteSheet(float x, float y, float width, float height)
  {
    int imgWidth = spriteSheetImage.width;
    int imgHeight = spriteSheetImage.height;
    //println(String.format("x: %d y: %d w: %d h: %d", imgWidth/xCells*currentImage+1*currentImage, imgHeight/yCells+1, imgWidth/xCells, imgHeight/yCells));
    PImage spr = spriteSheetImage.get(imgWidth/xCells*currentImage+1*currentImage, 0, imgWidth/xCells, imgHeight/yCells);

    if (width == -1 || height == -1)
      image(spr, x, y);
    else
      image(spr, x, y, width, height);
  }

  private void drawSprite(float x, float y, float width, float height)
  {
    if (width == -1 || height == -1)
      image(sprites.get(currentImage), x, y);
    else
      image(sprites.get(currentImage), x, y, width, height);
  }

  private int getSpriteLength()
  {
    return sprites.size();
  }

  private int getSpriteSheetLength()
  {
    return xCells;
  }

  /*
   * Draws the current frame of the animation.
   *   Also provides optional width and height arguments.
   */
  public void draw(float x, float y, float width, float height) {

    if (isSpriteSheet) drawSpriteSheet(x, y, width, height);
    else drawSprite(x, y, width, height);

    animationTime++;
    boolean newFrame = animationTime > animationSpeed;
    if (newFrame) {
      animationTime = 0;
      currentImage += 1;
      int size = isSpriteSheet ? getSpriteSheetLength() : getSpriteLength();
      if (currentImage >= size) 
        currentImage = 0;
    }
  }

  /*
   * Draws the sprite at the specified location
   */
  public void draw(float x, float y) { 
    draw(x, y, -1, -1);
  }

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

  public int getCurrentImage() {
    return currentImage;
  }
}
