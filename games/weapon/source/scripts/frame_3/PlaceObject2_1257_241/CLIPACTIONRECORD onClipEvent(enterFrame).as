onClipEvent(enterFrame){
   this._x = _root.follower._x;
   if(Key.isDown(71) && _root.grenades > 0)
   {
      gdown = true;
   }
   else
   {
      gdown = false;
   }
   if(gdown == true && _root.pauses == false)
   {
      this.gotoAndStop(2);
      this._visible = true;
      _root.follower._visible = false;
      nading = true;
   }
   else
   {
      if(nading == true && throwable == true && _root._currentframe == 4)
      {
         _root.nadeAdd.attachMovie("grenade","grenade" + _root.grenadenum,_root.grenadenum,{_x:this._x - _root.nadeAdd._x + (-10 + random(20)),_y:this._y - _root.nadeAdd._y + (-5 + random(10))});
         _root.grenadenum++;
         _root.grenades--;
         nading = false;
         throwable = false;
      }
      this.gotoAndStop(1);
      this._visible = false;
      _root.follower._visible = true;
   }
}
