on(press){
   if(!_root.Scene.W.Busy)
   {
      _root.Scene.W.Tnum = 9;
      if(!_root.StopAtDish)
      {
         if(!_root.Scene.W.MenuActive)
         {
            _root.Wgo(1195);
         }
         else
         {
            _root.Scene.W.XDes = 1195;
         }
      }
      else if(!_root.Scene.W.MenuActive)
      {
         _root.Wgo(1160);
      }
      else
      {
         _root.Scene.W.XDes = 1160;
      }
   }
}
