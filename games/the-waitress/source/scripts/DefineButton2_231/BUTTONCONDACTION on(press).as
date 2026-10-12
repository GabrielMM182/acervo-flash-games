on(press){
   if(!_root.Scene.W.Busy)
   {
      _root.Scene.W.Tnum = 6;
      if(!_root.Scene.W.MenuActive)
      {
         _root.Wgo(1230);
      }
      else
      {
         _root.Scene.W.XDes = 1230;
      }
   }
}
