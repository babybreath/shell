curl -O https://codeload.github.com/tj/n/zip/master
unzip master && cd n-master
make install
cd ..
rm -rf n-master master
n 4.6.1
