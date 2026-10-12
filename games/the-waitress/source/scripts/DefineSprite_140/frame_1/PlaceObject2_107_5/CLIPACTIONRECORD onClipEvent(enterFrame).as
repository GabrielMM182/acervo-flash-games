onClipEvent(enterFrame){
   if(_parent.Scroll > 0)
   {
      if(_Y < 30)
      {
         _Y = _Y + _parent.Scroll;
      }
      else
      {
         _Y = 43;
      }
   }
   if(_parent.Scroll < 0 and _Y > -645)
   {
      _Y = _Y + _parent.Scroll;
   }
}
