onClipEvent(enterFrame){
   if(pressing && _parent.clipHolder._currentframe > 1)
   {
      pressed = false;
      _parent.clipHolder.gotoAndStop(_parent.clipHolder._currentframe - 4);
   }
}
