onClipEvent(enterFrame){
   if(this._currentframe == 1 && _root.a10s > 0 && Key.isDown(67) && _root.pauses == false)
   {
      this.play();
      _root.a10s--;
   }
}
