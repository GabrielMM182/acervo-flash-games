onClipEvent(enterFrame){
   if(_root.Scene.W.Plates[1] > 0)
   {
      _visible = true;
      gotoAndStop(_root.Scene.W.Plates[1]);
   }
   else
   {
      _visible = false;
   }
}
