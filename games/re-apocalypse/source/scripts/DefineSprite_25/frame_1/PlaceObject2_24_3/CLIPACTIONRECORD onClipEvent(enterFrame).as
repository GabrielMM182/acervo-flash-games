onClipEvent(enterFrame){
   total = _root.getBytesTotal();
   sofar = _root.getBytesLoaded();
   percent = Math.floor(sofar / total * 100);
   this._x = startPos + percent * 4;
   if(percent == 100 and done == 0)
   {
      _root.gotoAndPlay("start");
      done = 1;
   }
}
