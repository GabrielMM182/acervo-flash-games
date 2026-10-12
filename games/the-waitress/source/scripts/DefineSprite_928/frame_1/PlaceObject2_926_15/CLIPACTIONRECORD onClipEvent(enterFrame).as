onClipEvent(enterFrame){
   if(_parent.List[4] > 0)
   {
      _visible = true;
      gotoAndStop(_parent.List[4]);
      if(_parent.Done[4])
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
