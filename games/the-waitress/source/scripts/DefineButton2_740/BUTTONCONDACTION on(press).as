on(press){
   if(!_root.Scene.W.Busy)
   {
      if(!_root.Scene.W.MenuActive)
      {
         _root.Wgo(1475 - _root.PinB * 5);
      }
      else
      {
         _root.Scene.W.XDes = 1475 - _root.PinB * 5;
      }
      _root.Scene.W.Tnum = 7;
   }
}
