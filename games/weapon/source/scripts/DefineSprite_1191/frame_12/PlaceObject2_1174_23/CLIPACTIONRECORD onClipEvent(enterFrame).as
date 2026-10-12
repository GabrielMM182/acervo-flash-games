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
      _root.cursor1.desc = "This shows the BlackHawk health. You can repair it in the loadout.";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
