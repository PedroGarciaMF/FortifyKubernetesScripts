apk add --update docker openrc

rc-update add docker boot

service docker start

service docker status

# TODO make changes to /etc/apk/repositories

#add kernel module for networking stuff
echo "br_netfilter" > /etc/modules-load.d/k8s.conf
modprobe br_netfilter
apk add cni-plugin-flannel
apk add cni-plugins
apk add flannel
apk add flannel-contrib-cni
apk add kubelet
apk add kubeadm
apk add kubectl
apk add docker
apk add uuidgen
apk add nfs-utils
apk add openjdk11

#Pin your versions!  If you update and the nodes get out of sync, it implodes.
apk add 'kubelet=~1.25'
apk add 'kubeadm=~1.25'
apk add 'kubectl=~1.25'

#get rid of swap
cat /etc/fstab | grep -v swap > temp.fstab
cat temp.fstab > /etc/fstab
rm temp.fstab
swapoff -a

#Fix prometheus errors
mount --make-rshared /
echo "#!/bin/sh" > /etc/local.d/sharemetrics.start
echo "mount --make-rshared /" >> /etc/local.d/sharemetrics.start
chmod +x /etc/local.d/sharemetrics.start
rc-update add local

#Fix id error messages
uuidgen > /etc/machine-id

#Add services
rc-update add docker
rc-update add kubelet

#Sync time
rc-update add ntpd
/etc/init.d/ntpd start
/etc/init.d/docker start

#fix flannel
ln -s /usr/libexec/cni/flannel-amd64 /usr/libexec/cni/flannel

#kernel stuff
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
sysctl net.bridge.bridge-nf-call-iptables=1

kubeadm init --pod-network-cidr=10.244.0.0/16 --node-name=master
mkdir ~/.kube
ln -s /etc/kubernetes/admin.conf /root/.kube/config
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml


# FIXME docker-registry fortifydocker
#kubectl create secret docker-registry fortifydocker --docker-username <docker hub id> --docker-password <docker hub password>


mkdir certificates

cd certificates/

openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 7200 -out certificate.pem -subj "/CN=*.192-168-35-100.nip.io"

openssl pkcs12 -export -name ssc -in certificate.pem -inkey key.pem -out ssc-keystore.p12 -password pass:FortifySSCS3cr3t!

keytool -importkeystore -destkeystore ssc-keystore.jks -srckeystore ssc-keystore.p12 -srcstoretype pkcs12 -alias ssc -srcstorepass FortifySSCS3cr3t! -deststorepass FortifySSCS3cr3t!

keytool -import -trustcacerts -file certificate.pem -alias wildcard-cert -keystore wildcard-cert-keystore.jks -storepass FortifySSCS3cr3t! -noprompt

cd ..

mkdir ssc-secret 

cp certificates/ssc-keystore.jks ssc-secret/

cp certificates/wildcard-cert-keystore.jks  ssc-secret/

# TODO copy fortify.license

cd ssc-secret/










kubectl create secret generic fortify --from-file=. --from-literal=fortify-service.jks.password=M1cro_F0cus --from-literal=fortify-service.jks.key.password=M1cro_F0cus --from-literal=truststore.password=M1cro_F0cus

kubectl create secret tls wildcard-certificate --cert=certificate.pem --key=key.pem

