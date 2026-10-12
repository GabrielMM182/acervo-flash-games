startSound();
highScoresText = "Getting High Scores...";
rn = Math.round(Math.random() * 1000000);
loadVariables("http://www.hyperlaunch.com/cgi-bin/residentevil/getscores.pl?reload=" + rn,this);
