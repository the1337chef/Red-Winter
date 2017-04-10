//Zone class

class Zone
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<Hitbox> transitionZones = new ArrayList<Hitbox>();
  ArrayList<Pickup> pickups = new ArrayList<Pickup>();
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  private String name;
  Zone(String name){
    this.name = name;
  }
  
  //Getters
  ArrayList<Wall> getWalls(){
    return this.walls;}
  ArrayList<Hitbox> getTransitionZones(){
    return this.transitionZones;}
  ArrayList<Pickup> getPickups(){
    return this.pickups;}
  ArrayList<Enemy> getEnemies(){
    return this.enemies;}
  String getZoneName(){
    return this.name;} //I couldn't use getName because it is a processiing library method already
    
  //Setters
  void setWalls(ArrayList<Wall> walls){
    this.walls = walls;}
  void addWall(Wall newWall){
    this.walls.add(newWall);}
  void setTransitionZones(ArrayList<Hitbox> transitionZones){
    this.transitionZones = transitionZones;}
  void addTransitionZone(Hitbox newTransition){
    this.transitionZones.add(newTransition);}
  void setPickups(ArrayList<Pickup> pickups){
    this.pickups = pickups;}
  void addPickup(Pickup newPickup){
    this.pickups.add(newPickup);}
  void setEnemies(ArrayList<Enemy> enemies){
    this.enemies = enemies;}
  void addEnemy(Enemy newEnemy){
    this.enemies.add(newEnemy);}
  void setZoneName(String name){
    this.name = name;}
    
  //Print
  void print(){
    println("Zone " + this.name + ":");
    //Walls
    for(int i = 0; i < this.walls.size(); i++){
      this.walls.get(i).print();
    }
    //TransitionZones
    for(int i = 0; i < this.transitionZones.size(); i++){
      this.transitionZones.get(i).print();
    }
    //Pickups
    for(int i = 0; i < this.pickups.size(); i++){
      println(this.pickups.get(i).getID());
    }
    //Enemies
    for(int i = 0; i < this.enemies.size(); i++){
      this.enemies.get(i).print();
    }
  }
}