//Player subclass

boolean nextZoneChanged = false;

class Player extends Character
{
  private float xPos;
  private float yPos;
  private float direction;        //Aiming direction
  private int mDirection;         //Movement direction
  private float maxHealth;
  private float currentHealth;
  private float maxStamina;
  private float currentStamina;
  private float temperature;
  private int ammo;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private int runTime;
  private int runTimeTracker;
  private boolean invincible;
  private float invTimer;
  private float invTime;
  
  Player(float x, float y, float dir, float h, float s, float t, int a, float wi, float hi, String type)
  {
    //Default constructor
    this.xPos = x;
    this.yPos = y;
    this.direction = dir;        //Radians: 0-2PI
    this.mDirection = 0;       //Int: 0:E, 1:N, 2:W, 3:S
    this.maxHealth = 100;
    this.currentHealth = h;
    this.maxStamina = 100;
    this.currentStamina = s;
    this.temperature = t;
    this.ammo = a;
    this.sizeW = wi;
    this.sizeH = hi;
    this.hBox = new Hitbox(x, y, wi, hi, 0, type);
    this.runTime = 0;
    this.runTimeTracker = 0;
    this.invincible = false;
    this.invTimer = 0;
    this.invTime = 1000;
  }
  
  //Player display bottom half
  void displayBottom()
  {
    //Sprites instead of squares
    pushMatrix();
    
    //X-Translation
    if(this.xPos < 256)                                              //Camera against left wall
      translate(width/2 - ((width/2) * ((256-this.xPos)/256)), 0);
    else if(this.xPos > 864)                                         //Camera against right wall
      translate(width/2 + ((width/2) * ((this.xPos-864)/256)),0);
    else
      translate(width/2, 0);
      
    //Y-Translation
    if(this.yPos < 144)
      translate(0, height/2 - ((height/2) * ((144-this.yPos)/144))); //Camera against top wall
    else if(this.yPos > 410)
      translate(0, height/2 + ((height/2) * ((this.yPos-410)/144))); //Camera against bottom wall
    else
      translate(0, height/2);
    
    float modifier = 1.0;
    if(exhausted)
      modifier = 0.75;
    
    imageMode(CENTER);
    if(mDirection == 0) //RIGHT
    {
      if(mRight)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(mDirection == 1) //UP
    {
      if(mUp)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(mDirection == 2) //LEFT
    {
      if(mLeft)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(mDirection == 3) // DOWN
    {
      if(mDown)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    if(hitBoxMode) {
      rectMode(CENTER);
      this.hBox.displayBox();
    }
    popMatrix();
  }
   //Player display top half
  void displayTop()
  {
    //Sprites instead of squares
    pushMatrix();
    
    //X-Translation
    if(this.xPos < 256)                                              //Camera against left wall
      translate(width/2 - ((width/2) * ((256-this.xPos)/256)), 0);
    else if(this.xPos > 864)                                         //Camera against right wall
      translate(width/2 + ((width/2) * ((this.xPos-864)/256)),0);
    else
      translate(width/2, 0);
      
    //Y-Translation
    if(this.yPos < 144)
      translate(0, height/2 - ((height/2) * ((144-this.yPos)/144))); //Camera against top wall
    else if(this.yPos > 410)
      translate(0, height/2 + ((height/2) * ((this.yPos-410)/144))); //Camera against bottom wall
    else
      translate(0, height/2);
    
    imageMode(CENTER);
    if(aiming && this.ammo > 0)
    {
      pushMatrix();
      int tempX = 0;
      //Right
      if(this.direction >= -PI/4 && this.direction <= PI/4)
      {
        translate(0, -40);
        rotate(direction);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 0, 64, 64), 1, -3, peopleSize*scaler, peopleSize*scaler);
      }
      //Up
      else if(this.direction > -3*PI/4 && this.direction < -PI/4)
      {
        translate(0, -38);
        rotate(direction +PI/2);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 64, 64, 64), 0, -10, peopleSize*scaler, peopleSize*scaler);
      }
      //Left
      else if(this.direction >= 3*PI/4 || this.direction <= -3*PI/4)
      {
        translate(0, -40);
        rotate(direction + PI);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 128, 64, 64), 0, -3, peopleSize*scaler, peopleSize*scaler);
      }
      //Down
      else
      {
        translate(0, -40);
        rotate(direction - PI/2);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 192, 64, 64), 0, 10, peopleSize*scaler, peopleSize*scaler);
      }
      popMatrix();
    }
    else
    {
      
      float modifier = 1.0;
      if(exhausted)
        modifier = 0.75;
      
      if(mDirection == 0) //RIGHT
      {
        if(mRight)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(mDirection == 1) //UP
      {
        if(mUp)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(mDirection == 2) //LEFT
      {
        if(mLeft)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(mDirection == 3) // DOWN
      {
        if(mDown)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (int(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
    }
    popMatrix();
  }
  
  //Player movement
  void movement(float xChange, float yChange)
  {
    PVector change = new PVector(xChange,yChange,0);
    if(exhausted)
    {
      xChange = 0.75*xChange;
      yChange = 0.75*yChange;
    }
    
    //Wall collision and correction
    for(int i = 0; i < walls.size(); i++)
    {
      change = collision(walls.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, walls.get(i).getDirection());
      xChange = change.x;
      yChange = change.y;
    }
    
    for(int i = 0; i < enemies.size(); i++)
    {
      if(enemies.get(i).getDead() == false)
      {
        change = collision(enemies.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, 0);
        xChange = change.x;
        yChange = change.y;
      }
    }
    change.z = 0;
    //Zone Transition Collision
    for(int i = 0; i < transitions.size(); i++)
    {
      change = collision(transitions.get(i), this.hBox, change.x, change.y, change.z, 0);
      if(change.z == 1){
        
        if(nextZone != transitions.get(i).getZone() && gameState == 0){
          zoneTransition = true;
          
          nextZone = transitions.get(i).getZone();
          nextZoneChanged = true;
          //println("nzt1");
          //println("nextZone is " + nextZone + " from the transition");
          nextPlayerX = transitions.get(i).getNextXPos();
          nextPlayerY = transitions.get(i).getNextYPos();
          transitions.clear();
          siberia.stop();
          theme.stop();
        }
        
        
      }
    }
    
    //Map boundary collision and correction
    if(this.xPos + xChange > 1120 || this.xPos + xChange < 0)
      xChange = 0;
    if(this.yPos + yChange > 544 || this.yPos + yChange < 0)
      yChange = 0;
    if(abs(xChange) + abs(yChange) >= 1.4*speed)
    {
      xChange = xChange * 0.7;
      yChange = yChange * 0.7;
    }
    this.xPos += xChange;
    this.yPos += yChange;
        
    //Pickups
    for(int i = 0; i < pickups.size(); i++)
    {
      change = collision(pickups.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, pickups.get(i).getDirection());
      if(change.z == 1)
      {
        pickups.get(i).activate();
        pickupSound.play();
        pickups.remove(i);
        i--;
        change.z = 0;
      }
    }
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }
  
  void cameraMove()
  {
   if(this.xPos < 256)
      cameraX = 0;
    else if(this.xPos > 864)
      cameraX = 608;
    else
      cameraX = this.xPos-256;
    
    if(this.yPos < 144)
      cameraY = 0;
    else if(this.yPos > 400)
      cameraY = 256;
    else
      cameraY = this.yPos-144; 
  }
  
  //GETTERS AND SETTERS
  float getXPos(){
    return this.xPos;}
  float getYPos(){
    return this.yPos;}
  float getDir(){
    return this.direction;}
  float getWidth(){
    return this.sizeW;}
  float getHeight(){
    return this.sizeH;}
  float getMaxHealth(){
    return this.maxHealth;}
  float getCurrentHealth(){
    return this.currentHealth;}
  float getMaxStamina(){
    return this.maxStamina;}
  float getCurrentStamina(){
    return this.currentStamina;}
  float getCurrentTemp(){
    return this.temperature;}
  int getCurrentAmmo(){
    return this.ammo;}
  Hitbox getHitbox(){
    return this.hBox;}
    
  void setX(float x){
    this.xPos = x;}
  void setY(float y){
    this.yPos = y;}
  void setDir(float dir){
    this.direction = dir;}
  void setMDir(int dir){
    this.mDirection = dir;}
  void setHealth(float health){
    this.currentHealth = health;}
  void setStamina(float stamina){
    this.currentStamina = stamina;
    if(this.currentStamina > this.maxStamina)
      this.currentStamina = this.maxStamina;}
  void setCurrentAmmo(int ammo){
    this.ammo = ammo;}
}