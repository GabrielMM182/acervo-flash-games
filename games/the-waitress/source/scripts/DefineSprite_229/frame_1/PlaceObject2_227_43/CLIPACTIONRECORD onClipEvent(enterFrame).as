onClipEvent(enterFrame){
   if(_root.Cups == 0)
   {
      _visible = false;
   }
   else
   {
      _visible = true;
      gotoAndStop(_root.Cups);
   }
}
