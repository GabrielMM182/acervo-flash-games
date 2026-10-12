if(_root.glocksil == false)
{
   glockshot = new Sound();
   glockshot.attachSound("glockshoot");
   glockshot.start();
}
else
{
   glocksilence = new Sound();
   glocksilence.attachSound("glocksil");
   glocksilence.start();
}
