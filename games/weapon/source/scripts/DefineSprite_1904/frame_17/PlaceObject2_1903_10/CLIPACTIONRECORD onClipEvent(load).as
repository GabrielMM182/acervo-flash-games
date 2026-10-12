onClipEvent(load){
   xpos = this._x;
   ypos = this._y;
   rotation = this._rotation;
   _root.accnum = 4;
   _root.power = 2;
   if(_root.ak2sight == 0)
   {
      this.scopes.scope.gotoAndStop(1);
   }
   else if(_root.ak2sight == 1)
   {
      this.scopes.scope.gotoAndStop(2);
   }
   else if(_root.ak2sight == 2)
   {
      this.scopes.scope.gotoAndStop(3);
   }
   else if(_root.ak2sight == 3)
   {
      this.scopes.scope.gotoAndStop(4);
   }
   else if(_root.ak2sight == 4)
   {
      this.scopes.scope.gotoAndStop(5);
   }
}
