onClipEvent(enterFrame){
   if(_parent.Mode >= 1.5 and _parent.Mode < 10)
   {
      _visible = true;
   }
   if(_parent.Mode >= 10)
   {
      if(_currentframe == 20 or _currentframe < 8)
      {
         gotoAndPlay(1);
         _visible = false;
      }
   }
   if(_parent.Mode < 1.5)
   {
      _visible = false;
   }
}
