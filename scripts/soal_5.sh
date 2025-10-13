echo "earendil" > /etc/hostname
hostname earendil

## nano /etc/hosts
127.0.0.1       localhost
192.233.1.2       earendil.K44.com earendil

## /root/set-hostname-K44.sh
#!/bin/bash

GROUP="K44"

# Deteksi interface dan tentukan hostname berdasarkan IP
IP=$(ip route get 1 | awk '{print $7}' | head -1)

case $IP in
    "192.233.1.1") HOST="eonwe" ;;
    "192.233.1.2") HOST="earendil" ;;
    "192.233.1.3") HOST="elwing" ;;
    "192.233.2.2") HOST="cirdan" ;;
    "192.233.2.3") HOST="elrond" ;;
    "192.233.2.4") HOST="maglor" ;;
    "192.233.3.2") HOST="sirion" ;;
    "192.233.3.3") HOST="tirion" ;;
    "192.233.3.4") HOST="valmar" ;;
    "192.233.3.5") HOST="vingilot" ;;
    "192.233.3.6") HOST="lindon" ;;
    *) HOST="unknown" ;;
esac

echo "Setting hostname to: $HOST"

# 1. Set hostname di /etc/hostname
echo "$HOST" > /etc/hostname

# 2. Set hostname saat ini
hostname "$HOST"

# 3. Update /etc/hosts
cat > /etc/hosts << EOF
127.0.0.1       localhost
$IP       $HOST.$GROUP.com $HOST
EOF

echo "=== CONFIGURATION COMPLETE ==="
echo "Hostname: $HOST"
echo "FQDN: $HOST.$GROUP.com"
echo "IP: $IP"

-----------------------------------    
chmod +x /root/set-hostname-K44.sh
./root/set-hostname-K44.sh

-----------------------------------
nano /etc/resolv.conf

nameserver 192.233.3.3
nameserver 192.233.3.4
nameserver 192.168.122.1

====================================
konfigurasi Tirion
====================================
; BIND data file for K44.com
$TTL    604800
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                        2024100101   
                        28800        
                        14400          
                        3600000       
                        86400 )         

; Name Servers
@       IN      NS      ns1.K44.com.
@       IN      NS      ns2.K44.com.

; A Records untuk setiap host
@       IN      A       192.233.3.2    ; Apex -> Sirion

; DNS Servers (PENGECUALIAN: ns1 dan ns2 khusus untuk DNS)
ns1     IN      A       192.233.3.3    
ns2     IN      A       192.233.3.4    

; Router
eonwe   IN      A       192.233.1.1

; Klien Barat
earendil    IN      A       192.233.1.2
elwing      IN      A       192.233.1.3

; Klien Timur
cirdan      IN      A       192.233.2.2
elrond      IN      A       192.233.2.3
maglor      IN      A       192.233.2.4

; DMZ Hosts
sirion      IN      A       192.233.3.2
tirion      IN      A       192.233.3.3  
valmar      IN      A       192.233.3.4   
lindon      IN      A       192.233.3.6
vingilot    IN      A       192.233.3.5

; CNAME Records (untuk soal selanjutnya)
www     IN      CNAME   sirion
static  IN      CNAME   lindon
app     IN      CNAME   vingilot

------------------------------------
/etc/bind/named.conf.options

options {
    directory "/var/cache/bind";
    forwarders {
        192.168.122.1;
    };
    allow-query { 
        localhost;
        192.233.0.0/16;
    };
    allow-transfer {
        192.233.3.4;    ; Valmar
    };
    also-notify {
        192.233.3.4;    ; Valmar
    };
    dnssec-validation auto;
    listen-on-v6 { any; };
    listen-on { any; };
    recursion yes;
};

------------------------------------
nano /etc/bind/named.conf.local

zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
};

-------------------------------------
pkill named
named -g -u bind &
sleep 3