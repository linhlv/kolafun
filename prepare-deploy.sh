#!/bin/bash
SH_SCRIPT_FILENAME=$DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
SITE_WEB_FOLDER=web
SITE_SCRIPT_BOOTSTRAP=$DEPLOY_REMOTE_FOLDER$DEPLOY_REMOTE_BUILD_FOLDER/$SITE_WEB_FOLDER/server.js

tar -czvf $PACKAGE_FILE_NAME . --exclude=gulpfile.js --exclude=deploy_rsa.enc --exclude=.gitignore --exclude=.git --exclude=prepare-deploy.sh --exclude=$PACKAGE_FILE_NAME
mkdir $DEPLOY_REMOTE_BUILD_FOLDER
mv $PACKAGE_FILE_NAME $DEPLOY_REMOTE_BUILD_FOLDER
echo "#!/bin/sh" >> $SH_SCRIPT_FILENAME
echo "#travis_brach: $TRAVIS_BRANCH" >> $SH_SCRIPT_FILENAME
echo "cd $DEPLOY_REMOTE_FOLDER$DEPLOY_REMOTE_BUILD_FOLDER" >> $SH_SCRIPT_FILENAME

if [ "$TRAVIS_BRANCH" = "development" ];
then
  SITE_NAME=dev.kolafun.appiume.com
  #for development
  echo "mkdir $SITE_WEB_FOLDER" >> $SH_SCRIPT_FILENAME
  echo "mkdir $SITE_WEB_FOLDER/logs" >> $SH_SCRIPT_FILENAME
  echo "tar -xf $PACKAGE_FILE_NAME -C web" >> $SH_SCRIPT_FILENAME
  echo "pm2 stop $SITE_NAME" >> $SH_SCRIPT_FILENAME
  echo "pm2 delete $SITE_NAME" >> $SH_SCRIPT_FILENAME
  #echo "pm2 start $SITE_SCRIPT_BOOTSTRAP --name $SITE_NAME" >> $SH_SCRIPT_FILENAME
  echo "pm2 start $SITE_WEB_FOLDER/pm2.json" >> $SH_SCRIPT_FILENAME
  echo "echo 'Depoyment done.'"

elif [ "$TRAVIS_BRANCH" = "master" ];
then
  #for master
  echo "#do nothing"
else
  #for other branch
  echo "#do nothing"
fi
chmod +x $SH_SCRIPT_FILENAME
