mkdir -pv ~/.docker
cp -v /root/ca.pem ~/.docker
cp -v /root/cert.pem ~/.docker
cp -v /root/key.pem ~/.docker
export DOCKER_HOST=tcp://{{ ansible_host }}:2375 DOCKER_TLS_VERIFY=1
