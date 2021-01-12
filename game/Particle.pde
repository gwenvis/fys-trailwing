/* 
 * @author Chantal Boodt 
 */

class Particle {
  //Declaration of variables
  private String particleID;

  //All variables to do with movement + direction
  private boolean xAxisDir;
  private int fireHeightCorrector, speedCorrector, directionChange;
  private int alphaVisibilityCalculator, visibilityCalculator, zero;
  private float landDustSpeed;
  private float particleX1, particleX2, particleX3, particleX4;
  private float particleY1, particleY2, particleY3, particleY4;
  private float angleCalc, particleSpeed, angleChange;
  private float particleDirection, hitSpeed, hitSizeCorrector, gravity;
  private float alphaVisibility, visibilityCalc;

  //All variables to do with colours
  private int beginColourR, beginColourG, beginColourB;
  private int finalColourR, finalColourG, finalColourB;
  private int colourDifR, colourDifG, colourDifB;

  /*
   * Constructor
   *
   * Id
   * RGB values 
   * X-coordinates and y-coordinates
   * Initial direction particles (to the left if false)
   * Move to the right?
   */
  Particle(String id, int startColourR, int startColourG, int startColourB, int endColourR, int endColourG, int endColourB, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, float direction, boolean ToRight) {

    // Declaration of variables    
    particleID = id;
    particleX1 = x1;
    particleY1 = y1;
    particleX2 = x2;
    particleY2 = y2;
    particleX3 = x3;
    particleY3 = y3;
    particleX4 = x4;
    particleY4 = y4;

    xAxisDir = ToRight;
    particleDirection = direction;

    //Taking value from static class Config
    gravity = Config.GRAVITY;
    particleSpeed = Config.START_SPEED;
    landDustSpeed = Config.LAND_DUST_SPEED;

    zero = Config.ZERO;
    alphaVisibility = Config.ALPHA_VISIBILITY_START;
    alphaVisibilityCalculator = Config.ALPHA_VISIBILITY_CALCULATOR;
    visibilityCalculator = Config.VISIBILITY_CALCULATOR;

    hitSizeCorrector = Config.HIT_SIZE_CORRECTOR;
    speedCorrector = Config.SPEED_CORRECTOR;
    hitSpeed = Config.HIT_SPEED_CORRECTOR;
    fireHeightCorrector = Config.FIRE_HEIGHT_CORRECTOR;

    angleChange = Config.ANGLE_CHANGE;
    directionChange = Config.DIRECTION_CHANGE;

    //Taking values from static class Config
    //Calculating value
    visibilityCalc = alphaVisibility/Config.VISIBILITY_START_CALCULATOR;
    angleCalc = PI/Config.ANGLE_CALC;


    beginColourR = startColourR;
    beginColourG = startColourG;
    beginColourB = startColourB;
    finalColourR = endColourR;
    finalColourG = endColourG;
    finalColourB = endColourB;

    //Taking values from static class Config
    //Calculating value
    colourDifR = (beginColourR - finalColourR)/Config.COLOURDIF_CALCULATOR;
    colourDifG = (beginColourG - finalColourG)/Config.COLOURDIF_CALCULATOR;
    colourDifB = (beginColourB - finalColourB)/Config.COLOURDIF_CALCULATOR;

    //When particleID equals "RunDust" check direction
    //Checks if particles move in only one direction
    if (particleID == "RunDust") {
      alphaVisibility = alphaVisibility/alphaVisibilityCalculator;
      visibilityCalc = alphaVisibility/visibilityCalculator;
      if (particleDirection > zero) {
        //Changes direction of all particles going in the wrong direction
        particleDirection = runDustDirection(particleDirection);
      }
      //Change direction of all particles
      if (xAxisDir) {
        particleSpeed *= directionChange;
      }
    }

    //When particleID equals "Hit" check direction
    // Change direction of all particles
    if (particleID == "Hit") {
      if (xAxisDir) {        
        particleSpeed *= directionChange;
      }
    }

    // When particleID equals "LandDust" check direction
    // Change movement speed of all particles
    if (particleID == "LandDust") {
      particleSpeed = landDustSpeed;
    }
  }

  /*
   * Calculating visibility (individal color)
   * Calculating new colour 
   * Draw all particles (individual movement)
   */
  public void display() {
    noStroke();      
    fill(beginColourR, beginColourG, beginColourB, alphaVisibility);

    alphaVisibility -= visibilityCalc;

    beginColourR -= colourDifR;
    beginColourG -= colourDifG;
    beginColourB -= colourDifB;

    // Particle shape differs per ID
    if (particleID == "Fireball" || particleID == "RunDust" || particleID == "LandDust") {
      quad(particleX1, particleY1, particleX2, particleY2, particleX3, particleY3, particleX4, particleY4);
    }

    if (particleID == "Hit") {
      triangle(particleX1, particleY1, particleX2 + hitSizeCorrector, particleY2, particleX3, particleY3);
    }
  }

  /*
   * Particle movement if id = "Fireball"
   */
  public void fireballMove() {
    angleCalc -= angleChange;

    particleY1 += particleSpeed + fireHeightCorrector;
    particleX1 += (particleDirection * speedCorrector) * sin(angleCalc);
    particleY2 += particleSpeed + fireHeightCorrector;
    particleX2 += (particleDirection * speedCorrector)  * sin(angleCalc);
    particleY3 += particleSpeed + fireHeightCorrector;
    particleX3 += (particleDirection * speedCorrector)  * sin(angleCalc);
    particleY4 += particleSpeed + fireHeightCorrector;
    particleX4 += (particleDirection * speedCorrector)  * sin(angleCalc);
  }

  /*
   * Particle movement if id = "Hit"
   */
  public void hitMove() {
    angleCalc -= angleChange;
    alphaVisibility -= visibilityCalc;

    particleY1 += (particleDirection * speedCorrector) * sin(angleCalc) + gravity;
    particleX1 += (particleSpeed + hitSpeed);
    particleY2 += (particleDirection * speedCorrector) * sin(angleCalc) + gravity;
    particleX2 += (particleSpeed + hitSpeed);
    particleY3 += (particleDirection * speedCorrector) * sin(angleCalc) + gravity;
    particleX3 += (particleSpeed + hitSpeed);
    particleY4 += (particleDirection * speedCorrector) * sin(angleCalc) + gravity;
    particleX4 += (particleSpeed + hitSpeed);
  }

  /*
   * Particle movement if id = "RunDust"
   */
  public void runDustMove() {   
    particleY1 += particleDirection;
    particleX1 += particleSpeed;
    particleY2 += particleDirection;
    particleX2 += particleSpeed;
    particleY3 += particleDirection;
    particleX3 += particleSpeed;
    particleY4 += particleDirection;
    particleX4 += particleSpeed;
  }

  /*
   * Particle movement if id = "LandDust"
   */
  public void landDustMove() {
    particleY1 += particleSpeed;
    particleX1 += particleDirection;
    particleY2 += particleSpeed;
    particleX2 += particleDirection;
    particleY3 += particleSpeed;
    particleX3 += particleDirection;
    particleY4 += particleSpeed;
    particleX4 += particleDirection;
  }

  /*
   * Changes direction of particle
   */
  private float runDustDirection(float negativeDirection) {
    float ReturnDirection;
    ReturnDirection = negativeDirection * directionChange;
    return ReturnDirection;
  }

  /*
   * Checks if particle is visible
   */
  public boolean death() {
    if (alphaVisibility <= zero) {
      return true;
    } else { 
      return false;
    }
  }
}
