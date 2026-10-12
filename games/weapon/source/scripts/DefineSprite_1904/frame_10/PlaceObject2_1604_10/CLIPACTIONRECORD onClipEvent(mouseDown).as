onClipEvent(mouseDown){
   if(_root.pauses == false && _root.cover == false && _root.gun.gunsel._currentframe == 2 && _root.mag > 0)
   {
      _root.gun.gunsel.gotoAndStop("shoot1");
   }
   if(_root.mags >= 1 && _root.mag == 0 && _root.gun.gunsel._currentframe == 2)
   {
      _root.gun.gunsel.gotoAndStop("reload1");
   }
}
