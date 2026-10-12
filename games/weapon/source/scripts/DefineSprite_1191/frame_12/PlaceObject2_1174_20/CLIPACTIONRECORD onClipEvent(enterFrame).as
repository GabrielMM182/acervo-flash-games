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
      _root.cursor1.desc = "Load bearing equipment enables you to carry extra ammunition.";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
