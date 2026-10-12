onClipEvent(enterFrame){
   if(this._currentframe == 1 && Key.isDown(32))
   {
      _root.gotoAndStop("loadout");
   }
}
