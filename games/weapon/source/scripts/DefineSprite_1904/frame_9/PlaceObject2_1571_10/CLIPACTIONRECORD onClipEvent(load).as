onClipEvent(load){
   xpos = this._x;
   ypos = this._y;
   rotation = this._rotation;
   _root.accnum = 5;
   _root.power = 1;
   if(_root.mp5sight == 0)
   {
      this.sight.sights.gotoAndStop(1);
   }
   if(_root.mp5sight == 1)
   {
      this.sight.sights.gotoAndStop(2);
   }
   if(_root.mp5sight == 2)
   {
      this.sight.sights.gotoAndStop(3);
   }
   if(_root.mp5sight == 3)
   {
      this.sight.sights.gotoAndStop(4);
   }
   if(_root.mp5sight == 4)
   {
      this.sight.sights.gotoAndStop(5);
   }
   if(_root.mp5grip == 0)
   {
      this.grip.gripimg.gotoAndStop(1);
   }
   if(_root.mp5grip == 1)
   {
      this.grip.gripimg.gotoAndStop(2);
   }
   if(_root.mp5grip == 2)
   {
      this.grip.gripimg.gotoAndStop(3);
   }
}
