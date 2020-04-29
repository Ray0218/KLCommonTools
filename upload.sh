#!/bin/bash

#VersionString=`grep -E 's.version.*=' KLLogin.podspec`
#VersionNumber=`tr -cd 0-9 <<<"$VersionString"`
#
#NewVersionNumber=$(($VersionNumber + 1))
#LineNumber=`grep -nE 's.version.*=' KLLogin.podspec | cut -d : -f1`
#sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" KLLogin.podspec
#
#echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"
#
#git add .
#git commit -am ${NewVersionNumber}
#git tag ${NewVersionNumber}
#git push origin master --tags
#pod repo push CustomPrivatePods KLLogin.podspec --verbose --allow-warnings --use-libraries --use-modular-headers
#



#git操作
git stash
git pull origin master --tags
git stash pop

confirmed="n"
NewVersionNumber=""
ProjectName="KLCommonTools"

getNewVersion() {
read -p "请输入新的版本号: " NewVersionNumber

if test -z "$NewVersionNumber"; then
getNewVersion
fi
}

#获取版本号并显示
VersionString=`grep -E 's.version.*='  ${ProjectName}.podspec`

VersionNumberDot=`tr -cd "[0-9.]" <<<"$VersionString"`
VersionNumber=`sed 's/^.//' <<<"$VersionNumberDot"`

echo -e "\n${Default}================================================"
echo -e " Current Version   :  ${Cyan}${VersionNumber}${Default}"
echo -e "================================================\n"

getInfomation() {
getNewVersion
#输出当前版本号
echo -e "\n${Default}================================================"
echo -e " New Version IS :  ${Cyan}${NewVersionNumber}${Default}"
echo -e "================================================\n"
}

#请求输入新的版本号
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
getInfomation
fi
read -p "确定? (y/n):" confirmed
done

read -p "请输入版本描述:" commitDesc

LineNumber=`grep -nE 's.version.*=' ${ProjectName}.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" ${ProjectName}.podspec

echo -e "\n${Default}================================================"
echo -e "current version is ${VersionNumber}, new version is ${NewVersionNumber}"
echo -e "================================================\n"

git add .
git commit -am ${NewVersionNumber}${commitDesc}
git push origin master

git tag ${NewVersionNumber}
git push  --tags

#git push origin master --tags

#pod repo push CustomPrivatePods ${ProjectName}.podspec --allow-warnings --use-libraries --use-modular-headers

pod trunk push  ${ProjectName}.podspec --allow-warnings --use-libraries  
