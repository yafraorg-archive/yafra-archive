#!/bin/sh
#
# docker run script
#
# variables must be set by CI service
# setup local environment first https://github.com/yafraorg/yafra/wiki/Development-Environment
export WORKNODE=/work/yafra-runtime
export APPDIR=/work/yafraserver
test -d $APPDIR || mkdir -p $APPDIR

echo "download latest build and install server"
cd /work/repos/yafra-python
git pull

echo "copy files to runtime folder"
test -d $APPDIR || mkdir $APPDIR
cp -r server/ $APPDIR
cp setup.py $APPDIR
cp requirements.txt $APPDIR

echo "setting right IP etc"
cd $APPDIR
pip install -r requirements.txt
#pip3 install -r requirements.txt

echo "start apache web server now"
apache2ctl start

echo "start python run.py &"
cd server
exec python run.py &
#exec python3 run.py &

echo "done - run now python run.py &"
