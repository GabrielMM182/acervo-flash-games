onClipEvent(enterFrame){
   if(_parent.List[1] > 0)
   {
      _visible = true;
      gotoAndStop(_parent.List[1]);
      if(_parent.Done[1])
      {
         Done._visible = true;
      }
      else
      {
         Done._visible = false;
      }
   }
   else
   {
      _visible = false;
   }
}
