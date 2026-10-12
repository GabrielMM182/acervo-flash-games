function loadHints()
{
   if(hints[_root.levelUp] == "")
   {
      timeManager.theClipBoard.hintCard._alpha = 0;
   }
   else
   {
      timeManager.theClipBoard.hintCard._alpha = 100;
      timeManager.theClipBoard.hintCard.hintText.text = hints[_root.levelUp];
   }
}
hints = new Array();
hints.push("","MORE SURVIVORS MEANS MORE CAN BE DONE","TIME SEARCHING FOR WEAPONS ADDS UP","SOME ZOMBIES CARRY WEAPONS YOU CAN USE","","SPACEBAR SWITCHES WEAPONS","HIT \'R\' TO RELOAD YOUR WEAPON","","ANY SEARCHING CAN BE DANGEROUS","BETTER WEAPONS TAKE TIME TO FIND","","REMEMBER TO WRITE TOMMOROW\'S NOTE","DON\'T WASTE TIME OVER REPAIRING","ESCAPE OPENS THE OPTIONS","","CALL MUM IF I LIVE","BROKEN WALL PLUS ZOMBIES EQUALS DEATH","","OH I DON\'T KNOW","","","DON\'T DIE","","KILL ZOMBIES...AND STUFF","","","I THINK I CAN. I THINK I CAN.","","","ZOMBIE ARMS AREN\'T FOOD");
