on(release){
   if(flixbox == "")
   {
      error.gotoAndStop(2);
      error.detail = "desired FlixBox";
   }
   else if(firstname == "")
   {
      errormessage.gotoAndStop("firstname");
   }
   else if(surname == "")
   {
      errormessage.gotoAndStop("surname");
   }
   else if(address1 == "")
   {
      errormessage.gotoAndStop("address");
   }
   else if(town == "")
   {
      errormessage.gotoAndStop("town");
   }
   else if(postcode == "")
   {
      errormessage.gotoAndStop("postcode");
   }
   else if(email == "")
   {
      errormessage.gotoAndStop("email");
   }
   else if(dob == "dd/mm/yyyy")
   {
      errormessage.gotoAndStop("dateof");
   }
   else
   {
      loadVariablesNum("http://www.hyperlaunch.com/cgi-bin/residentevil/comp.pl?answer=" + _root.answer + "&title=" + title + "&firstname=" + firstname + "&surname=" + surname + "&address1=" + address1 + "&address2=" + address2 + "&town=" + town + "&postcode=" + postcode + "&email=" + email + "&age=" + age + "&dob=" + dob + "&children=" + children + "&owndvd=" + owndvd + "&ownpc=" + ownpc + "&ownps2=" + ownps2 + "&ownxbox=" + ownxbox + "&cinema=" + cinema + "&optin=" + optin,10);
      gotoAndStop("thankyou");
      play();
   }
}
