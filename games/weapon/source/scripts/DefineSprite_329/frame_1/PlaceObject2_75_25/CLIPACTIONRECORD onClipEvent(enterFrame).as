onClipEvent(enterFrame){
   if(this.hitTest(_root.gun.accuracy.shotter1.shothit._x + _root.gun.accuracy.shotter1._x + _root.gun.accuracy._x + _root.gun._x,_root.gun.accuracy.shotter1.shothit._y + _root.gun.accuracy.shotter1._y + _root.gun.accuracy._y + _root.gun._y,true))
   {
      _parent.thishealth -= _root.power * 3;
   }
}
