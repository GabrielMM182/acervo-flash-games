onClipEvent(load){
   this.butLabel.text = "MAIN MENU";
   this.onRelease = function()
   {
      function removeParentGameOver()
      {
         _root.mainChar.removeMovieClip();
         _root.hud.removeMovieClip();
         _root.cleanUpScreen();
         _root.cleanUpSurvivors();
         _root.removeSurvivors();
         delete game.onEnterFrame;
         _root.gotoAndStop("main");
         _root.mainBlackOut.removeMovieClip();
         _root.timeManager.removeMovieClip();
         _parent.removeMovieClip();
      }
      _root.mainBlackOut.alphaTo(100,2,"easeOutSine",0,removeParentGameOver);
   };
}
