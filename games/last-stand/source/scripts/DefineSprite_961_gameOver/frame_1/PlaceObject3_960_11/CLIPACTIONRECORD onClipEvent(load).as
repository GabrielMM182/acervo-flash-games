onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      function removeParentGameOverRetry()
      {
         _root.cleanUpScreen();
         _root.retryLevelAgain();
         removeMovieClip(_root.gameOver);
      }
      _root.mainBlackOut._visible = true;
      _root.mainBlackOut.alphaTo(100,2,"easeOutSine",0,removeParentGameOverRetry);
   };
}
