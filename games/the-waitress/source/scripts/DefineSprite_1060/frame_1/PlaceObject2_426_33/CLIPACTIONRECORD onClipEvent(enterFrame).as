onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[4] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[4]);
   }
   else
   {
      _visible = false;
   }
}
