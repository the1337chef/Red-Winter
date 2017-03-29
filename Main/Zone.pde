//Zone class

class Zone
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<Hitbox> transitionZones = new ArrayList<Hitbox>();
  
  Zone(){
  }
  
  //Getters
  ArrayList<Wall> getWalls(){
    return this.walls;}
  ArrayList<Hitbox> getTransitionZones(){
    return this.transitionZones;}
    
  //Setters
  void setWalls(ArrayList<Wall> walls){
    this.walls = walls;}
  void setTransitionZones(ArrayList<Hitbox> transitionZones){
    this.transitionZones = transitionZones;}
    
  //Print
  void print(){
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