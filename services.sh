#
set_services(){
    
    local sys="/etc/systemd/system/"
    mv tcpdump.service $sys
    mv tcpdump.timer $sys
    systemctl daemon-reload 
    systemctl enable tcpdump.timer
    systemctl enable tcpdump.service

}