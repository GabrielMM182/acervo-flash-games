onClipEvent(enterFrame){
   if(this._xscale > scalex)
   {
      this._xscale -= 30;
   }
   if(this._xscale < scalex)
   {
      this._xscale = scalex;
   }
   if(this._yscale > scaley)
   {
      this._yscale -= 30;
   }
   if(this._yscale < scaley)
   {
      this._yscale = scaley;
   }
   if(this._alpha < alpha)
   {
      this._alpha += 10;
   }
}
