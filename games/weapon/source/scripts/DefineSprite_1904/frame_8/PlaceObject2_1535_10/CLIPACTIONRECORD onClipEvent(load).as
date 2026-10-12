onClipEvent(load){
   xpos = this._x;
   ypos = this._y;
   rotation = this._rotation;
   _root.accnum = 1;
   _root.power = 3;
   if(_root.m14sight == 0)
   {
      this.scopes.scope.gotoAndStop(1);
   }
   else if(_root.m14sight == 1)
   {
      this.scopes.scope.gotoAndStop(2);
   }
   else if(_root.m14sight == 2)
   {
      this.scopes.scope.gotoAndStop(3);
   }
   else if(_root.m14sight == 3)
   {
      this.scopes.scope.gotoAndStop(4);
   }
   else if(_root.m14sight == 4)
   {
      this.scopes.scope.gotoAndStop(5);
   }
   else if(_root.m14sight == 5)
   {
      this.scopes.scope.gotoAndStop(6);
   }
}
