//Enemy class extends Character class

class Enemy extends Character
{
  private float xPos;
  private float yPos;
  private float initX;
  private float initY;
  private int direction;
  private int mDirection;
  private float maxHealth;
  private float currentHealth;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private float viewAngle; //make sure to put in radians
  private float viewDist;
  private int runTime;
  private int runTimeTracker;
  private boolean shooting;
  private boolean alerted;
  private float patrolSize;
  
  Enemy(float x, float y, int d, float he, float w, float h, float a, float dist, float p)
  {
    this.xPos = x;
    this.yPos = y;
    this.initX = x;
    this.initY = y;
    this.direction = d;       //Int: 0:E, 1:N, 2:W, 3:S
    this.mDirection = -1;           //Int: 0:E, 1:N, 2:W, 3:S, -1:NOT MOVING
    this.maxHealth = he;
    this.currentHealth = he;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x,y,w,h,0,"enemy");
    this.viewAngle = a;
    this.viewDist = dist;
    this.runTime = 0;
    this.runTimeTracker = 0;
    this.shooting = false;
    this.patrolSize = p;
    this.alerted = false;
  }
  
  void displayBottom()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    imageMode(CENTER);
    if(direction == 0) //RIGHT
    {
      if(mDirection == 0)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianBottom.get(64*temp2,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(russianBottom.get(0,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 1) //UP
    {
      if(mDirection == 1)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianBottom.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(russianBottom.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 2) //LEFT
    {
      if(mDirection == 2)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianBottom.get(64*temp2,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(russianBottom.get(0,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 3) // DOWN
    {
      if(mDirection == 3)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianBottom.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(russianBottom.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    popMatrix();
  }
  
  void displayTop()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    imageMode(CENTER);
    if(direction == 0) //RIGHT
    {
      if(mDirection == 0)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianTop.get(64*temp2,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(shooting)
        image(russianTop.get(320, 0, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      else
        image(russianTop.get(0,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 1) //UP
    {
      if(mDirection == 1)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianTop.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(shooting)
        image(russianTop.get(320, 64, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      else
        image(russianTop.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 2) //LEFT
    {
      if(mDirection == 2)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianTop.get(64*temp2,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(shooting)
        image(russianTop.get(320, 128, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      else
        image(russianTop.get(0,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 3) // DOWN
    {
      if(mDirection == 3)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 400)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(russianTop.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(shooting)
        image(russianTop.get(320, 192, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      else
        image(russianTop.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    if(hitBoxMode)
    {
      this.hBox.displayBox();
      pushMatrix();
      fill(0,150);
      rotate(-PI/2*direction);
      arc(0,0,this.viewDist*scaler*2,this.viewDist*scaler*2,-PI/4,PI/4);
      popMatrix();
    }
    popMatrix();
  }

  //Enemies walk around in a square unless they detect an enemy
  public void behaviorCheck()
  {
    float xChange = 0;
    float yChange = 0;
    if(!alerted)
    {
      //Moving in square
      if(mDirection == 0)                          //Moving Right
      {
        if(this.xPos < this.initX)
          xChange = 1;
        else
          mDirection = -1;
      }
      else if(mDirection == 1)                          //Moving Up
      {
        if(abs(this.yPos-this.initY) < this.patrolSize)
          yChange = -1;
        else
          mDirection = -1;
      }
      else if(mDirection == 2)                          //Moving Left
      {
        if(abs(this.xPos-this.initX) < this.patrolSize)
          xChange = -1;
        else
          mDirection = -1;
      }
      else if(mDirection == 3)                          //Moving Down
      {
        if(this.yPos < this.initY)
          yChange = 1;
        else
          mDirection = -1;
      }
      //Stopping at square corner for 3 seconds
      else if(mDirection == -1)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 3000)
        {
          direction = (direction+1)%4;
          mDirection = direction;
          runTimeTracker = 0;
        }
      }
    }
    else
    {
      direction = (direction+1)%4;
    }
    movement(xChange,yChange);
    visionCheck();
  }
  
  void movement(float xChange, float yChange)
  {
    PVector change = new PVector(xChange,yChange,0);
    
    //Wall collision and correction
    for(int i = 0; i < walls.size(); i++)
    {
      change = collision(walls.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, walls.get(i).getDirection());
      xChange = change.x;
      yChange = change.y;
    }
    
    change = collision(player.getHitbox(), this.hBox, change.x, change.y, change.z, 0);
    xChange = change.x;
    yChange = change.y;
    
    //Map boundary collision and correction
    if(this.xPos + xChange > 1120 || this.xPos + xChange < 0)
      xChange = 0;
    if(this.yPos + yChange > 544 || this.yPos + yChange < 0)
      yChange = 0;
    if(abs(xChange) + abs(yChange) >= 1.4*enemySpeed)
    {
      xChange = xChange * 0.7;
      yChange = yChange * 0.7;
    }
    this.xPos += xChange;
    this.yPos += yChange;
  }

  void visionCheck()
  {
    float distance = sqrt(pow(this.xPos-player.getXPos(),2)+pow(this.yPos-player.getYPos(),2));
    float angle = acos(abs(this.xPos-player.getXPos())/distance);
    //QuadrantI
    if(this.xPos <= player.getXPos() && this.yPos >= player.getYPos() && (direction == 0 || direction == 1))
    {
      if(distance <= this.viewDist && angle <= (PI/2*direction)+this.viewAngle/2 && angle >= (PI/2*direction)-this.viewAngle/2)
      {
        for(int i = 0; i < enemies.size(); i++)
          enemies.get(i).setAlert(true);
      }
    }
    //QuadrantII
    else if(this.xPos > player.getXPos() && this.yPos >= player.getYPos() && (direction == 1 || direction == 2))
    {
      if(distance <= this.viewDist && angle <= (PI/2*(direction-1))+this.viewAngle/2 && angle >= (PI/2*(direction-1))-this.viewAngle/2)
      {
        for(int i = 0; i < enemies.size(); i++)
          enemies.get(i).setAlert(true);
      }
    }
    //QuadrantIII
    else if(this.xPos > player.getXPos() && this.yPos < player.getYPos() && (direction == 2 || direction == 3))
    {
      if(distance <= this.viewDist && angle <= (PI/2*(direction-2))+viewAngle/2 && angle >= (PI/2*(direction-2))-this.viewAngle/2)
      {
        for(int i = 0; i < enemies.size(); i++)
          enemies.get(i).setAlert(true);
      }
    }
    //QuadrantIV
    else if(this.xPos <= player.getXPos() && this.yPos >= player.getYPos() && (direction == 3 || direction == 0))
    {
      int temp;
      if(direction == 3)
        temp = 0;
      else
        temp = 1;
      if(distance <= this.viewDist && angle <= (PI/2*(temp))+viewAngle/2 && angle >= (PI/2*(temp))-this.viewAngle/2)
      {
        for(int i = 0; i < enemies.size(); i++)
          enemies.get(i).setAlert(true);
      }
    }
  }

  public void attackCheck(){
    
  }
  
  void setAlert(boolean status){
    this.alerted = status;}
  
  void print(){
    println("Enemy:");
    println("x = " + this.initX);
    println("y = " + this.initY);
    println("width = " + this.sizeW);
    println("height = " + this.sizeH);
  }
}