on(release){
   with(_root)
   {
      trackSound.attachSound("soundtrack");
      paused = false;
      menu_button.enabled = true;
      flag_button.enabled = true;
      flagdelete_button.enabled = true;
      practiceMode = false;
      practiceHeader._visible = false;
      onFlag = -1;
      flagsLeft = 10;
      flagsLeftT.text = "";
      resetGame();
      var i = 0;
      while(i < flags.length)
      {
         flags[i].removeMovieClip();
         i++;
      }
      flags = new Array();
   }
   prevFrame();
}
