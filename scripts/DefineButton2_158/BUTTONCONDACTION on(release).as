on(release){
   if(!_root.exploding)
   {
      if(_root.practiceMode)
      {
         _root.trackSound.start(_root.soundPosition,99999);
      }
      else
      {
         _root.trackSound.start(_root.soundPosition,1);
      }
   }
   _root.paused = false;
   _root.menu_button.enabled = true;
   _root.flag_button.enabled = true;
   _root.flagdelete_button.enabled = true;
   prevFrame();
}
