echo "此脚本用于制作https使用的证书"
echo "请输入服务器证书名称："
read server_key
echo "---开始创建服务器证书---"
echo "您的名字与姓氏是什么：必须是TOMCAT部署主机的域名或者IP"
keytool -genkey -v -alias tomcat -keyalg RSA -keystore $server_key.keystore -validity 36500
echo "完成服务端证书制作"
echo "开始制作客户端证书"
echo "请输入客户端证书名称："
read client_key
keytool -genkey -v -alias mykey -keyalg RSA -storetype PKCS12 -keystore $client_key.p12
echo "完成客户端证书制作"
echo "让服务器信任客户端证书"
echo "请输入客户端证书密码"
read client_key_password
keytool -export -alias mykey -keystore $client_key.p12 -storetype PKCS12 -storepass $client_key_password -rfc -file $client_key.cer
echo "导入到服务器的证书库,需要输入服务端证书密码"
keytool -import -v -file $client_key.cer -keystore $server_key.keystore
echo "客户端信任服务器证书,需要输入服务端证书密码"
keytool -keystore $server_key.keystore -export -alias tomcat -file $server_key.cer
echo "证书制作完成"
echo $server_key.keystore "由服务端使用,"  $client_key.p12 "和" $server_key.cer "由客户端使用"
echo "按任意键结束"
read 