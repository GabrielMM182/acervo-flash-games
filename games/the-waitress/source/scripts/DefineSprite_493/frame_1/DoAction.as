function MD(x, y, ro)
{
   if(_parent.Place == 1)
   {
      xx = -12.4 - x;
      yy = -45.6 - y;
      rr = - ro;
   }
   else
   {
      xx = 12.6 + x;
      yy = -45.6 - y;
      rr = ro;
   }
   eval("_root.Scene.Table" + _parent.Table + ".Drink" + _parent.Place)._x = xx;
   eval("_root.Scene.Table" + _parent.Table + ".Drink" + _parent.Place)._y = yy;
   eval("_root.Scene.Table" + _parent.Table + ".Drink" + _parent.Place)._rotation = rr;
}
