if(_root.macsil == false)
{
   macshot = new Sound();
   macshot.attachSound("macfire");
   macshot.start();
}
else
{
   macsilence = new Sound();
   macsilence.attachSound("macsil");
   macsilence.start();
}
