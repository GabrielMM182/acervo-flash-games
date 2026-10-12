function loadCredits()
{
   mainMenu.credits.creditsButton._visible = true;
   mainMenu.credits.creditList._alpha = 0;
   mainMenu.credits.creditList._visible = true;
   mainMenu.credits._alpha = 0;
   mainMenu.credits._visible = true;
   mainMenu.credits.alphaTo(100,2,"easeInSine");
   mainMenu.credits.creditList.alphaTo(100,3,"easeOutSine",2,hideMenuAnims);
   mainMenu.credits.creditList.ySlideTo(-1500,45,"easeOutSine",2);
   mainMenu.credits.creditList.alphaTo(0,3,"easeOutSine",24);
   mainMenu.credits.alphaTo(100,0,"easeOutSine",27,closeCredits);
}
function hideMenuAnims()
{
   mainMenu.mainButtons._visible = false;
   mainMenu.bloodSplatter._visible = false;
}
function closeCredits()
{
   mainMenu.credits.creditsButton._visible = false;
   mainMenu.mainButtons._visible = true;
   mainMenu.bloodSplatter._visible = true;
   mainMenu.credits.alphaTo(0,3,"easeOutSine",0,function()
   {
      this._visible = false;
   }
   );
   mainMenu.credits.creditList.ySlideTo(890,0,"easeOutSine",0);
}
