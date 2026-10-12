onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      function removeParent()
      {
         removeMovieClip(_parent);
         loadFromInstructions(mainMenu);
      }
      _parent.alphaTo(0,0.8,"easeOutSine",0,removeParent);
   };
}
