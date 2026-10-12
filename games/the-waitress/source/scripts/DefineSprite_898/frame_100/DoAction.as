if(ServeDish and !Clean)
{
   eval("_root.Scene.Table" + Tnum).Plate1._x = -26.6;
   eval("_root.Scene.Table" + Tnum).Plate1._y = -43.2;
}
if(!Clean)
{
   PutSound.start();
}
