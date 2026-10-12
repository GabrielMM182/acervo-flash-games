if(_root.aksil == false)
{
   akshot = new Sound();
   akshot.attachSound("akfire");
   akshot.start();
}
else
{
   aksilence = new Sound();
   aksilence.attachSound("aksil");
   aksilence.start();
}
