//COLLISION DETECTION
//X-AXIS
boolean xCollision(Hitbox hBox1, Hitbox hBox2, float xChange)
{
  if(hBox2.getHeight() > hBox1.getHeight())        //Adjustment for size difference between hitboxes
  {
    Hitbox temp = hBox1;
    hBox1 = hBox2; //did you switch so the one with the larger height is hBox1
    hBox2 = temp;
    //xChange = -xChange;
  }
  //the above will affect the xchange because it is assigned to the wrong box
  if((hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2) && //top of first is bigger than the bottom of second
    (hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2) && //bottom of first is smaller than the top of the second
    (hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 + xChange) && //right of first is larger than left of second with change
    (hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2 + xChange)) //left of first will be smaller than right of second with change 
    {
      return true;
    }
  else
    return false;
}

//Y-AXIS
boolean yCollision(Hitbox hBox1, Hitbox hBox2, float yChange)
{
  if(hBox2.getWidth() > hBox1.getWidth())        //Adjustment for size difference between hitboxes
  {
    Hitbox temp = hBox1;
    hBox1 = hBox2;
    hBox2 = temp;
    //yChange = -yChange;
  }
  if((hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 &&
    hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2) &&
    (hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2 + yChange &&
    hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2 + yChange))
    {
      return true;
    }
  else
    return false;
}