//Chapter class

class Chapter
{
  private String id = "null";
  ArrayList<CutScene> cutScenes = new ArrayList<CutScene>();
  
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

  //Setters
  void setId(String id){
  	this.id = id;}
  void setCutScenes(ArrayList<CutScene> cutScenes){
  	this.cutScenes = cutScenes;}

  //Print
  void printChapter(boolean printCutScenes){
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