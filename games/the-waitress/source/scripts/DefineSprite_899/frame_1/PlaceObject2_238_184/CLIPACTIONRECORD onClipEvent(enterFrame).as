onClipEvent(enterFrame){
   if(_root.TrashCan < 17)
   {
      gotoAndStop(1);
   }
   if(_root.TrashCan >= 17 and _root.TrashCan < 20)
   {
      gotoAndStop(2);
   }
   if(_root.TrashCan >= 20)
   {
      gotoAndStop(3);
   }
}
