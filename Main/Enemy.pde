//Enemy class extends Character class

class Enemy extends Character
{
  private float viewAngle;
  private float viewDist;
  
  Enemy(){ //set default values
    this.viewAngle = 0.0;
    this.viewDist = 0.0;
  }


//movement in inherited (redundant to write again)

  public void behaviorCheck(){
  
  }

  public void visionCheck(){
  
  }

  public void attackCheck(){
    
  }
}