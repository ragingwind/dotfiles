alias screenshot="convert -append -adaptive-resize 1984 $*"
alias thumbnail="montage -frame 1 -geometry 1024 -background white $*"
alias screencut30="time ffmpeg -v quiet -y -i $1 -vcodec copy -acodec copy -ss 00:00:00 -t 00:30:00 -sn $2"
