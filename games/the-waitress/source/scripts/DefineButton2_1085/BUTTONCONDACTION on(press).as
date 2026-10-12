on(press){
   if(UserName.length > 0)
   {
      Masks = new Array("grwesaojn&upsgf","4654fJHFipruhhbnv","#kigfsij21ggF&","(%=·jJFNJu7ru%3","HrtIuHFueosufhd<sdD","%/fvXZm7<>77sd6<szd","$edry/0de87DFG7e","WE4707yGSDFiouey7493","SE445YYe/e0rhgjdbver","$ureu4(473SyfbDOAS","%4398HDyubgfhyb7e/07","%489b09348/$b0374","$EYG47/809857743875gD");
      Data = new Array();
      Data[0] = random(Masks.length);
      Data[1] = random(Masks[Data[0]].length);
      Data[2] = UserName.length;
      ScoreSt = UserScore.toString();
      Data[3] = ScoreSt.length;
      i = 0;
      while(i < Data[2])
      {
         Data[5 + i] = ord(UserName.charAt(i));
         i++;
      }
      i = 0;
      while(i < Data[3])
      {
         Data[5 + Data[2] + i] = ord(ScoreSt.charAt(i));
         i++;
      }
      CheckSum = 0;
      i = 5;
      while(i < Data.length)
      {
         CheckSum += Data[i];
         i++;
      }
      Data[4] = CheckSum % 100;
      COS = Data[1];
      i = 2;
      while(i < Data.length)
      {
         MaskCo = ord(Masks[Data[0]].charAt(COS)) % 40;
         if(MaskCo == 0)
         {
            MaskCo = 40;
         }
         Data[i] += ord(Masks[Data[0]].charAt(COS));
         Data[i] *= MaskCo;
         COS++;
         if(COS >= Masks[Data[0]].length)
         {
            COS = 0;
         }
         i++;
      }
      Output = Data.join("x");
      Dt.res = Output;
      SendData = true;
      RName = UserName;
      RScore = UserScore;
      gotoAndStop(2);
   }
   else
   {
      Nm.gotoAndPlay(2);
   }
}
