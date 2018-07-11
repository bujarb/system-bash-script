# /bin/

echo "Finding Debian/ Ubuntu Codename..."

CODENAME=`cat /etc/*-release | grep -w "ID"`

set -- "$CODENAME"
IFS="="; declare -a Array=($*)
distro="${Array[1]}"
if [ $distro == "debian" ]
then
echo $distro
fi
