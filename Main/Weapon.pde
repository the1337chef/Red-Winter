//Weapon superclass

class Weapon
{
  private int damage;
  
  Weapon()
  {
    this.damage = 0;
  }
  Weapon(int da)
  {
    this.damage = da;
  }
  
  //GETTERS AND SETTERS
  int getDam(){
    return this.damage;}
  void setDam(int da){
    this.damage = da;}
}