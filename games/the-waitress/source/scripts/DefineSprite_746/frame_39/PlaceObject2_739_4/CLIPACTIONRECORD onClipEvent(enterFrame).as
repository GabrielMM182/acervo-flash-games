onClipEvent(enterFrame){
   if(_root.PinB <= 0)
   {
      Plates._visible = false;
   }
   else
   {
      Plates._visible = true;
      Plates.gotoAndStop(_root.PinB);
   }
}
