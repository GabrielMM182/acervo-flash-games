function doEnterFrame()
{
   f++;
   var _loc2_;
   var _loc3_;
   var _loc1_;
   if(f % c == 0)
   {
      _loc2_ = getTimer();
      _loc3_ = _loc2_ - lastMeasured;
      lastMeasured = _loc2_;
      _loc1_ = c / _loc3_ * 1000;
      framerate_txt.text = "fps = " + String(setFloatPrecision(_loc1_,2));
      createGraphPixel(f / c,displayRoot.bg._height - _loc1_);
   }
}
function createBackdrop()
{
   var _loc4_ = [2,128,40,false,"normal","round","round",3];
   var _loc1_ = 200;
   bgWidth = _loc1_;
   var _loc3_ = 120;
   var _loc2_ = createRectangle(displayRoot,"bg",16777215,100,_loc1_,_loc3_,_loc4_);
   _loc2_._x = 10;
   _loc2_._y = 50;
}
function createGraphDisplay(yval)
{
   var _loc1_ = createMc(displayRoot.bg,"displayClip");
   _loc1_.lineStyle(1,10485760,70,false,"normal","round","round",3);
   if(yval == undefined)
   {
      yval = displayRoot.bg._height - 12;
   }
   _loc1_.moveTo(1,yval);
}
function createGraphPixel(x, y)
{
   var _loc1_ = x % bgWidth;
   if(_loc1_ == 0)
   {
      displayRoot.bg.displayClip.removeMovieClip();
      createGraphDisplay(y);
   }
   if(_loc1_ > 0)
   {
      history.push({frame:x * 10,fps:y});
      displayRoot.bg.displayClip.lineTo(_loc1_,y);
   }
}
function setFloatPrecision(inValue, decimals)
{
   d = Math.pow(10,decimals);
   return Math.round(inValue * d) / d;
}
function createRectangle(attachTimeLine, idName, bgCol, alpha, width, height, lineStyle, depth)
{
   if(depth == undefined)
   {
      depth = attachTimeLine.getNextHighestDepth();
   }
   var _loc1_ = attachTimeLine.createEmptyMovieClip(idName,depth);
   _loc1_.beginFill(bgCol,alpha);
   _loc1_.lineStyle.apply(_loc1_,lineStyle);
   _loc1_.lineTo(0,height);
   _loc1_.lineTo(width,height);
   _loc1_.lineTo(width,0);
   _loc1_.lineTo(0,0);
   return _loc1_;
}
function createMc(attachTimeLine, idName, depth, dynamicNaming)
{
   if(depth == undefined)
   {
      depth = attachTimeLine.getNextHighestDepth();
   }
   var _loc2_;
   if(dynamicNaming)
   {
      _loc2_ = attachTimeLine.createEmptyMovieClip(idName + String(depth),depth);
   }
   else
   {
      _loc2_ = attachTimeLine.createEmptyMovieClip(idName,depth);
   }
   return _loc2_;
}
var displayRoot = this;
var history;
var lastMeasured = getTimer();
var f = 0;
var c = 10;
var bgWidth;
createBackdrop();
createGraphDisplay();
this.onEnterFrame = doEnterFrame;
this.onPress = function()
{
   this.onMouseMove = function()
   {
      updateAfterEvent();
   };
   this.startDrag();
};
this.onRelease = function()
{
   this.onMouseMove = null;
   this.stopDrag();
};
