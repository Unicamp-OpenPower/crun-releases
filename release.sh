#!/usr/bin/env bash
github_version=$(cat github_version.txt)
github_version_2=$(cat github_version2.txt)
ftp_version=$(cat ftp_version.txt)
ROOTPATH="~/rpmbuild/RPMS/ppc64le"
LOCALPATH="../crun"
REPO1="/repository/debian/ppc64el/containers"
REPO2="/repository/rpm/ppc64le/containers"

if [ "$github_version" != "$ftp_version" ]
  then
    git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
    cd repository-scrips/
    chmod +x empacotar-deb.sh
    chmod +x empacotar-rpm.sh
    sudo mv empacotar-deb.sh $LOCALPATH
    sudo mv empacotar-rpm.sh $LOCALPATH
    cd $LOCALPATH
    sudo ./empacotar-deb.sh crun crun-$github_version $github_version "libtool, libsystemd-dev, libcap-dev, libseccomp-dev, libyajl-dev, go-md2man, libtool, autoconf"
    sudo ./empacotar-rpm.sh crun crun-$github_version $github_version "libtool, gcc, libcap-devel, systemd-devel, yajl-devel, libseccomp-devel, python36, libtool" "A fast and lightweight fully featured OCI runtime and C library for running containers"

    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO1 crun-$github_version-ppc64le.deb"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO2 $ROOTPATH/crun-$github_version-1.ppc64le.rpm"
fi
