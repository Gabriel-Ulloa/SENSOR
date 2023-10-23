#
set_services(){
    cp tcpdump.service /etc/systemd/system/
    cp tcpdump.timer /etc/systemd/system/
    systemctl daemon-reload 
    systemctl enable tcpdump.timer
    systemctl enable tcpdump.service
}