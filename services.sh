#
set_services(){
    
    local sys="/etc/systemd/system/"
    mv tcpdump.service $sys
    systemctl daemon-reload 
    systemctl enable tcpdump.service

}