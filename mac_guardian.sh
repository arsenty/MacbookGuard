#!/bin/bash
# reference https://gist.github.com/jay3sh/41d5f10293ba2aaa4019ec93766f4fdf

COUNT=5

#checkNoSleep()
#{
  #if [[ ! -f `which NoSleepCtrl` ]]
  #then
    #echo "You do not have NoSleepCtrl"
    #echo "https://github.com/integralpro/nosleep/releases"   
#}

turnNoSleepOn()
{
    sudo pmset -b sleep 0; sudo pmset -b disablesleep 1
}

turnNoSleepOff()
{
    sudo pmset -b sleep 5; sudo pmset -b disablesleep 0
}

onCtrlC()
{
  turnNoSleepOff
  # Reset the volume to medium value
  osascript -e "set Volume 3"
  exit
}

main()
{
  #checkNoSleep

  turnNoSleepOn

  trap onCtrlC SIGINT

  let INTRUSION_DETECTED=0
  CABLE_STATUS=`pmset -g batt | awk -F "; " 'FNR == 2 {print $2}'`

  while true
  do
    LID_CLOSED=`ioreg -r -k AppleClamshellState -d 4 | grep AppleClamshellState  | head -1 | cut -d = -f 2`
    CABLE_REMOVED=`pmset -g batt | awk -F "; " 'FNR == 2 {print $2}'`

    if [ $LID_CLOSED == "Yes" ] || [ $CABLE_STATUS != $CABLE_REMOVED ]

    then 
      # Turn volume to max value
      osascript -e "set Volume 10"

      let count=$COUNT
      while [ $count -gt 0 ]
      do
        say -v Fiona "Put down this laptop"
        #echo "Put down this laptop"
        let count-=1
        sleep 1
      done
      INTRUSION_DETECTED=1
    fi
    sleep 1
  done
}

main
