onClipEvent(enterFrame){
   if(eval("_root.Scene.C" + _root.Scene.Table1.Places[1]).Mode > 1 or eval("_root.Scene.C" + _root.Scene.Table1.Places[2]).Mode > 1)
   {
      Oc._visible = true;
   }
   else
   {
      Oc._visible = false;
   }
}
