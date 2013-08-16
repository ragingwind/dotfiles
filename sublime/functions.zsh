subl() {

 if [[ "$(uname -s)" == "Darwin" ]]
    then
       	/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl $1 &
 	else
		/usr/local/bin/Sublime\ Text\ 2/sublime_text $1 &
	fi

}
