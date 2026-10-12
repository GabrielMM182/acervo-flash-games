function showInstructions(loadedFrom)
{
   hideWholeMenu();
   instructionsLoadedFrom = loadedFrom;
   mainMenu.instructionsHolder.attachMovie("instructionsMenu","instructionsMenuIn",15000);
   mainMenu.instructionsHolder._alpha = 0;
   mainMenu.instructionsHolder.alphaTo(100,1.2,"easeOutSine");
}
function loadFromInstructions()
{
   switch(instructionsLoadedFrom)
   {
      case "mainMenu":
         trace("LOADED INSTRUCTIONS FROM MAIN MENU");
         loadWholeMenuNow();
         return;
      case "options":
         trace("LOADED INSTRUCTIONS FROM OPTIONS");
         return;
      default:
         return;
   }
}
