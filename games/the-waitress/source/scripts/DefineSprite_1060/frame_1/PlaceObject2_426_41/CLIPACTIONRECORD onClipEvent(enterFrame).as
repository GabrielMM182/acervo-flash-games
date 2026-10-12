onClipEvent(enterFrame){
   if(_root.Scene.W.Drinks[6] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Drinks[6]);
   }
   else
   {
      _visible = false;
   }
}
