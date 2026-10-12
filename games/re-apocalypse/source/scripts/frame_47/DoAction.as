function startSound()
{
   if(soundstate == "off")
   {
      sfire.start(0,999);
      sambience.start(0,999);
      soundstate = "on";
   }
}
function stopSound()
{
   sfire.stop();
   sambience.stop();
   soundstate = "off";
}
var sidestate;
var soundstate = "on";
sfire = new Sound();
sfire.attachSound("fire1");
sfire.setVolume(100);
sfire.start(0,999);
sambience = new Sound();
sambience.attachSound("ambience");
sambience.setVolume(100);
sambience.start(0,999);
play();
