on(press){
   if(!_parent.W.Busy)
   {
      _parent.W.Tnum = index;
      if(!_root.Scene.W.MenuActive)
      {
         _root.Wgo(_X);
      }
      else
      {
         _root.Scene.W.XDes = _X;
      }
   }
}
