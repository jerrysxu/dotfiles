if [ "x$1" == "x" ]
then
	echo bash backup.sh /Volumes/My\\ Passport\\ for\\ Mac/backups/box_laptop
	exit 1
fi

rsync -avr --exclude Adobe --exclude 'Microsoft User Data' --exclude 'Virtual Machines.localized' --exclude 'RDC Connections' --exclude WebEx Documents/* "$1/Documents"
rsync -avr --exclude PictureLife Downloads/* "$1/Downloads"
