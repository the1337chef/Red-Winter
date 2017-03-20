//Ranged Weapon Class

class RangedWeapon extends Weapon
{
  private float speed;
  private String type;
  private float sizeW;
  private float sizeH;
  
  RangedWeapon()
  {
    super(0);
    this.speed = 1;
    this.type = "neutral";
    this.sizeW = 10;
    this.sizeH = 10;
  }
  
  RangedWeapon(int dam, float sp, String t, float w, float h)
  {
    super(dam);
    this.speed = sp;
    this.type = t;
    this.sizeW = w;
    this.sizeH = h;
  }
  
  void addProjectile(float x, float y, float xVector, float yVector)
  {
    projectiles.add(new Projectile (x, y, super.damage, this.speed, xVector, yVector, this.sizeW, this.sizeH, this.type));
  }
}