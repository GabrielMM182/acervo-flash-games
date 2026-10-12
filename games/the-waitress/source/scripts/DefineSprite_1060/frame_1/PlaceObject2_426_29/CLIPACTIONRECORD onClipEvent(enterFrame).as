onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[3] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[3]);
   }
   else
   {
      _visible = false;
   }
}
