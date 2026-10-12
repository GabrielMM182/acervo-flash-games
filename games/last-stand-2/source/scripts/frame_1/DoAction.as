function urlChecker()
{
   if(urlCheckerOn == true)
   {
      urlStart = _url.indexOf("://") + 3;
      urlEnd = _url.indexOf("/",urlStart);
      domain = _url.substring(urlStart,urlEnd);
      LastDot = domain.lastIndexOf(".") - 1;
      pfixEnd = domain.lastIndexOf(".",LastDot) + 1;
      domain = domain.substring(pfixEnd,domain.length);
      if(domain != "" && domain != "armorgames.com")
      {
         securityImage._visible = true;
         preloaderPlayButton._x = -30000;
         preloaderPlayButton._y = -30000;
      }
      else
      {
         securityImage._visible = false;
         init();
      }
   }
   else
   {
      securityImage._visible = false;
      init();
   }
}
function init()
{
   _quality = "high";
   mouseInitialised = "notyet";
   this.onEnterFrame = function()
   {
      update();
   };
}
function update()
{
   var _loc3_ = this.getBytesLoaded();
   var _loc4_ = this.getBytesTotal();
   var _loc2_ = Math.round(_loc3_ / _loc4_ * 100);
   percentage = _loc2_ + "%";
   preLoaderCombo.percentageTotal.text = percentage;
   preLoaderCombo.gameTitle._alpha = _loc2_;
   preLoaderCombo.preloader.loadBar._xscale = _loc2_;
   if(_loc2_ >= 100)
   {
      onLoadComplete();
      delete this.onEnterFrame;
   }
}
function onLoadComplete()
{
   firstLoad = true;
   mainMenuLoadedOnce = false;
   preloaderPlayButton._alpha = 100;
   preloaderPlayButton._visible = true;
   preloaderPlayButton.scribbleCircle.play();
}
Stage.showMenu = false;
stop();
goodURL = false;
urlCheckerOn = true;
urlChecker();
