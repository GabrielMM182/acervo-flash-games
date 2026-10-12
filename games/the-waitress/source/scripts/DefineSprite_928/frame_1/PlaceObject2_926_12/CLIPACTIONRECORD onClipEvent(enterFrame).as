onClipEvent(enterFrame){
   if(_parent.List[3] > 0)
   {
      _visible = true;
      gotoAndStop(_parent.List[3]);
      if(_parent.Done[3])
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
