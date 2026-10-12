onClipEvent(enterFrame){
   if(pressing && _parent.clipHolder._currentframe < _parent.clipHolder._totalframes)
   {
      pressed = false;
      _parent.clipHolder.gotoAndStop(_parent.clipHolder._currentframe + 4);
   }
}
