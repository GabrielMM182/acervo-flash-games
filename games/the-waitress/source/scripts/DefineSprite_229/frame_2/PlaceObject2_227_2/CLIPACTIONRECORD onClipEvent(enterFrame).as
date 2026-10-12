onClipEvent(enterFrame){
   if(_Y < 61.5 - _root.Cups * 5)
   {
      _Y = _Y + 5;
   }
   else
   {
      _root.Cups += _parent.CupN;
      _parent.gotoAndStop(1);
   }
}
