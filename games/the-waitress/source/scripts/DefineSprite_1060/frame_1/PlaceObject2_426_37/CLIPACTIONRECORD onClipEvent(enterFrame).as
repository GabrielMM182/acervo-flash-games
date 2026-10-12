onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[5] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[5]);
   }
   else
   {
      _visible = false;
   }
}
