/* Made by Chantal Boodt */

class Particle {
  String particleID;
  boolean xAxisDir;
  float particleX1, particleY1, particleX2, particleY2, particleX3, particleY3, particleX4, particleY4, angleCalc, particleSpeed, particleDirection, alphaVisibility, visibilityCalc, hitSpeed, hitSizeCorrector, gravity, stopX;
  int beginColourR, beginColourG, beginColourB, finalColourR, finalColourG, finalColourB, colourDifR, colourDifG, colourDifB, fireHeightCorrector, speedCorrector;

  Particle(String id, int startColourR, int startColourG, int startColourB, int endColourR, int endColourG, int endColourB, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, float direction, boolean ToRight) {
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
    particleSpeed = -2.5;

    gravity = 1.2;

    hitSizeCorrector = 5;
    speedCorrector = 2;

    hitSpeed = 1.0;
    alphaVisibility = 255;
    visibilityCalc = alphaVisibility/32;

    beginColourR = startColourR;
    beginColourG = startColourG;
    beginColourB = startColourB;
    finalColourR = endColourR;
    finalColourG = endColourG;
    finalColourB = endColourB;

    fireHeightCorrector = 1;

    colourDifR = (beginColourR - finalColourR)/25;
    colourDifG = (beginColourG - finalColourG)/25;
    colourDifB = (beginColourB - finalColourB)/25;

    angleCalc = PI/3;

    if (particleID == "RunDust") {
      alphaVisibility = alphaVisibility/2;
      visibilityCalc = alphaVisibility/30;
      if (particleDirection > 0) {
        particleDirection = runDustDirection(particleDirection);
      }

      if (xAxisDir) {
        particleSpeed *= -1;
      }
    }

    if (particleID == "Hit") {
      if (xAxisDir) {        
        particleSpeed *= -1;
      }
    }

    if (particleID == "LandDust") {
      particleSpeed = 0.05;
    }
  }

  void display() {
    noStroke();      
    fill(beginColourR, beginColourG, beginColourB, alphaVisibility);

    alphaVisibility -= visibilityCalc;

    beginColourR -= colourDifR;
    beginColourG -= colourDifG;
    beginColourB -= colourDifB;

    if (particleID == "Fireball" || particleID == "RunDust" || particleID == "LandDust") {
      quad(particleX1, particleY1, particleX2, particleY2, particleX3, particleY3, particleX4, particleY4);
    }

    if (particleID == "Hit") {
      triangle(particleX1, particleY1, particleX2 + hitSizeCorrector, particleY2, particleX3, particleY3);
    }
  }

  void fireballMove() {
    angleCalc -= 0.06;

    particleY1 += particleSpeed + fireHeightCorrector;
    particleX1 += (particleDirection * speedCorrector) * sin(angleCalc);
    particleY2 += particleSpeed + fireHeightCorrector;
    particleX2 += (particleDirection * speedCorrector)  * sin(angleCalc);
    particleY3 += particleSpeed + fireHeightCorrector;
    particleX3 += (particleDirection * speedCorrector)  * sin(angleCalc);
    particleY4 += particleSpeed + fireHeightCorrector;
    particleX4 += (particleDirection * speedCorrector)  * sin(angleCalc);
  }

  void hitMove() {
    angleCalc -= 0.06;
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

  void runDustMove() {   
    particleY1 += particleDirection;
    particleX1 += particleSpeed;
    particleY2 += particleDirection;
    particleX2 += particleSpeed;
    particleY3 += particleDirection;
    particleX3 += particleSpeed;
    particleY4 += particleDirection;
    particleX4 += particleSpeed;
  }

  void landDustMove() {
    particleY1 += particleSpeed;
    particleX1 += particleDirection;
    particleY2 += particleSpeed;
    particleX2 += particleDirection;
    particleY3 += particleSpeed;
    particleX3 += particleDirection;
    particleY4 += particleSpeed;
    particleX4 += particleDirection;
  }

  float runDustDirection(float negativeDirection) {
    float ReturnDirection;
    ReturnDirection = negativeDirection * -1;
    return ReturnDirection;
  }

  boolean death() {
    if (alphaVisibility <= 0) {
      return true;
    } else { 
      return false;
    }
  }
}
