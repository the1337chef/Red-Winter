//Zone class

class Zone
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<Hitbox> transitionZones = new ArrayList<Hitbox>();
  private String name;
  Zone(){
  }
  
  //Getters
  ArrayList<Wall> getWalls(){
    return this.walls;}
  ArrayList<Hitbox> getTransitionZones(){
    return this.transitionZones;}
  String getZoneName(){
    return this.name;} //I couldn't use getName because it is a processiing library method already
    
  //Setters
  void setWalls(ArrayList<Wall> walls){
    this.walls = walls;}
  void setTransitionZones(ArrayList<Hitbox> transitionZones){
    this.transitionZones = transitionZones;}
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
  }
}