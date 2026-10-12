if(_root.uspsil == false)
{
   uspshot = new Sound();
   uspshot.attachSound("uspfire");
   uspshot.start();
}
else
{
   uspsilence = new Sound();
   uspsilence.attachSound("uspsil");
   uspsilence.start();
}
