onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      _root.cleanUpScreen();
      _root.gotoAndStop("main");
      removeMovieClip(_root.endingAnim);
   };
}
