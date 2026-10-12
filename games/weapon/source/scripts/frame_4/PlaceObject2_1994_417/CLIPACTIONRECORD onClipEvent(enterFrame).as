onClipEvent(enterFrame){
   this.credits = _root.credits;
   if(this._currentframe == 1 || this._currentframe == 2 && Key.isDown(32))
   {
      this.gotoAndStop(1);
   }
   if(this._currentframe == 1 && Key.isDown(32))
   {
      this.gotoAndStop(2);
      _root.pauses = true;
      _root.cursor1._visible = true;
      _root.gun._visible = false;
      _root.follower._visible = false;
   }
   if(_root.mkills == _root.wavenumber)
   {
      this.gotoAndStop(4);
      _root.pauses = true;
   }
   if(_root.secondarys == 0 && _root.primarys == 0)
   {
      this.gotoAndStop(2);
      _root.pauses = true;
   }
}
