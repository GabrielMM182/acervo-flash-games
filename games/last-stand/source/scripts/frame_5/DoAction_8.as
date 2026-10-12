function loadTimeManager()
{
   chainsawSound.stop("sound_chainsawIdle");
   stopChainsawIdle();
   timeManagerOpen = true;
   if(retryLevel == false)
   {
      levelUp++;
   }
   pauseGame();
   _root.attachMovie("timeManager","timeManager",500021);
   timeManager.blackOut.alphaTo(100,2,"easeOutSine",0.8,startTimeManager);
   hoursSpentSurvivors = 0;
   hoursSpentWeapons = 0;
   hoursSpentRepairingWall = 0;
   wallRepairs = 0;
   survivorsFound = 0;
   searchPartyMembersKilled = 0;
   hoursInDay = 12;
   searchFoundAWeapon = 0;
}
function startTimeManager()
{
   hideCrosshairs();
   bgMusic.volumeTo(5,3,"easeOutSine");
   cleanUpZombies();
   timeManager.gotoAndStop("timeManage");
   timeManager.blackOut.alphaTo(0,3,"easeOutSine");
   updateClipBoardText();
   weaponMeter();
   if(survivors >= maxHelpers)
   {
      timeManager.theClipBoard.noVacancy._visible = true;
   }
   else
   {
      timeManager.theClipBoard.noVacancy._visible = false;
   }
   if(retryLevel == true)
   {
      calculateFindings();
      confirmResults();
   }
   else
   {
      clipBoardUp();
   }
   loadHints();
}
function closeManager()
{
   cleanUpZombies();
   if(_root.primaryWeapon != undefined)
   {
      showCrosshairs();
      bgMusic.volumeTo(20,8,"easeOutSine");
      trace("I\'m closin\' already!");
      retryLevel = false;
      _root.timeManager.blackOut.alphaTo(100,2,"easeOutSine",0,startNextLevel);
   }
   else
   {
      trace("???????  NO WEAPON SELECTED IN PRIMARY SLOT  ??????????");
      _root.timeManager.timeMenu_bgDay.needAWeapon.alphaTo(100,1);
   }
}
function updateClipBoardText()
{
   clearInterval(updateClipBoard);
   timeManager.theClipBoard.hoursRemaining.text = hoursInDay;
   timeManager.theClipBoard.hoursSurvivors.text = hoursSpentSurvivors;
   timeManager.theClipBoard.hoursWeapons.text = hoursSpentWeapons;
   timeManager.theClipBoard.hoursRepairingWall.text = hoursSpentRepairingWall;
   timeManager.theClipBoard.repairRateText.text = Math.round(repairRate * survivors / 100);
   timeManager.clipBoardResults.wallRepairedBy.text = Math.round(wallRepairs / 100);
   timeManager.clipBoardResults.survivorsFound.text = survivorsFound;
   timeManager.clipBoardResults.survivorsKilled.text = searchPartyMembersKilled;
   timeManager.clipBoardResults.clipBoardDay.text = debugDay;
   timeManager.theClipBoard.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.clipBoardResults.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.theClipBoard.survivorsTotal.text = survivors;
   timeManager.clipBoardResults.survivorsTotal.text = survivors;
}
function resetClipBoardText()
{
   timeManager.theClipBoard.hoursRemaining.text = "12";
   timeManager.theClipBoard.hoursSurvivors.text = "0";
   timeManager.theClipBoard.hoursWeapons.text = "0";
   timeManager.theClipBoard.hoursRepairingWall.text = "0";
   timeManager.clipBoardResults.wallRepairedTo.text = "0";
   timeManager.clipBoardResults.survivorsFound.text = "0";
   timeManager.clipBoardResults.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.theClipBoard.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.clipBoardResults.foundWeapons.text = "";
}
function calculateFindings()
{
   tempWallHealth = wall.health;
   wallRepairs = hoursSpentRepairingWall * repairRate * survivors;
   wall.health += wallRepairs;
   checkWallStatus();
   if(wall.health > 0)
   {
      wall.destroyed = false;
   }
   if(wall.health >= wall.maxHealth)
   {
      wallRepairs = wall.maxHealth - tempWallHealth;
      wall.health = wall.maxHealth;
   }
   checkWallStatus();
   startOfLevelWallHealth = wall.health;
   trace("REPAIRS DONE: " + wallRepairs);
   trace("WALL\'s HEALTH: " + wall.health);
   if(hoursSpentSurvivors <= 5 && hoursSpentSurvivors > 0)
   {
      survivorsFound += random(2);
   }
   else if(hoursSpentSurvivors <= 10 && hoursSpentSurvivors > 5)
   {
      survivorsFound += random(2) + 1;
   }
   else if(hoursSpentSurvivors > 10)
   {
      survivorsFound += random(2) + 2;
   }
   if(survivorsFound + survivors >= maxHelpers)
   {
      survivorsFound = maxHelpers - survivors;
   }
   trace("!!!! SURVIVORS FOUND: " + survivorsFound);
   survivors += survivorsFound;
   if(hoursSpentWeapons >= 5)
   {
      searchPartyMembersKilled += random(2);
   }
   else if(hoursSpentWeapons >= 10)
   {
      searchPartyMembersKilled += random(3);
   }
   else if(hoursSpentWeapons > 10)
   {
      searchPartyMembersKilled += random(3) + 1;
   }
   trace("<<<< SURVIVORS KILLED: " + searchPartyMembersKilled);
   if(survivors - searchPartyMembersKilled <= 1)
   {
      survivors = 1;
   }
   else
   {
      survivors -= searchPartyMembersKilled;
   }
   if(_root[currentLevel].findWeapon == true && retryLevel == false)
   {
      pickedUpWeapon = _root[currentLevel].weaponFound;
      if(_root[pickedUpWeapon].found != true)
      {
         nextWeaponPoint++;
         _root[pickedUpWeapon].found = true;
         droppedWeapon = "" + _root[pickedUpWeapon].description + " \r";
         timeManager.clipBoardResults.foundWeapons.text += droppedWeapon.toUpperCase();
         trace("ZOMBIE DROPPED A " + _root[pickedUpWeapon].description);
      }
      else
      {
         _root[currentLevel].findWeapon = false;
      }
   }
   if(hoursSpentWeapons >= 1)
   {
      foundWeaponsTotal += hoursSpentWeapons + survivors;
      trace("TOTAL WEAPON FIND SCORE: " + foundWeaponsTotal);
      trace("WEAPON CHECK\r-----------------------------");
      for(i in allWeapons)
      {
         weaponNumberFind++;
         trace("NAME: " + _root[allWeapons[i]].name + "\rFOUND: " + _root[allWeapons[i]].found + "\r\r");
         if(foundWeaponsTotal >= _root[allWeapons[i]].pointsRequired && _root[allWeapons[i]].found == false)
         {
            searchFoundAWeapon++;
            _root[allWeapons[i]].found = true;
            _root["weaponFound" + weaponNumberFind] = "" + _root[allWeapons[i]].description + " ";
            trace("FOUND WEAPON: " + _root["weaponFound" + weaponNumberFind]);
            if(_root[allWeapons[i]].name != "pistol")
            {
               nextWeaponPoint++;
               timeManager.clipBoardResults.foundWeapons.text = timeManager.clipBoardResults.foundWeapons.text + _root["weaponFound" + weaponNumberFind].toUpperCase() + "\r";
            }
            else
            {
               timeManager.clipBoardResults.foundWeapons.text = "NONE";
            }
            trace(timeManager.timeMenu_bgDay["shadow_" + _root[allWeapons[i]].name]);
            timeManager.timeMenu_bgDay["shadow_" + _root[allWeapons[i]].name].attachMovie(_root[allWeapons[i]].name + "_Icon",_root[allWeapons[i]].name + "_Weapon",this.getNextHighestDepth);
         }
      }
   }
   if(searchFoundAWeapon <= 0 && _root[currentLevel].findWeapon != true)
   {
      trace("SEARCH FOR WEAPONS TURNED UP NOTHING.");
      timeManager.clipBoardResults.foundWeapons.text = "NONE";
   }
   for(i in allWeapons)
   {
      if(_root[allWeapons[i]].found == true)
      {
         timeManager.timeMenu_bgDay["shadow_" + _root[allWeapons[i]].name].attachMovie(_root[allWeapons[i]].name + "_Icon",_root[allWeapons[i]].name + "_Weapon",this.getNextHighestDepth);
      }
   }
   _root.timeManager.timeMenu_bgDay.primary.attachMovie(primaryWeapon + "_Icon","primaryWeapon",this.getNextHighestDepth);
   _root.timeManager.timeMenu_bgDay.secondary.attachMovie(secondaryWeapon + "_Icon","secondaryWeapon",this.getNextHighestDepth);
   if(_root.survivors >= 1)
   {
      _root.activateHelpers(_root.survivors);
   }
   debugDay++;
   updateClipBoard = setInterval(updateClipBoardText,1000);
}
function weaponMeter()
{
   var _loc1_;
   for(i in weaponPoints)
   {
      i = nextWeaponPoint;
      trace("NEXT WEAPON GOAL: " + weaponPoints[i]);
      trace("CURRENT WEAPON GOAL: " + weaponPoints[i - 1]);
      if(weaponPoints[i] != undefined)
      {
         pointsDifference = weaponPoints[i] - weaponPoints[i - 1];
         earnedPointsPastDiff = foundWeaponsTotal - weaponPoints[i - 1];
         if(earnedPointsPastDiff <= 0)
         {
            earnedPointsPastDiff = 0;
         }
      }
      else
      {
         pointsDifference = weaponPoints[i];
         earnedPointsPastDiff = foundWeaponsTotal;
      }
      trace("FOUND TOTAL: " + foundWeaponsTotal);
      trace("POINTS DIFFERENCE: " + pointsDifference);
      trace("EARNED PAST DIFF: " + earnedPointsPastDiff);
      _loc1_ = Math.round(earnedPointsPastDiff / pointsDifference * 100);
      timeManager.theClipBoard.findOmeter.findBar.bar._xscale = _loc1_;
      trace("PERCENT UNTIL WEAPON FIND: " + _loc1_);
      break;
   }
}
function slideToToolBench()
{
   timeManager.xSlideTo(-800,1.5,"easeOutSine",0.5);
   timeManager.timeMenu_bgDay.blurTo(0,5,1,"easeOutSine",0.5);
}
function clipBoardUp()
{
   timeManager.theClipBoard.ySlideTo(30,0.5,"easeOutSine",1.5);
   timeManager.timeMenu_bgDay.blurTo(2,5,1,"easeOutSine",0.5);
}
function clipBoardDown()
{
   timeManager.theClipBoard.ySlideTo(420,0.5,"easeOutSine");
   timeManager.timeMenu_bgDay.blurTo(0,5,1,"easeOutSine",0.5);
}
function clipBoardResultsUp()
{
   timeManager.clipBoardResults.ySlideTo(15,0.5,"easeOutSine");
   timeManager.timeMenu_bgNight.blurTo(0,5,1,"easeOutSine",0.5);
}
function clipBoardResultsDown()
{
   timeManager.clipBoardResults.ySlideTo(420,0.5,"easeOutSine");
}
function confirmTimeManagement()
{
   clipBoardDown();
   calculateFindings();
   timeManager.timeMenu_bgNight.alphaTo(100,1,"easeOutSine",null,clipBoardResultsUp);
}
function confirmResults()
{
   clipBoardResultsDown();
   resetClipBoardText();
   slideToToolBench();
}
function clipBoardButtons(btnName)
{
   _root.timeManager.theClipBoard[btnName].onRelease = function()
   {
      switch(btnName)
      {
         case "barricadePlus":
            if(hoursInDay > 0)
            {
               hoursSpentRepairingWall++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         case "barricadeMinus":
            if(hoursSpentRepairingWall > 0)
            {
               hoursSpentRepairingWall--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         case "weaponsMinus":
            if(hoursSpentWeapons > 0)
            {
               hoursSpentWeapons--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         case "weaponsPlus":
            if(hoursInDay > 0)
            {
               hoursSpentWeapons++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         case "survivorsMinus":
            if(hoursSpentSurvivors > 0)
            {
               hoursSpentSurvivors--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         case "survivorsPlus":
            if(hoursInDay > 0)
            {
               hoursSpentSurvivors++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         default:
            return;
      }
   };
}
timeManager._visible = false;
blackOut._visible = false;
nextWeaponPoint = 1;
retryLevel = false;
repairRate = 507;
hoursInDay = 12;
survivors = 1;
hoursSpentRepairingWall = 0;
hoursSpentWeapons = 0;
hoursSpentSurvivors = 0;
survivorsFound = 0;
foundSurvivors = 0;
foundWeaponsTotal = 1;
searchPartyMembersKilled = 0;
debugDay = 0;
searchFoundAWeapon = 0;
