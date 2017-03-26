//Chapter class

class Chapter
{
  private String id = "null";
  ArrayList<CutScene> cutScenes = new ArrayList<CutScene>();
  private int zones = 0;
  //TODO:Arraylist of zones
  
  //Constructor
  Chapter(String id, int zones)
  {
  	this.id = id;
  	this.zones = zones;
  }

  //Getters
  String getId(){
  	return this.id;}
  ArrayList<CutScene> getCutScenes(){
  	return this.cutScenes;}
  int getZones(){
  	return this.zones;}

  //Setters
  void setId(String id){
  	this.id = id;}
  void setCutScenes(ArrayList<CutScene> cutScenes){
  	this.cutScenes = cutScenes;}
  void addCutScene(CutScene cutscene){
  	this.cutScenes.add(cutscene);}
  void setZones(int zones){
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