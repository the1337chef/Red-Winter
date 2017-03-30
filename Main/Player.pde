//Player subclass

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
    this.hBox = new Hitbox(x, y, wi, hi, dir, type);
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
    
    imageMode(CENTER);
    if(mDirection == 0) //RIGHT
    {
      if(mRight)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,0,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerBottom.get(0,0,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    else if(mDirection == 1) //UP
    {
      if(mUp)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerBottom.get(64*temp2,64,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerBottom.get(0,64,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    else if(mDirection == 2) //LEFT
    {
      if(mLeft)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerBottom.get(64*temp2,128,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerBottom.get(0,128,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    else if(mDirection == 3) // DOWN
    {
      if(mDown)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerBottom.get(64*temp2,192,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerBottom.get(0,192,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    if(hitBoxMode)
      this.hBox.displayBox();
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
    if(mDirection == 0) //RIGHT
    {
      if(mRight)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerTop.get(64*temp2,0,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerTop.get(0,0,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    else if(mDirection == 1) //UP
    {
      if(mUp)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerTop.get(64*temp2,64,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerTop.get(0,64,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    else if(mDirection == 2) //LEFT
    {
      if(mLeft)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerTop.get(64*temp2,128,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerTop.get(0,128,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    else if(mDirection == 3) // DOWN
    {
      if(mDown)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker >= 600)
          runTimeTracker = 0;
        int temp2 = (runTimeTracker / 100)+1;
        image(playerTop.get(64*temp2,192,64,64), 0, -32, 48*scaler, 48*scaler);
      }
      else
        image(playerTop.get(0,192,64,64), 0, -32, 48*scaler, 48*scaler);
    }
    
    if(aiming)
      rotate(this.direction);
    popMatrix();
  }
  
  //Player movement
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
    change.z = 0;
    //Zone Transition Collision
    for(int i = 0; i < transitions.size(); i++)
    {
      change = collision(transitions.get(i), this.hBox, change.x, change.y, change.z, 0);
      if(change.z == 1){
        zoneTransition = true;
        nextZone = transitions.get(i).getZone();
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
    
    //Pickups
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
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
}