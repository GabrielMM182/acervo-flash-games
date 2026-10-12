onClipEvent(enterFrame){
   speed = _root.gunspeed;
   this.onMouseDown = function()
   {
      _root.moused = true;
   };
   this.onMouseUp = function()
   {
      _root.moused = false;
   };
   Mouse.hide();
   endX = _root._xmouse;
   endY = _root._ymouse;
   _X = _X + (endX - _X) / speed;
   _Y = _Y + (endY - _Y) / speed;
}
