#!/bin/sh

echo -n 'check root  ...  '

if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
fi
echo 'ok'

# default node install directory
node_prefix=/usr/node/latest

echo -n 'check parameter  ...  '
if [ -z $1 ] ;then
  echo 'no parameter.'
else
  echo "$1"
  node_prefix=$1
fi

echo -n "check folder ${node_prefix}  ...  "

if [ -d "${node_prefix}/bin" ] ;then
  export PATH=$PATH:${node_prefix}/bin
  echo 'destination folder exist.'
else
  echo 'destination folder not exist.'
fi


echo -n 'check wget support  ...  '

GET=
which wget > /dev/null && GET="wget -O- --no-check-certificate"
if test -z "$GET"; then
  echo "wget required" && exit 1
else
  echo 'wget support.'
fi


# getLatest version
getLatest() {
  $GET 2> /dev/null https://nodejs.org/dist/latest/ \
    | egrep "</a>" \
    | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' \
    | egrep -v '^0\.[0-7]\.' \
    | egrep -v '^0\.8\.[0-5]$' \
    | sort -u -k 1,1n -k 2,2n -k 3,3n -t . \
    | tail -n1
}



echo -n 'check node  ...  '

node=
which node &> /dev/null && node="ok"

pm2=
which pm2 &> /dev/null && pm2="ok"

n=
which n &> /dev/null && n="ok"

# download...

if test -z "$node"; then

  echo 'cannot find node '
  echo "create directory ${node_prefix}"

  rm -fr ${node_prefix} && mkdir -p ${node_prefix} 
  echo -n 'get latest version  ...  '
  latestVersion=$(getLatest)  &&  echo $latestVersion

  downloadUrl=http://nodejs.org/dist/latest/node-v${latestVersion}-linux-x64.tar.gz
  echo downloading $downloadUrl
  $GET $downloadUrl | tar --strip-components 1 -zx -C $node_prefix &&
  echo "download ok." && 
  echo "add PATH to ~/.bash_profile" &&
  echo "export PATH=${node_prefix}/bin:\$PATH" >> ~/.bash_profile && 
  export PATH=${node_prefix}/bin:$PATH && 
  echo "install pm2  ...  " && 
  npm install -g pm2 && 
  echo "install n  ...  " &&
  npm install -g n
else
  echo 'node has been installed.'
  echo -n 'check pm2  ...  '
  if test -z "$pm2"; then
    echo 'install pm2  ...  ' && npm install -g pm2 
  else
    echo 'pm2 has been installed.'
  fi
  echo -n 'check n  ...  '
  if test -z "$n"; then
    echo 'isntall n  ...  ' && npm install -g n
  else
    echo 'n has been installed.'
  fi
fi

