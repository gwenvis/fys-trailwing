/* Made by Chantal Boodt */

class ParticleSystem {
  String particleID;
  int startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB;
  float particleSystemStartX, particleSystemStartY;
  boolean particleDeath, toRight, draw;

  ArrayList<Particle> particles = new ArrayList<Particle>();

  ParticleSystem(String id, int startColourR, int startColourG, int startColourB, int endColourR, int endColourG, int endColourB, float startX, float startY, boolean ToRight) {
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
      for (int i = 0; i < 3; i++) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), false));
      }
    }

    if (particleID == "LandDust") {
      for (int i = 0; i < 7; i++) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), false));
      }
    }
  }

  void draw() {
    update();

    if ( particleID == "Fireball") {
      for (int i = 0; i < 10; i++) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
      }

      for (Particle particle : particles) {        
        particle.fireballMove();
        particle.display();
      }
    }

    if (particleID == "Hit") {
      if (draw) {
        for (int i = 0; i < 3; i++) {
          particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
        }
      }

      for (Particle particle : particles) {        
        particle.hitMove();
        particle.display();
      }
    }

    if (particleID == "RunDust") {
      if (draw) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
      } 
      for (Particle particle : particles) {        
        particle.runDustMove();
        particle.display();
      }
    }

    if (particleID == "LandDust") {
      if (draw) {
        particles.add(new Particle(particleID, startingColourR, startingColourG, startingColourB, endingColourR, endingColourG, endingColourB, particleSystemStartX, particleSystemStartY, particleSystemStartX + random(-5, 6), particleSystemStartY + random(-5, 6), particleSystemStartX + random(6, 12), particleSystemStartY + random(7, 15), particleSystemStartX + random(-5, 6), particleSystemStartY + random(7, 15), random(-2, 2), toRight));
      }

      for (Particle particle : particles) {        
        particle.landDustMove();
        particle.display();
      }
    }
  }

  void update() {
    for (int i = particles.size()-1; i>= 0; i--) {
      Particle particle = particles.get(i);
      particleDeath = particle.death();
      if (particleDeath) {
        particles.remove(i);
      }
    }
  }
}
