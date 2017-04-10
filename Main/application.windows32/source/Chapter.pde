//Chapter class

class Chapter
{
  private String id = "null";
  ArrayList<CutScene> cutScenes = new ArrayList<CutScene>();
  ArrayList<Zone> zones = new ArrayList<Zone>();
  
  
  //Constructor
  Chapter(String id)
  {
  	this.id = id;
  }

  //Getters
  String getId(){
  	return this.id;}
  ArrayList<CutScene> getCutScenes(){
  	return this.cutScenes;}
  ArrayList<Zone> getZones(){
    return this.zones;}

  //Setters
  void setId(String id){
  	this.id = id;}
  void setCutScenes(ArrayList<CutScene> cutScenes){
  	this.cutScenes = cutScenes;}
  void addCutScene(CutScene cutscene){
  	this.cutScenes.add(cutscene);}
  void setZones(ArrayList<Zone> zones){
    this.zones = zones;}
  void addZone(Zone newZone){
    this.zones.add(newZone);}

  //Print
  void print(boolean printCutScenes){
  	println("Chapter: " + this.id);
  	if(printCutScenes == true)
  	{
  		println("CutScenes:");
	  	for(int i = 0; i < this.cutScenes.size(); i++){
	  		this.cutScenes.get(i).printCutScene();
	  	}
  	}
  }
}