#!/bin/bash
tar -czvf $PACKAGE_FILE_NAME . --exclude=gulpfile.js --exclude=deploy_rsa.enc --exclude=.gitignore --exclude=.git --exclude=$PACKAGE_FILE_NAME
mkdir $DEPLOY_REMOTE_BUILD_FOLDER
mv $PACKAGE_FILE_NAME $DEPLOY_REMOTE_BUILD_FOLDER
echo "#!/bin/sh" >> $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
echo "cd $DEPLOY_REMOTE_FOLDER$DEPLOY_REMOTE_BUILD_FOLDER" >> $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
echo "'$TRAVIS_BRANCH'"
if ["$TRAVIS_BRANCH"=="development"]; then
  #for development
  echo "mkdir web" >> $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
  echo "tar -xf $PACKAGE_FILE_NAME -C web" >> $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
  echo "#$DEPLOY_REMOTE_FOLDER$DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME" >> $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
elif ["$TRAVIS_BRANCH"=="master"]; then
  #for master
  echo "mkdir master" >> $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
fi
chmod +x $DEPLOY_REMOTE_BUILD_FOLDER/$INSTALL_REMOTE_SSH_SCRIPT_FILE_NAME
