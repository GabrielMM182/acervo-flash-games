function unhideAllMenu()
{
   mainMenu.dawn._visible = true;
   mainMenu.bgLawn._visible = true;
   mainMenu.noise._visible = true;
}
function loadWholeMenuNow()
{
   _root.alphaTo(100,1);
   mainMenuLoadedOnce = true;
   mainMenu.dawn._visible = true;
   mainMenu.bgLawn._visible = true;
   mainMenu.skipButton.alphaTo(0,2,"easeOutSine",null,disableSkipButton);
   mainMenu.conArtistsLogo.stop();
   mainMenu.conArtistsLogo.alphaTo(0,0,"easeOutSine");
   mainMenu.dawn.alphaTo(100,5,"easeOutSine");
   mainMenu.logo.stopTween();
   mainMenu.logo.alphaTo(0,1,"easeOutSine");
   mainMenu.gameTitle.blurTo(2,2,3,"easeOutSine");
   mainMenu.gameTitle.alphaTo(100,2,"easeOutSine",null,playSplatter);
   mainMenu.mainMenuButtons.alphaTo(100,2);
}
function enableSkipButton()
{
   unhideAllMenu();
   mainMenu.skipButton._alpha = 0;
   mainMenu.skipButton._visible = true;
   mainMenu.skipButton.alphaTo(100,1);
}
function disableSkipButton()
{
   mainMenu.skipButton._visible = false;
}
function hideWholeMenu()
{
   mainMenu.gameTitle.stopTween();
   mainMenu.gameTitle.blurTo(2,2,3,"easeOutSine");
   mainMenu.gameTitle.alphaTo(0,2,"easeOutSine");
   mainMenu.mainMenuButtons.alphaTo(0,2);
}
function playSplatter()
{
   mainMenu.mainMenuButtons._visible = true;
   mainMenu.bloodSplatter.play();
   mainMenu.noise.play();
}
function mainButtons(butName)
{
   _root.mainMenu.mainButtons._visible = false;
   _root.mainMenu.mainMenuButtons._alpha = 0;
   _root.mainMenu.mainMenuButtons.alphaTo(100,2,"easeOutSine",18,playSplatter);
   currentX = _root.mainMenu[butName]._x;
   currentY = _root.mainMenu[butName]._y;
   _root.mainMenu.mainMenuButtons[butName].butLabel.text = butName;
   if(butName == "PLAYTLS1")
   {
      _root.mainMenu.mainMenuButtons[butName].butLabel.text = "PLAY THE LAST STAND - PART 1";
   }
   if(butName == "PLAY MORE GAMES")
   {
      _root.mainMenu.mainMenuButtons[butName].butLabel.text = "PLAY MORE ZOMBIE GAMES";
   }
   _root.mainMenu.mainMenuButtons[butName].blurTo(3,2,0.1,"easeOutSine");
   _root.mainMenu.mainMenuButtons[butName].onRollOver = function()
   {
      this.blurTo(1,2,0.8,"easeOutSine");
   };
   _root.mainMenu.mainMenuButtons[butName].onRollOut = _root.mainMenu.mainMenuButtons[butName].onDragOut = function()
   {
      this.blurTo(3.5,2,2,"easeOutSine",0.2);
   };
   _root.mainMenu.mainMenuButtons[butName].onRelease = function()
   {
      switch(butName)
      {
         case "PLAY":
            menuMusic.stop();
            showCrosshairs();
            _root.gotoAndStop("firstLevel");
            return;
         case "INSTRUCTIONS":
            showInstructions("mainMenu");
            return;
         case "OPTIONS":
            _root.loadOptions();
            return;
         case "CREDITS":
            _root.loadCredits();
            return;
         case "PLAY MORE GAMES":
            getURL("http://armorgames.com/tag/zombie/", "_blank");
            return;
         case "PLAYTLS1":
            getURL("http://armorgames.com/play/269/the-last-stand", "_blank");
            return;
         default:
            return;
      }
   };
}
stop();
mainMenu.dawn._visible = false;
mainMenu.bgLawn._visible = false;
mainMenu.noise._visible = false;
menuMusic = new Sound(mainMenu);
menuMusic.attachSound("menuMusic");
menuMusic.setVolume(0);
menuMusic.start(0,1);
menuMusic.volumeTo(80,0.5,"easeOutSine",13);
if(mainMenuLoadedOnce != true)
{
   _root.alphaTo(100,1);
   mainMenuLoadedOnce = true;
   mainMenu.setVolume(0);
   mainMenu._alpha = 0;
   mainMenu.alphaTo(100,0,"easeOutSine");
   mainMenu.skipButton.alphaTo(0,0,"easeOutSine",15,enableSkipButton);
   mainMenu.conArtistsLogo.alphaTo(0,4,"easeOutSine",13);
   mainMenu.dawn.alphaTo(100,30,"easeOutSine",15);
   mainMenu.gameTitle.blurTo(2,2,8,"easeOutSine",15,disableSkipButton);
   mainMenu.gameTitle.alphaTo(100,2,"easeOutSine",15,playSplatter);
   mainMenu.skipButton.alphaTo(0,2,"easeOutSine",20);
}
else
{
   _root.alphaTo(100,1);
   unhideAllMenu();
   loadWholeMenuNow();
}
