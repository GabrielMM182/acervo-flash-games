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
      _root.cursor1.gotoAndStop(2);
      _root.cursor1.desc = "Glock";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
