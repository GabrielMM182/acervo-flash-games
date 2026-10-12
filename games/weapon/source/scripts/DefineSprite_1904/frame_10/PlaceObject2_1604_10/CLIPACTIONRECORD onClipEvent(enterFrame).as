onClipEvent(enterFrame){
   if(_root.accnum > 4)
   {
      _root.accnum -= 1;
   }
   if(this._x > xpos)
   {
      this._x -= 1;
   }
   if(this._x < xpos)
   {
      this._x = xpos;
   }
   if(this._y < ypos)
   {
      this._y += 1;
   }
   if(this._y > ypos)
   {
      this._y = ypos;
   }
   if(this._rotation > rotation)
   {
      this._rotation -= 1.5;
   }
   if(this._rotation < rotation)
   {
      this._rotation = rotation;
   }
   if(_root.pauses == false && _root.mags >= 1 && _root.mag !== _root.magcap && Key.isDown(82) && _root.gun.gunsel._currentframe == 2)
   {
      _root.gun.gunsel.gotoAndStop("reload1");
   }
   if(_root.pauses == false && Key.isDown(81) && _root.gun.gunsel._currentframe == 2)
   {
      _root.gun.gunsel.gotoAndStop("holster");
      _root.hud.gundisplay.play();
   }
}
