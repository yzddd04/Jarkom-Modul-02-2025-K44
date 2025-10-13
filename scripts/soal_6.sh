======================
Konfigurasi Tirion
======================

------------------------------
/etc/bind/zones/db.K44.com

; BIND data file for K44.com
;
$TTL    604800
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                        2024100201      ; Serial
                        28800           ; Refresh
                        14400           ; Retry
                        3600000         ; Expire
                        86400 )         ; Minimum TTL

; Name Servers
@       IN      NS      ns1.K44.com.
@       IN      NS      ns2.K44.com.

; A Records
@       IN      A       10.78.3.2    ; Apex -> Sirion

ns1     IN      A       10.78.3.3    ; Tirion
ns2     IN      A       10.78.3.4    ; Valmar

; All other hosts...
eonwe       IN      A       10.78.1.1
earendil    IN      A       10.78.1.2
elwing      IN      A       10.78.1.3
cirdan      IN      A       10.78.2.2
elrond      IN      A       10.78.2.3
maglor      IN      A       10.78.2.4
sirion      IN      A       10.78.3.2
tirion      IN      A       10.78.3.3
valmar      IN      A       10.78.3.4
lindon      IN      A       10.78.3.6
vingilot    IN      A       10.78.3.5

------------------------------
/etc/bind/named.conf.local

// Zone for K44.com
zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
    allow-transfer { 192.233.3.4; };  // Valmar
    notify yes;
};

-------------------------------
/etc/bind/named.conf.options

options {
    directory "/var/cache/bind";
    forwarders {
        192.168.122.1;
    };
    allow-query { any; };
    listen-on { any; };
    recursion yes;
    
    // Untuk zone transfer
    allow-transfer { 192.233.3.4; };  // Valmar
    notify yes;
};

==============================
Konfigurasi Valmar
==============================

-------------------------------
/etc/bind/named.conf.local

zone "K44.com" {
    type slave;
    file "/var/cache/bind/db.K44.com";
    masters { 192.233.3.3; };  # Tirion
};

-------------------------------
chown bind:bind /var/cache/bind/db.K44.com

-------------------------------
# Di Tirion dan Valmar
named -u bind -g &

# Di Valmar
rndc reload K44.com
sleep 5