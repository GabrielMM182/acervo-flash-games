onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      function removeParentGameOver()
      {
         _root.cleanUpScreen();
         _root.gotoAndStop("main");
         removeMovieClip(_parent);
      }
      _parent.mainBlackOut.alphaTo(100,2,"easeOutSine",0,removeParentGameOver);
   };
}
