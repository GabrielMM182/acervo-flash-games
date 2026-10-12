function fillWeaponMagazines()
{
   swapWeapon(primaryWeapon);
   currentWeaponInHand = "primary";
   ammoInMag = _root[primaryWeapon].magazineCapacity;
   primaryAmmo = _root[primaryWeapon].magazineCapacity;
   secondaryAmmo = _root[secondaryWeapon].magazineCapacity;
   trace("-------------------------------------------------");
   trace("WEAPON INITIALISATION: ");
   trace("-------------------------------------------------");
   trace("PRIMARY WEAPON AMMO: " + primaryAmmo);
   trace("SECONDARY WEAPON AMMO: " + secondaryAmmo);
   trace("-------------------------------------------------");
}
function switchWeapons()
{
   if(currentWeaponInHand == "primary" && secondaryWeapon != undefined && !reloading)
   {
      primaryAmmo = ammoInMag;
      swapWeapon(secondaryWeapon);
      currentWeaponInHand = "secondary";
      trace("XXX---" + primaryWeapon + " has " + primaryAmmo + " rounds.");
      trace("SWITCHING TO SECONDARY: " + secondaryWeapon);
      ammoInMag = secondaryAmmo;
   }
   else if(!reloading && secondaryWeapon != undefined)
   {
      secondaryAmmo = ammoInMag;
      trace("XXX---" + secondaryWeapon + " has " + secondaryAmmo + " rounds.");
      swapWeapon(primaryWeapon);
      currentWeaponInHand = "primary";
      trace("SWITCHING TO PRIMARY: " + primaryWeapon);
      ammoInMag = primaryAmmo;
   }
}
function weaponRackButtons(btnName)
{
   _root.timeManager.timeMenu_bgDay[btnName].onRelease = function()
   {
      assignWeapon(btnName);
   };
}
function weaponSlotButtons(btnName)
{
   _root.timeManager.timeMenu_bgDay[btnName].onRelease = function()
   {
      unassignWeapon(btnName);
   };
   _root.timeManager.timeMenu_bgDay[btnName].onRollOver = function()
   {
      if(_root[btnName + "WeaponSlot"] == "full")
      {
         _root.timeManager.timeMenu_bgDay["remove_" + btnName].alphaTo(100,0.2);
      }
   };
   _root.timeManager.timeMenu_bgDay[btnName].onRollOut = function()
   {
      _root.timeManager.timeMenu_bgDay["remove_" + btnName].alphaTo(0,0.2);
   };
}
function assignWeapon(wpnName)
{
   if(_root[wpnName].found == true)
   {
      if(primaryWeaponSlot == "empty" && wpnName != secondaryWeapon)
      {
         _root.timeManager.timeMenu_bgDay.needAWeapon.alphaTo(0,0.2);
         primaryWeapon = _root[wpnName].name;
         primaryWeaponSlot = "full";
         _root.timeManager.timeMenu_bgDay.primary.attachMovie(_root[wpnName].name + "_Icon","primaryWeapon",this.getNextHighestDepth);
         swapWeapon(primaryWeapon);
         fillWeaponMagazines();
      }
      else if(secondaryWeaponSlot == "empty" && wpnName != primaryWeapon)
      {
         secondaryWeapon = _root[wpnName].name;
         secondaryWeaponSlot = "full";
         _root.timeManager.timeMenu_bgDay.secondary.attachMovie(_root[wpnName].name + "_Icon","secondaryWeapon",this.getNextHighestDepth);
         fillWeaponMagazines();
      }
   }
}
function unassignWeapon(btnName)
{
   trace("UNASSIGNING: " + btnName);
   trace("From: " + _root.timeManager.timeMenu_bgDay[btnName][btnName + "Weapon"]);
   trace(primaryWeapon.name);
   _root.timeManager.timeMenu_bgDay[btnName][btnName + "Weapon"].removeMovieClip();
   _root[btnName + "WeaponSlot"] = "empty";
   _root[btnName + "Weapon"] = null;
}
currentWeapon = "pistol";
primaryWeapon = "pistol";
secondaryWeapon = null;
primaryWeaponSlot = "full";
secondaryWeaponSlot = "empty";
currentWeaponInHand = "primary";
primaryAmmo = 0;
secondaryAmmo = 0;
ammoInMag = _root[primaryWeapon].magazineCapacity;
primaryAmmo = _root[primaryWeapon].magazineCapacity;
secondaryAmmo = _root[secondaryWeapon].magazineCapacity;
trace("-------------------------------------------------");
trace("WEAPON INITIALISATION: ");
trace("-------------------------------------------------");
trace("PRIMARY WEAPON AMMO: " + primaryAmmo);
trace("SECONDARY WEAPON AMMO: " + secondaryAmmo);
trace("-------------------------------------------------");
