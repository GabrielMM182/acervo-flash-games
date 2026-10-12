onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[7] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[7]);
   }
   else
   {
      _visible = false;
   }
}
