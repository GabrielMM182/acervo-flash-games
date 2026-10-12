onClipEvent(enterFrame){
   if(filled > 10)
   {
      Content.gotoAndStop(1);
   }
   if(filled <= 25 and filled > 0)
   {
      Content.gotoAndStop(2);
   }
   if(filled <= 0)
   {
      gotoAndStop(5);
   }
}
