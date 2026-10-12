onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      function removeParentGameOver()
      {
         _root.mainChar.removeMovieClip();
         _root.hud.removeMovieClip();
         _root.cleanUpScreen();
         _root.removeSurvivors();
         delete game.onEnterFrame;
         _root.gotoAndStop("main");
         removeMovieClip(_parent);
      }
      _parent.mainBlackOut.alphaTo(100,2,"easeOutSine",0,removeParentGameOver);
   };
}
