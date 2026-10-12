onClipEvent(enterFrame){
   _parent._x += 20;
   _parent._y += Math.random() - Math.random();
   if(_parent._x >= _root.sparkx + 50)
   {
      _root.sparkx = 550 + random(80);
      _root.health -= 50 + random(50);
      _root.deltahealth -= random(20);
      _parent.gotoAndStop(2);
   }
}
