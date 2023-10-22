#
set_services(){
    cp tcpdump.service /etc/systemd/system/
    cp tcpdump.timer /etc/systemd/system/
    systemctl daemon-reload #revisar que no se salga la ejecucion
    systemctl enable tcpdump.timer
}