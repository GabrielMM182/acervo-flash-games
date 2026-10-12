onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[2] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[2]);
   }
   else
   {
      _visible = false;
   }
}
