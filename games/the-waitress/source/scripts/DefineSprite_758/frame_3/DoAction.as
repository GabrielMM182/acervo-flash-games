i = 1;
while(i <= 8)
{
   if(_parent._currentFrame > 20 and _parent._currentFrame < 47)
   {
      index = _root.Dexchange[i - 1];
   }
   else
   {
      index = i;
   }
   if(_parent.Drinks[i] > 0)
   {
      eval("D" + index)._visible = true;
      eval("D" + index).gotoAndStop(_parent.Drinks[i]);
   }
   else
   {
      eval("D" + index)._visible = false;
   }
   i++;
}
i = 1;
while(i <= 2)
{
   if(_parent._currentFrame > 20 and _parent._currentFrame < 47)
   {
      index = 3 - i;
   }
   else
   {
      index = i;
   }
   if(_parent.Plates[i] > 0)
   {
      eval("P" + index)._visible = true;
      eval("P" + index).gotoAndStop(_parent.Plates[i]);
   }
   else
   {
      eval("P" + index)._visible = false;
   }
   i++;
}
