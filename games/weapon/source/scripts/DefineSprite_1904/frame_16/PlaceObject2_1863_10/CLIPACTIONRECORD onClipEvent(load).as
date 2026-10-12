onClipEvent(load){
   xpos = this._x;
   ypos = this._y;
   rotation = this._rotation;
   _root.accnum = 7;
   _root.power = 1;
   if(_root.tmpsight == 0)
   {
      _root.gun.gunsel.scope.scopes.gotoAndStop(1);
   }
   if(_root.tmpsight == 1)
   {
      _root.gun.gunsel.scope.scopes.gotoAndStop(2);
   }
   if(_root.tmpsight == 2)
   {
      _root.gun.gunsel.scope.scopes.gotoAndStop(3);
   }
   if(_root.tmpsight == 3)
   {
      _root.gun.gunsel.scope.scopes.gotoAndStop(4);
   }
}
