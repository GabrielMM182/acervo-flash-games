onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[8] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[8]);
   }
   else
   {
      _visible = false;
   }
}
