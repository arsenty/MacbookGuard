ps ax|grep [S]creenSaverEngine > /dev/null
if [ "$?" != "0" ] ; then
    echo 1# screen saver is not active
else
    echo 2# screen saver is active
fi
