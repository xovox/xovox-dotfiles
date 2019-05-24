##############################################################################
#
# this bashrc file is (c) 2013 duncan brown (http://duncanbrown.org)
#
# this and my other bash environment files can be downloaded directly from
# my webserver.  http://files.duncanbrown.org/linux/dotfiles/
#
# all are released under the creative commons license
#
##############################################################################

##############################################################################
# get a weather report whenever you start a terminal
##############################################################################

# comment this out to disable weather reports
weather_zip=02476
forecast_url="http://www.intellicast.com/Local/Weather.aspx?location=USMA0438"

# set this to disable weather reports for certain terminal types, regex, pipe delimted
no_weather_in_term="false"

##############################################################################
# nothing user-configurable from here on down
##############################################################################

status_weather_temperature() {
	curr_weather="http://weather.yahooapis.com/forecastrss?p=$weather_zip"
	[ -f ${HOME}/.current_weather ] && source ${HOME}/.current_weather || last_update=0
	[ $[ $(date +%s) - $last_update ] -ge $[ 60 * 30 ] ] && {

		curl -s $curr_weather \
			| grep yweather:condition \
			| sed \
				-e s/'<yweather:condition'/''/\
				-e s/'\/>'/''/ \
				-e s/'  '/' '/g \
				-e s/'^ '/''/ \
			| tr '[:upper:]' '[:lower:]' > ${HOME}/.current_weather

		echo "last_update=$(date +%s)" >> ${HOME}/.current_weather
		source ${HOME}/.current_weather
	}
	echo ${text}/${temp}
}

# INSANELY BUGGY, THEY KEEP CHANGING THE OUTPUT OF THE PAGE
# show the weather if this is a valid terminal, we have our weather set
weather_forecast() {
	if (which elinks > /dev/null 2>&1) ; then
		elinks=$(which elinks)
	elif (which links > /dev/null 2>&1) ; then
		elinks=$(which links)
	fi

	if [ "$elinks" ] && [ "$PS1" ] && [ "$(echo $TERM | egrep -v "$no_weather_in_term")" ]; then
		last_update=0
		touch ${HOME}/.weather_forecast_time
		source ${HOME}/.weather_forecast_time
		[ $[ $(date +%s) - $last_update ] -ge $[ 60 * 60 ] ] && {
			echo "last_update=$(date +%s)" > ${HOME}/.weather_forecast_time
			$elinks \
				--dump-width 1000 \
				--no-numbering \
				--no-references \
				--dump $forecast_url \
				| egrep -A1 "Details for (Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday)" > $HOME/.weather_forecast
		}
		echo ------------------------------------------------------------------------------
		cat $HOME/.weather_forecast
		echo ------------------------------------------------------------------------------
	else
		echo "you're missing elinks"
	fi
}

echo -n
