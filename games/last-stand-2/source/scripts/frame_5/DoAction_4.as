function optionsButtons(butName)
{
   _root.optionsMenu[butName].butLabel.text = butName;
   var _loc0_;
   switch(butName)
   {
      case "QUALITY":
         _root.optionsMenu[butName].onRelease = function()
         {
            _root.setCurrentQuality();
            _root.toggleQuality();
         };
         _root.optionsMenu[butName].onRollOver = function()
         {
            _root.setCurrentQuality();
            _root.optionsMenu.submenu_Quality.alphaTo(100,0.5,"easeOutSine");
         };
         var _temp_2 = _root.optionsMenu[butName];
         var _temp_1 = "onRollOut";
         _root.optionsMenu[butName].onDragOut = _loc0_ = function()
         {
            _root.optionsMenu.submenu_Quality.alphaTo(0,0.5,"easeOutSine");
         };
         _temp_2[_temp_1] = _loc0_;
         return;
      case "MUSIC":
         _root.optionsMenu[butName].onRollOver = function()
         {
            _root.optionsMenu.submenu_Music.alphaTo(100,0.5,"easeOutSine");
         };
         var _temp_4 = _root.optionsMenu[butName];
         var _temp_3 = "onRollOut";
         _root.optionsMenu[butName].onDragOut = _loc0_ = function()
         {
            _root.optionsMenu.submenu_Music.alphaTo(0,0.5,"easeOutSine");
         };
         _temp_4[_temp_3] = _loc0_;
         _root.optionsMenu[butName].onRelease = function()
         {
            _root.toggleMusic();
         };
         return;
      case "MAIN MENU":
         _root.optionsMenu[butName].onRelease = function()
         {
            _root.mainChar.removeMovieClip();
            _root.hud.removeMovieClip();
            cleanUpScreen();
            cleanUpSurvivors();
            removeSurvivors();
            loadOptions();
            delete game.onEnterFrame;
            gotoAndStop("main");
            delete this.onRelease;
         };
         return;
      case "RESUME":
         _root.optionsMenu[butName].onRelease = function()
         {
            loadOptions();
         };
         return;
      default:
         return;
   }
}
function loadOptions()
{
   if(optionsLoaded == false && timeManagerOpen == false)
   {
      hideWholeMenu();
      pauseGame();
      hideCrosshairs();
      bgMusic.volumeTo(10,3,"easeOutSine");
      _root.attachMovie("optionsMenu","optionsMenu",891039);
      optionsMenu._alpha = 0;
      optionsMenu.alphaTo(100,1,"easeOutSine");
      optionsLoaded = true;
   }
   else if(timeManagerOpen == false)
   {
      loadWholeMenuNow();
      pauseGame();
      showCrosshairs();
      bgMusic.volumeTo(20,3,"easeOutSine");
      optionsMenu.alphaTo(0,0.5,"easeOutSine",null,removeOptions);
      optionsLoaded = false;
   }
}
function removeOptions()
{
   showCrosshairs();
   optionsMenu.removeMovieClip();
}
function setCurrentQuality()
{
   _root.optionsMenu.submenu_Quality.currentQuality.text = _root._quality;
}
function toggleQuality()
{
   switch(_root._quality)
   {
      case "HIGH":
         _root._quality = "medium";
         setCurrentQuality();
         return;
      case "MEDIUM":
         _root._quality = "low";
         setCurrentQuality();
         return;
      case "LOW":
         _root._quality = "high";
         setCurrentQuality();
         return;
      default:
         setCurrentQuality();
         return;
   }
}
function toggleMusic()
{
   if(musicIsPlaying)
   {
      bgMusic.stop();
      musicIsPlaying = false;
      _root.optionsMenu.submenu_Music.gotoAndStop("off");
   }
   else
   {
      musicIsPlaying = true;
      bgMusic = new Sound(musicAmbience);
      bgMusic.attachSound("inGameMusic");
      bgMusic.setVolume(0);
      bgMusic.start(0,999999);
      bgMusic.volumeTo(20,8);
      _root.optionsMenu.submenu_Music.gotoAndStop("on");
   }
}
timeManagerOpen = false;
optionsLoaded = false;
