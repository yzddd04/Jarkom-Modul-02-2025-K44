apt update && apt install -y bind9 bind9utils

====================================
Konfigurasi DNS Server (Tirion)
====================================
ip addr add 192.233.3.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1

## /etc/bind/zones/db.K44.com
$TTL    604800
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                        2024100101      ; Serial
                        28800           ; Refresh
                        14400           ; Retry
                        3600000         ; Expire
                        86400 )         ; Minimum TTL

; Name Servers
@       IN      NS      ns1.K44.com.
@       IN      NS      ns2.K44.com.

; A Records
@       IN      A       192.233.3.2    ; Apex -> Sirion

ns1     IN      A       192.233.3.3    ; Tirion
ns2     IN      A       192.233.3.4    ; Valmar

; All Hosts
eonwe       IN      A       192.233.1.1
earendil    IN      A       192.233.1.2
elwing      IN      A       192.233.1.3
cirdan      IN      A       192.233.2.2
elrond      IN      A       192.233.2.3
maglor      IN      A       192.233.2.4
sirion      IN      A       192.233.3.2
tirion      IN      A       192.233.3.3
valmar      IN      A       192.233.3.4
lindon      IN      A       192.233.3.6
vingilot    IN      A       192.233.3.5

## /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    allow-query { any; };
    listen-on { any; };
    recursion yes;
};

## /etc/bind/named.conf.local
zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
    allow-transfer { 192.233.3.4; };
    also-notify { 192.233.3.4; };
};

====================================
Konfigurasi DNS Client (Valmar)
====================================
ip addr add 192.233.3.4/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1


## /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    allow-query { any; };
    listen-on { any; };
    recursion yes;
};

## /etc/bind/named.conf.local
zone "K44.com" {
    type slave;
    file "/var/cache/bind/db.K44.com";
    masters { 192.233.3.3; };    ; Tirion
};

====================================
Testing
====================================
# Start BIND9
pkill named
named -g -u bind &

# Verifikasi zone transfer
ls -la /var/cache/bind/db.K44.com