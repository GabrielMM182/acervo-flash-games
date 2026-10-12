this.number = 0;
dragger.onPress = function()
{
   this.startDrag(true,0,0,line._width,0);
   this.onEnterFrame = function()
   {
      number = Math.round(this._x * (1000 - _root.health) / line._width);
   };
};
dragger.onRelease = dragger.onreleaseOutside = stopDrag;
