onClipEvent(enterFrame){
   if(_parent.clipHolder._totalframes > 1)
   {
      this.nowPlaying = _parent.clipHolder._currentframe / _parent.clipHolder._totalframes * 100;
   }
   else
   {
      nowPlaying = 0;
   }
   if(pressing)
   {
      if(_parent._xmouse >= startX + this._width / 2 && _parent._xmouse <= startX + (_parent.theWidth - this._width))
      {
         this._x = _parent._xmouse;
      }
      else if(_parent._xmouse < startX + this._width / 2)
      {
         this._x = startX + this._width / 2;
      }
      else if(_parent._xmouse > startX + (_parent.theWidth - this._width / 2))
      {
         this._x = startX + (_parent.theWidth - this._width / 2);
      }
      _parent.clipHolder.gotoAndStop(Math.round(_parent.clipHolder._totalframes / (_parent.theWidth - this._width) * (this._x - (startX + this._width / 2))));
   }
   else
   {
      this._x = startX + this._width / 2 + (_parent.theWidth - this._width) / 100 * nowPlaying;
   }
}
