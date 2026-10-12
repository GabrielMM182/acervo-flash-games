on(press){
   if(!_root.Scene.W.Busy)
   {
      _root.Scene.W.Tnum = 10;
      if(!_root.Scene.W.MenuActive)
      {
         _root.Wgo(1310);
      }
      else
      {
         _root.Scene.W.XDes = 1310;
      }
   }
}
