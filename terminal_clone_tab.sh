#!/bin/sh
osascript <<-eof
  tell application "Terminal"
    tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
    do script with command "cd `pwd`; clear" in selected tab of the front window
  end tell
eof