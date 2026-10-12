on(press){
   if(name eq "")
   {
      errormessage.gotoAndStop("firstname");
   }
   else if(email eq "")
   {
      errormessage.gotoAndStop("surname");
   }
   if(email ne "" && name ne "")
   {
      url = "http://www.hyperlaunch.co.uk/cgi-bin/residentevil/submitscore.pl";
      loadVariables(url,this,"POST");
      play();
   }
}
