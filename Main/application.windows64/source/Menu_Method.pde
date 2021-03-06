boolean themePlayed = false;

void mainMenu()
{
  //Display background/ background animation
  menu_background.resize(width,height);
  image(menu_background, 0, 0);
    
  //Display buttons
  newGame.display();
  continueGame.display();
  quitGame.display();
  saveGame.display();
  printSave(saveCompleted); //Prints if recently saved
  if(!themePlayed){
    theme.amp(1.0);
    theme.loop();
    themePlayed = true;
  }
  
}