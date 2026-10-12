onClipEvent(enterFrame){
   if(this.hitTest(_root._xmouse,_root._ymouse,true))
   {
      thisover = true;
   }
   else
   {
      thisover = false;
   }
   onRollOver = function()
   {
      _root.cursor1.gotoAndStop(3);
      _root.cursor1.desc = "This section shows your current weapons, attachments, and equipment.";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
