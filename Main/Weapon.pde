//Weapon superclass

class Weapon
{
  private int damage;
  private String id;
  
  Weapon()
  {
    this.damage = 0;
    this.id = "none";
  }
  Weapon(int da)
  {
    this.damage = da;
    this.id = "none";
  }
  
  //GETTERS AND SETTERS
  int getDam(){
    return this.damage;}
  void setDam(int da){
    this.damage = da;}
  String getID(){
    return this.id;}
}