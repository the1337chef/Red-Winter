//Chapter class

class Chapter
{
  private String id = "null";
  ArrayList<CutScene> cutScenes = new ArrayList<CutScene>();
  private int numOfZones = 0;
  ArrayList<String> zones = new ArrayList<String>();
  
  
  //Constructor
  Chapter(String id, int numOfZones)
  {
  	this.id = id;
  	this.numOfZones = numOfZones;
  }

  //Getters
  String getId(){
  	return this.id;}
  ArrayList<CutScene> getCutScenes(){
  	return this.cutScenes;}
  int getNumOfZones(){
  	return this.numOfZones;}
  ArrayList<String> getZones(){
    return this.zones;}

  //Setters
  void setId(String id){
  	this.id = id;}
  void setCutScenes(ArrayList<CutScene> cutScenes){
  	this.cutScenes = cutScenes;}
  void addCutScene(CutScene cutscene){
  	this.cutScenes.add(cutscene);}
  void setNumOfZones(int numOfZones){
  	this.numOfZones = numOfZones;}
  void setZones(ArrayList<String> zones){
    this.zones = zones;}

  //Print
  void printChapter(boolean printCutScenes){
  	println("Chapter: " + this.id);
  	println("Zones: " + this.zones);
  	if(printCutScenes == true)
  	{
  		println("CutScenes:");
	  	for(int i = 0; i < this.cutScenes.size(); i++){
	  		this.cutScenes.get(i).printCutScene();
	  	}
  	}
  }
}