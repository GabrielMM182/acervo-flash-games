onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      _root.cleanUpScreen();
      _root.gotoAndPlay(1);
      removeMovieClip(_root.endingAnim);
   };
}
