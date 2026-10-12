onClipEvent(enterFrame){
   if(_parent.List[2] > 0)
   {
      _visible = true;
      gotoAndStop(_parent.List[2]);
      if(_parent.Done[2])
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
