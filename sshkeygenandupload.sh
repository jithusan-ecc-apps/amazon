#!/bin/bash
#title: generating a ssh keys in gitbash and upload in github seetings
#description: using ssh-key we are genaerating keys in git and paste it to the github settings all this activites we are going to do with shell scripting
#author: jithendra260
#date:23/07/2021
#usage: sh filename.sh
echo "enter username of github"
read username
echo " enter your github personal token "
read token
cat ~/.ssh/id_rsa.pub
# if condtion is to validate whether ssh keys are already present or not
if [ $? -eq 0 ]
then
echo " ssh keys are already present "
else
echo " ssh keys are not present.. create the ssh keys using ssh_keygen "
ssh-keygen -t rsa
echo " ssh keys successfully generated "
fi
sshkey=`cat ~/.ssh/id_rsa.pub`
if [ $? -eq 0 ]
then
echo "copying the key to $username"
curl -X POST -H "Content-type: application/json" -d "{\"title\": \"SSHKEY\",\"key\": \"$sshkey\"}" "https://api.github.com/user/keys?access_token=$token"
if [ $? -eq 0 ]
then
echo "successfully copied the token to github"
exit 0
else
echo " Failed "
exit 1
fi
else
echo "failure in genaerating key"
exit 1
fi  
