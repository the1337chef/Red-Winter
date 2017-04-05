//Loading info for cutscene using the configure file



public void loadCutScene(){
  int cid = Integer.parseInt(last_cutscene);
  
  println("cid=" + cid);
  int cc = Integer.parseInt(currentChapter);
  cc--;
  println("cc=" + cc);
  CutScene currentCutScene = chapters.get(cc).getCutScenes().get(cid);
  nextZone = currentCutScene.getNextZone();
  println("nextZone turned to " + nextZone + "in the loadCutscene");
  cc++;
  playCutScene(cc, currentCutScene);

}