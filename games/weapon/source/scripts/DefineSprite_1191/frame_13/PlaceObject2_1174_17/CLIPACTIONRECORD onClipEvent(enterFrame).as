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
      _root.cursor1.desc = "This is the current weapon\'s stats. The more white the better.";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
