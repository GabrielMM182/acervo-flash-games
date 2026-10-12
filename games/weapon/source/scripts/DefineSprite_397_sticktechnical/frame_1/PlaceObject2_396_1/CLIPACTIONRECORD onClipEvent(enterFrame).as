onClipEvent(enterFrame){
   this.health.gotoAndStop(thishealth * 2);
   if(this._currentframe !== 3)
   {
      this._x += speed;
   }
   if(driving == false && minus == true)
   {
      speed -= 0.1;
   }
   if(speed <= 0)
   {
      minus = false;
      speed = 0;
   }
   if(this._x >= xmax && thishealth > 0 && xmaxed == false)
   {
      xmaxed = true;
      this.gotoAndStop("shoot1");
      driving = false;
   }
   if(this.hitTest(_root.gun.accuracy.shotter1.shothit._x + _root.gun.accuracy.shotter1._x + _root.gun.accuracy._x + _root.gun._x,_root.gun.accuracy.shotter1.shothit._y + _root.gun.accuracy.shotter1._y + _root.gun.accuracy._y + _root.gun._y,true) && this._currentframe !== 3)
   {
      thishealth -= _root.power;
      _root.sparkUp();
      var s = 1 + random(3);
      metaler = new Sound();
      metaler.attachSound("metal" + s);
      metaler.start();
      if(this._currentframe !== 4)
      {
         this.gotoAndStop("wounded1");
      }
   }
   i = 1;
   while(i <= 3)
   {
      if(this.hitTest(_root["damage" + i].hitter._x + _root["damage" + i]._x,_root["damage" + i].hitter._y + _root["damage" + i]._y) && this._currentframe !== 3)
      {
         this.gotoAndStop("death1");
         _parent.thishealth = 0;
      }
      i++;
   }
   if(this.hitTest(_root.a10.hitter._x + _root.a10._x,_root.a10.hitter._y + _root.a10._y) && this._currentframe !== 3)
   {
      this.gotoAndStop("death1");
      _parent.thishealth = 0;
   }
   if(thishealth <= 0 && this._currentframe !== 3)
   {
      this.gotoAndStop("death1");
      _parent.thishealth = 0;
   }
}
