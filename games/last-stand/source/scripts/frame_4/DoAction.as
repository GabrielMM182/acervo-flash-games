function loadJournal()
{
   journalHolder.attachMovie("journal","journal",33221);
   journalHolder.journal.journalDayNumber.text = "DAY " + _root.levelUp;
   journalHolder.journal.journalText.text = "" + _root.journalEntries[_root.levelUp];
   journalHolder.journal.journalEntryHeading.text = "" + _root.journalEntryHeading[_root.levelUp];
   blackOutScreen.alphaTo(0,3,"easeOutSine");
}
function loadJournalFromLoadOut()
{
   loadedFromLoadOut = true;
   timeManager.timeMenu_bgDay.journalHolder.attachMovie("journal","journal",33232);
   timeManager.timeMenu_bgDay.journalHolder._alpha = 0;
   timeManager.timeMenu_bgDay.journalHolder.journal.journalDayNumber.text = "DAY " + _root.levelUp;
   timeManager.timeMenu_bgDay.journalHolder.journal.journalText.text = "" + _root.journalEntries[_root.levelUp];
   timeManager.timeMenu_bgDay.journalHolder.journal.journalEntryHeading.text = "" + _root.journalEntryHeading[_root.levelUp];
   timeManager.timeMenu_bgDay.journalHolder.journal.ySlideTo(420,0,"easeOutSine",0);
   timeManager.timeMenu_bgDay.journalHolder.alphaTo(100,0,"easeOutSine",0.2);
   timeManager.timeMenu_bgDay.journalHolder.journal.ySlideTo(10,0.8,"easeOutSine",0);
}
function closeJournal()
{
   if(loadedFromLoadOut == false)
   {
      journalHolder.journal.ySlideTo(420,1.2,"easeOutSine",0,removeJournal);
      gotoAndStop("game");
   }
   else
   {
      timeManager.timeMenu_bgDay.journalHolder.journal.ySlideTo(420,1.2,"easeOutSine",0,removeJournalFromLoadOut);
   }
}
function closeJournalFromLoadOut()
{
}
function removeJournal()
{
   removeMovieClip(journalHolder.journal);
}
function removeJournalFromLoadOut()
{
   removeMovieClip(_root.timeManager.timeMenu_bgDay.journalHolder.journal);
}
levelUp = 1;
loadedFromLoadOut = false;
journalEntryHeading = new Array();
journalEntryHeading.push("","THE LAST STAND","IT WORKED","JUST LIKE ON T.V","COP KILLER","DOGS","THIS JUST IN","FAT FARM","OH GREAT","FASTER?","PRISON BROKED","FEELING IT","THEY\'RE ONTO ME","GOD DAMN ARMOR","END OF TIME","TV","RUNNING LOW","SOLDIER","ESCAPE","THE ARMY","THE END");
journalEntries = new Array();
journalEntries.push("","I FINISHED THE WALL TODAY, IT SHOULD HOLD THEM OFF FOR A WHILE. \r\rI HOPE.\r\rTOMORROW I BETTER LOOK FOR SURVIVORS AND SOMETHING BETTER TO PROTECT MYSELF WITH. \r\rI HAVE TO GET THROUGH THE NIGHT FIRST.","WELL IT WORKED FAIRLY WELL, IT DIDN\'T FALL DOWN ON IT\'S OWN IS WHAT I MEAN.\r\rTHEY\'RE STILL JUST AS SLOW AS THE OTHERS I\'VE SEEN, DON\'T SEEM TO MAKE THE JUMP TO GET OVER THE WALL.","I\'M SHOOTING THEM IN THE HEAD LIKE THE T.V SAID, SEEMS TO STOP THEM QUICK ENOUGH.\r\rTHEY DON\'T HAVE AN EXPLAINATION FOR WHAT\'S HAPPENING THOUGH","KILLED A COP TODAY. NOT SURE HOW I FEEL ABOUT THAT, ALL\'S FAIR I GUESS. HE DROPPED A REVOLVER THAT MIGHT COME IN HANDY THOUGH.\r\rI STILL NEED MORE HANDS AROUND HERE TO GET ANYTHING DONE. SHOULD LOOK FOR MORE SURVIVORS IN THE MORNING.","WHAT EVER IT IS THAT\'S CAUSING THIS, IT\'S NOT RESTRICTED TO HUMANS. \r\rHUGE STINKING ROTTWIELERS SEEM TO BE AFFECTED TOO. MAN I HATE DOGS.","PRETTY SURE I TOPPED THE LOCAL ROVING REPORTER.\r\rWONDER IF I\'LL MAKE THE NEWS TONIGHT."
,"THESE FAT BASTARDS ARE ALL OVER THE PLACE. THEY SEEM TO TAKE WAY MORE PUNISHMENT THAN THE OTHERS.\r\rNEED SOMETHING WITH A BIT MORE KICK TO FINISH THEM OFF.","NOW THE FATTIES ARE RUNNING...GREAT.","THERE\'S SOMETHING GOING ON WITH THEM NOW, THEY\'RE GETTING FASTER AND STRONGER.\r\rTHEY\'RE SAYING THAT THEY SHOULD DIE OFF EVENTUALLY\r BUT IT JUST DOESN\'T SEEM TO BE HAPPENING.","A PRISON BUS FROM OVER AT EMERALD MUST HAVE BEEN CARRYING ONE OF THEM.\r KILLED A DOZEN OF THEM AT LEAST, BETTER THAN PRISON I GUESS","TIRED. CAN\'T WRITE. TAKING DOWN FAT ZOMBIE GUYS ALL DAY","OH OH. HAD A VISIT FROM THE ZOMBIE POLICE TODAY. GUESS THEY HEARD ABOUT ME KILLING EVERYONE.","AIM FOR THE TORSO THEY SAID, BUT NOOOOOO, NOW THE BASTARDS HAVE VESTS.\r\rDO YOU KNOW HOW HARD IT IS TO SHOOT OUT THE DAMNED LEGS.","WELL THAT\'S WHAT THE PREACHER IS SAYING. \r\r I FIND IT HARD TO BELIEVE THAT SOME DIETY IS DOING THIS, THERE HAS TO BE AN ANSWER TO IT.\r\r","SO MUCH FOR CONTACT TO THE OUTSIDE. THE TV RECEPTION DISAPPEARED LAST NIGHT, GUESS THEY FINALLY GOT INTO THE STATION. \r\r LOOKS LIKE THIS MIGHT BE IT, SOON ANYWAY."
,"WE\'VE EXHAUSTED PRETTY MUCH ALL THE FOOD IN THE AREA. \r\r WHY DID I CHOOSE SOMEWHERE SO FAR FROM THE CITIES?! GUESS WE NEED TO MAKE THE DECISION TO MOVE OR NOT. IT\'S JUST GETTING SO DANGEROUS.","RAY OF HOPE TODAY. HAD A SOLDIER APPROACH THE BARRIER TONIGHT, ALBEIT A DEAD ONE. \r\r BUT! IF HE\'S AROUND MAYBE THERE ARE OTHERS, ALIVE HOPEFULLY.","WE NEED TO MOVE IN THE NEXT FEW DAYS. THERE\'S JUST TOO MANY OF THEM, WE HAVE NO SUPPLIES LEFT. PROBLEM IS, WHERE DO WE GO?","SEEMS THE MILITARY PRESENCE HERE ARE ALL DEAD. WE\'VE STARTED MAKING PREPERATIONS TO GET OUT OF HERE.","DELAYED ANOTHER DAY...MAN THIS IS GETTING DIRE");
loadJournal();
