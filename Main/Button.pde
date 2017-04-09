//Button class

class Button
{
  private float xPos;
  private float yPos;
  private float bWidth;
  private float bHeight;
  private String text;
  private boolean active;
  private boolean highlight;
  private boolean soundPlayed;
  
  Button(float x, float y, float w, float h, String words, boolean a)
  {
    this.xPos = x;
    this.yPos = y;
    this.bWidth = w;
    this.bHeight = h;
    this.text = words;
    this.active = a;
    this.highlight = false;
    this.soundPlayed = false;
  }
  
  //Display button
  void display()
  {
    if (this.highlight) {
      if (this.soundPlayed == false) {
         buttonHover.play();
         soundPlayed = true;
      }
    }
    else {
       soundPlayed = false; 
    }
    
    //Box
    if(this.active)
    {
      if( (mouseX <= xPos+(bWidth/2)) && (mouseX >= xPos-(bWidth/2)) &&
        (mouseY <= yPos+(bHeight/2)) && (mouseY >= yPos-(bHeight/2)))
      {
        fill(206,151,59);
        this.highlight = true;
      }
      else
      {
        fill(164,13,13);
        this.highlight = false;
        noStroke();
      }

    }
    else
    {
      fill(150);
      stroke(50);
    }
    strokeWeight(4);
    rect(this.xPos,this.yPos,this.bWidth,this.bHeight);
    
    //Text
    if(this.active)
      if( (mouseX <= xPos+(bWidth/2)) && (mouseX >= xPos-(bWidth/2)) &&
        (mouseY <= yPos+(bHeight/2)) && (mouseY >= yPos-(bHeight/2)))
      {
        fill(164,13,13);
      }
    else
      fill(206,151,59);
      rectMode(CENTER);
      textSize(36);
      textAlign(CENTER,CENTER);
      text(text,this.xPos, this.yPos);
  }
  
  //GETTERS
  float getXPos(){
    return this.xPos;}
  float getYPos(){
    return this.yPos;}
  float getWidth(){
    return this.bWidth;}
  float getHeight(){
    return this.bHeight;}
  boolean getHighlight(){
    return this.highlight;}
}