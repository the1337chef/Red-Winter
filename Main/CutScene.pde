//CutScene class

class CutScene
{
  private String id = "null";
  ArrayList <Integer> layers = new ArrayList<Integer>(); //number of layers per subscene
  private int subScenes = 0;
  ArrayList <Integer> sounds = new ArrayList<Integer>(); //number of sounds per subscene
  ArrayList <Float> durations = new ArrayList<Float>();
  private String nextZone = "null";
  private float nextXPos; // Player's x position after a transition
  private float nextYPos; // Player's y position after a transition

  //Constructor
  CutScene(String id, int subScenes, String nextZone)
  {
    this.id = id;
    this.subScenes = subScenes;
    this.nextZone = nextZone;
    this.nextXPos = 0;
    this.nextYPos = 0;
  }

  //Getters
  String getId(){
    return this.id;}
  ArrayList <Integer> getLayers(){
    return this.layers;}
  int getSubScenes(){
    return this.subScenes;}
  ArrayList <Integer> getSounds(){
    return this.sounds;}
  ArrayList <Float> getDurations(){
    return this.durations;}
  String getNextZone(){
    return this.nextZone;}
  float getNextXPos(){
    return this.nextXPos;}
  float getNextYPos(){
    return this.nextYPos;}

  //Setters
  void setId(String id){
    this.id = id;}
  void setLayers(ArrayList <Integer> layers){
    this.layers = layers;}
  void setSubScenes(int subScenes){
    this.subScenes = subScenes;}
  void setSounds(ArrayList <Integer> sounds){
    this.sounds = sounds;}
  void setDurations(ArrayList <Float> durations){
    this.durations = durations;}
  void setNextZone(String nextZone){
    this.nextZone = nextZone;}
  void addLayer(int layer){
  	this.layers.add(layer);}
  void addSound(int sound){
  	this.sounds.add(sound);}
  void addDuration(float duration){
  	this.durations.add(duration);}
  void setNextXPos(float xpos){
    this.nextXPos = xpos;}
  void setNextYPos(float ypos){
    this.nextYPos = ypos;}

  //Print all info
  void printCutScene()
  {
    //CutScene Name
    println("Cutscene id: " + this.id);
    println("Next Zone: " + this.nextZone);
    println("Player's next position: " + this.nextXPos + ", " + this.nextYPos);
    println("SubScenes: " + this.subScenes);
    println("Layers:");
    for(int i = 0; i < this.subScenes; i++){
      println(this.layers.get(i));
    }
    println("Sounds:");
    for(int i = 0; i < this.sounds.size(); i++){
      println(this.sounds.get(i));
    }
    println("Durations:");
    for(int i = 0; i < this.durations.size(); i++){
      println(durations.get(i));
    }
  }

}