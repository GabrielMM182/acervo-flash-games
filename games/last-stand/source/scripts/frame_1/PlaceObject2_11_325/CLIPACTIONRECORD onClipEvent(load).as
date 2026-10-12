onClipEvent(load){
   this._visible = false;
   this.onRelease = function()
   {
      _root.gotoAndPlay("main");
   };
}
