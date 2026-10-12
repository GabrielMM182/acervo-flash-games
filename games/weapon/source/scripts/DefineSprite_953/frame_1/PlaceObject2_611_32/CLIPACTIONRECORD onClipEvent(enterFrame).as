onClipEvent(enterFrame){
   if(_root.uspbuy == 0)
   {
      this._alpha = 40;
   }
   else
   {
      this._alpha = 100;
   }
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
      _root.cursor1.desc = "USP";
   };
   onRollOut = function()
   {
      _root.cursor1.gotoAndStop(1);
   };
}
