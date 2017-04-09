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
      if(mDirection == 0 && !shooting)
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
      if(mDirection == 1 && !shooting)
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
      if(mDirection == 2 && !shooting)
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
      if(mDirection == 3 && !shooting)
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
      if(mDirection == 0 && !shooting)
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
      {
        pushMatrix();
        translate(0, -48);
        rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos));
        image(russianTop.get(320, 0, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
        popMatrix();
      }
      else
        image(russianTop.get(0,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 1) //UP
    {
      if(mDirection == 1 && !shooting)
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
      {
        //image(russianTop.get(320, 64, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        pushMatrix();
        translate(0, -48);
        rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos) + PI/2);
        image(russianTop.get(320, 64, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
        popMatrix();
      }
      else
        image(russianTop.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 2) //LEFT
    {
      if(mDirection == 2 && !shooting)
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
      {
        //image(russianTop.get(320, 128, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        pushMatrix();
        translate(0, -48);
        rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos) + PI);
        image(russianTop.get(320, 128, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
        popMatrix();
      }
      else
        image(russianTop.get(0,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(direction == 3) // DOWN
    {
      if(mDirection == 3 && !shooting)
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
      {
        //image(russianTop.get(320, 192, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        pushMatrix();
        translate(0, -48);
        rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos) - PI/2);
        image(russianTop.get(320, 192, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
        popMatrix();
      }
      else
        image(russianTop.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    if(hitBoxMode)
    {
      pushMatrix();
      this.hBox.displayBox();
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
      float distance = sqrt(pow(this.xPos-player.getXPos(),2)+pow(this.yPos-player.getYPos(),2));
      float angle = acos(abs(this.xPos-player.getXPos())/distance);
      
      if(angle <= PI/4 && player.getXPos() >= this.xPos)
      {
        direction = 0;
        mDirection = 0;
        xChange = 1.5;
      }
      else if(angle >= PI/4 && player.getYPos() <= this.yPos)
      {
        direction = 1;
        mDirection = 1;
        yChange = -1.5;
      }
      else if(angle <= PI/4 && player.getXPos() <= this.xPos)
      {
        direction = 2;
        mDirection = 2;
        xChange = -1.5;
      }
      else if(angle >= PI/4 && player.getYPos() >= this.yPos)
      {
        direction = 3;
        mDirection = 3;
        yChange = 1.5;
      }
    }
    if(!shooting)
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
    
    //Fellow enemy collision and correction
    for(int i = 0; i < enemies.size(); i++)
    {
      if(enemies.get(i) != this)
      {
        change = collision(enemies.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, 0);
        xChange = change.x;
        yChange = change.y;
      }
    }
    //Player collision
    change = collision(player.getHitbox(), this.hBox, change.x, change.y, change.z, 0);
    xChange = change.x;
    yChange = change.y;
    
    //Map boundary collision and correction
    if(this.xPos + xChange > 1120 || this.xPos + xChange < 0)
      xChange = 0;
    if(this.yPos + yChange > 544 || this.yPos + yChange < 0)
      yChange = 0;
    this.xPos += xChange;
    this.yPos += yChange;
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }

  void visionCheck()
  {
    float distance = sqrt(pow(this.xPos-player.getXPos(),2)+pow(this.yPos-player.getYPos(),2));
    float angle = acos(abs(this.xPos-player.getXPos())/distance);
    if(alerted)
    {
      if(distance <= this.viewDist*1.5)
        attack();
      else
        shooting = false;
    }
    else
    {
      if(this.direction == 0 && angle <= PI/4 && distance <= this.viewDist && player.getXPos() >= this.xPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
      else if(this.direction == 1 && angle >= PI/4 && distance <= this.viewDist && player.getYPos() <= this.yPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
      else if(this.direction == 2 && angle <=PI/4 && distance <= this.viewDist && player.getXPos() <= this.xPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
      else if(this.direction == 3 && angle >= PI/4 && distance <= this.viewDist && player.getYPos() >= this.yPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
    }
  }

  void attack()
  {
    int temp = this.runTime;
    this.runTime = millis();
    this.runTimeTracker += this.runTime - temp;
    if(this.runTimeTracker >= 300)
    {
      float angle = atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos);
      projectiles.add(new Projectile(this.xPos + cos(angle)*bulletSpeed*1.5, this.yPos + sin(angle)*bulletSpeed*1.5, bulletDamage, bulletSpeed, 
        cos(angle), sin(angle), bulletSize, bulletSize, "hostile_damage"));
      this.runTimeTracker = 0;
      this.shooting = true;
    }
  }
  //SETTERS
  void setCurrentHealth(float health){
    this.currentHealth = health;}
  void setAlert(boolean status){
    this.alerted = status;}
  void setTimer(int time){
    this.runTimeTracker = time;}
  void setShooting(boolean shoot){
    this.shooting = shoot;}
  //GETTERs
  float getCurrentHealth(){
    return this.currentHealth;}
  Hitbox getHitbox(){
    return this.hBox;}
  boolean getAlert(){
    return this.alerted;}
  
  void print(){
    println("Enemy:");
    println("x = " + this.initX);
    println("y = " + this.initY);
    println("width = " + this.sizeW);
    println("height = " + this.sizeH);
  }
}