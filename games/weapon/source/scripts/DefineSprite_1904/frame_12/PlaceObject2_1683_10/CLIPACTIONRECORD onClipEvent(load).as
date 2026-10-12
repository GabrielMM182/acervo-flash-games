onClipEvent(load){
   xpos = this._x;
   ypos = this._y;
   rotation = this._rotation;
   _root.accnum = 2;
   _root.power = 3;
   if(_root.aksight == 0)
   {
      this.scopes.scope.gotoAndStop(1);
   }
   else if(_root.aksight == 1)
   {
      this.scopes.scope.gotoAndStop(2);
   }
   else if(_root.aksight == 2)
   {
      this.scopes.scope.gotoAndStop(3);
   }
   else if(_root.aksight == 3)
   {
      this.scopes.scope.gotoAndStop(4);
   }
   else if(_root.aksight == 4)
   {
      this.scopes.scope.gotoAndStop(5);
   }
}
