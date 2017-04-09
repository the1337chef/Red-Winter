


void loadSave(){
  
   saveReader = createReader("save.txt");

  try
  {
    currentChapter = saveReader.readLine().substring(8);
    currentZone = saveReader.readLine().substring(5);
    nextPlayerX = Float.parseFloat(saveReader.readLine().substring(5));
    nextPlayerY = Float.parseFloat(saveReader.readLine().substring(5));
    nextZone = currentZone;
    saveHealth = Float.parseFloat(saveReader.readLine().substring(7));
    saveStamina = Float.parseFloat(saveReader.readLine().substring(8));
    saveTemp = Float.parseFloat(saveReader.readLine().substring(5));
    saveAmmo = Integer.parseInt(saveReader.readLine().substring(5));
    last_cutscene = saveReader.readLine().substring(14);
    dynamite = Integer.parseInt(saveReader.readLine().substring(9));
    detonator = Integer.parseInt(saveReader.readLine().substring(10));
    rope = Integer.parseInt(saveReader.readLine().substring(5));
    collar = Integer.parseInt(saveReader.readLine().substring(7));
    seal1 = Integer.parseInt(saveReader.readLine().substring(6));
    seal2 = Integer.parseInt(saveReader.readLine().substring(6));
    whale = Integer.parseInt(saveReader.readLine().substring(6));
    sap = Integer.parseInt(saveReader.readLine().substring(4));
  }
  catch(IOException e)
  {
    currentChapter = "1";
    currentZone = "null";
    nextPlayerX = 0;
    nextPlayerY = 0;
    saveHealth = 0;
    saveStamina = 0;
    saveTemp = 0;
    saveAmmo = 0;
    last_cutscene = "0";
    dynamite = 0;
    detonator = 0;
    rope = 0;
    collar = 0;
    seal1 = 0;
    seal2 = 0;
    whale = 0;
    sap = 0;
    e.printStackTrace();
  }
}