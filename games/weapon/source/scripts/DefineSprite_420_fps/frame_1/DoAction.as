fps = 30;
var timeinit = new Date();
var lasttime = timeinit.getMilliseconds();
onEnterFrame = function()
{
   var _loc1_ = new Date();
   timepassed = _loc1_.getMilliseconds() - lasttime < 0 ? 1000 + (_loc1_.getMilliseconds() - lasttime) : _loc1_.getMilliseconds() - lasttime;
   fps = Math.round(10000 / timepassed) / 10;
   lasttime = _loc1_.getMilliseconds();
};
