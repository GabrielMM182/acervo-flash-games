onClipEvent(enterFrame){
   if(_root._currentFrame == 5)
   {
      gotoAndStop(1);
   }
   else
   {
      gotoAndStop(2);
   }
   if(_root.getBytesLoaded() < _root.getBytesTotal())
   {
      _visible = false;
      _root.Clock._visible = true;
      _root.Logos._visible = true;
   }
   else
   {
      _visible = true;
      _root.Clock._visible = false;
      _root.preloadtext = "";
      _root.Logos._visible = false;
   }
}
