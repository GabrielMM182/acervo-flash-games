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
      _root.cursor1.desc = "This is where you repair the Black Hawk. If it reaches 0 it is game over.";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
