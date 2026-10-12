function showCrosshairs()
{
   _root.aimer.gotoAndStop("crosshair");
   Mouse.hide();
}
function hideCrosshairs()
{
   _root.aimer.gotoAndStop("cursor");
   Mouse.show();
}
stop();
fscommand("allowscale",false);
stopChainsawIdle();
if(firstLoad == true)
{
   firstLoad = false;
   preLoaderCombo.alphaTo(0,2,"easeOutSine");
}
else
{
   preLoaderCombo._visible = false;
}
if(mouseInitialised == "notyet")
{
   _root.attachMovie("aimingReticle","aimer",900300);
   aimer.startDrag("true");
   Mouse.hide();
   hideCrosshairs();
   mouseInitialised = "soup";
}
hideCrosshairs();
Key.removeListener(keyListener);
