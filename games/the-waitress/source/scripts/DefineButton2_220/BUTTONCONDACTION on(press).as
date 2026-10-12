on(press){
   if(!_root.Scene.W.Busy)
   {
      _root.Scene.W.Tnum = 8;
      if(!_root.Scene.W.MenuActive)
      {
         _root.Wgo(1420);
      }
      else
      {
         _root.Scene.W.XDes = 1420;
      }
   }
}
