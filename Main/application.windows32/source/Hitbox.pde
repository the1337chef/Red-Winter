//Hitbox class

class Hitbox
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private float direction;
  private String type;
  private String zone; // Next zone for zone transition boxes
  private float nextXPos; // Player's x position after a transition
  private float nextYPos; // Player's y position after a transition
  
  Hitbox(float x, float y, float w, float h, float d, String t)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.direction = d;
    this.type = t;
    this.zone = "null";
    this.nextXPos = 0;
    this.nextYPos = 0;
  }
  
  //Displays hitbox
  //Color based on object type
  //Green = player
  //Red = enemy
  //Blue = ally
  //Cyan = friendly damage
  //Yellow = hostile damage
  //Light Gray = wall
  //Magenta = other
  void displayBox()
  {
    pushMatrix();
    if(!type.equals("player"))
      //translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
      
    //rotate(this.direction);
    rectMode(CENTER);
    noStroke();
    color c;
    if(type.equals("player"))
      c = color(0,255,0);
    else if(type.equals("enemy"))
      c = color(255,0,0);
    else if(type.equals("ally"))
      c = color(0,0,255);
    else if(type.equals("friendly_damage"))
      c = color(0,255,255);
    else if(type.equals("zone_transition"))
      c = color(0,0,170);
    else if(type.equals("hostile_damage"))
      c = color(255,255,0);
    else if(type.equals("wall"))
      c = color(200,200,200); //silver
    else
      c = color(255,0,255);
    fill(c, 100);
    rotate(this.direction);
    if(type.equals("player"))
      rect(0, 0, this.sizeW*scaler, this.sizeH*scaler);
    else
      rect(0, 0, this.sizeW*scaler, this.sizeH*scaler);
    popMatrix();
    
    pushMatrix();
    textAlign(LEFT,BOTTOM);
    text("( " + this.xPos + " , " + this.yPos + " ) ", 0, 0);
    popMatrix();
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
  String getType(){
    return this.type;}
  String getZone(){
    return this.zone;}
  float getNextXPos(){
    return this.nextXPos;}
  float getNextYPos(){
    return this.nextYPos;}
  
  void setXPos(float x){
    this.xPos = x;}
  void setYPos(float y){
    this.yPos = y;}
  void setDir(float dir){
    this.direction = dir;}
  void setZone(String z){
    this.zone = z;}
  void setNextXPos(float nextXPos){
    this.nextXPos = nextXPos;}
  void setNextYPos(float nextYPos){
    this.nextYPos = nextYPos;} 
    
    void print(){
      println("Hitbox:");
      println("X = " + this.xPos);
      println("Y = " + this.yPos);
      println("direction = " + this.direction);
      println("Zone to transition to : " + this.zone);
      println("Next Player X position : " + this.nextXPos);
      println("Next Player Y position : " + this.nextYPos);
    }
  }