/* 
 * @author Chantal Boodt 
 */

class ParticleSystem {

  // Declaration of variables
  // Public means global variable all classes have access 
  public boolean toRight, draw;
  public String particleID;

  //  Private means only accessible within the declared class 
  private boolean particleDeath;
  private int hitParticleAmount, landDustParticleAmount, fireballParticleAmount;
  private int startingColourR, startingColourG, startingColourB;
  private int endingColourR, endingColourG, endingColourB;
  private float particleSystemStartX, particleSystemStartY;

  //Initialization of arraylist particles 
  ArrayList<Particle> particles = new ArrayList<Particle>();

  /* 
   * Creates an arraylist of designated particle
   * Draws arraylist
   */
  ParticleSystem(String id, int startColourR, int startColourG, int startColourB, int endColourR, int endColourG, int endColourB, float startX, float startY, boolean ToRight) {
    //constructer
    hitParticleAmount = Config.HIT_PARTICLE_AMOUNT;
    landDustParticleAmount = Config.LANDDUST_PARTICLE_AMOUNT;
    fireballParticleAmount = Config.FIREBALL_PARTICLE_AMOUNT;

    particleID = id;
    toRight = ToRight;

    startingColourR = startColourR;
    startingColourG = startColourG;
    startingColourB = startColourB;
    endingColourR = endColourR;
    endingColourG = endColourG;
    endingColourB = endColourB;

    particleSystemStartX = startX;
    particleSystemStartY = startY;
    particleDeath = false;

    if (particleID == "Hit") {
      for (int i = 0; i < hitParticleAmount; i++) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), false));
      }
    }

    if (particleID == "LandDust") {
      for (int i = 0; i < landDustParticleAmount; i++) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), false));
      }
    }
  }

  /* 
   * Adds particles to array list
   * Activates movement of all particles in the arraylist
   * Draws all particles in the arraylist
   */
  void draw() {
    update();

    if ( particleID == "Fireball") {
      //Adds new particles to the arraylist
      for (int i = 0; i < fireballParticleAmount; i++) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
      }

      for (Particle particle : particles) { 
        //Moves and displays all particles in the arraylist       
        particle.fireballMove();
        particle.display();
      }
    }

    if (particleID == "Hit") {
      if (draw) {
        for (int i = 0; i < hitParticleAmount; i++) {
          //Adds new particles to arraylist
          particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
        }
      }

      for (Particle particle : particles) {  
        //Moves and displays all particles in the arraylist       
        particle.hitMove();
        particle.display();
      }
    }

    if (particleID == "RunDust") {
      if (draw) {
        //Adds new particles to arraylist
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
      } 
      for (Particle particle : particles) {  
        //Moves and displays all particles in the arraylist       
        particle.runDustMove();
        particle.display();
      }
    }

    if (particleID == "LandDust") {
      if (draw) {
        //Adds new particles to arraylist
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
      }

      for (Particle particle : particles) {   
        //Moves and displays all particles in the arraylist      
        particle.landDustMove();
        particle.display();
      }
    }
  }

  /* 
   * Checks if all particles in the list are visible
   * Removes particles if not visible
   */
  public void update() {
    for (int i = particles.size()-1; i>= 0; i--) {
      Particle particle = particles.get(i);
      particleDeath = particle.death();
      if (particleDeath) {
        particles.remove(i);
      }
    }
  }
}
