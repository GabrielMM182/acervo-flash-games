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
      _root.cursor1.desc = "See through items are things you do not have. Click them to go to their store section.";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
