//Hitbox class

class Hitbox
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private float direction;
  private String type;
  
  Hitbox(float x, float y, float w, float h, float d, String t)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.direction = d;
    this.type = t;
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
    translate(this.xPos, this.yPos);
    rotate(this.direction);
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
    else if(type.equals("hostile_damage"))
      c = color(255,255,0);
    else if(type.equals("wall"))
      c = color(200,200,200);
    else
      c = color(255,0,255);
    fill(c, 100);
    rect(0, 0, this.sizeW, this.sizeH);
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
  
  void setXPos(float x){
    this.xPos = x;}
  void setYPos(float y){
    this.yPos = y;}
  void setDir(float dir){
    this.direction = dir;}
}