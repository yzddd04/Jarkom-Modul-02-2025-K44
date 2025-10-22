/etc/bind/zones/db.192.233.3

; BIND reverse data file for 192.233.3.0/24
;
$TTL    604800
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                        2024100201      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL

; Name Servers
@       IN      NS      ns1.K44.com.
@       IN      NS      ns2.K44.com.

; PTR Records - Reverse lookup
2       IN      PTR     sirion.K44.com.
5       IN      PTR     vingilot.K44.com.
6       IN      PTR     lindon.K44.com.

-------------------------------
nano /etc/bind/named.conf.local

// Reverse zone for DMZ segment
zone "3.78.10.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.233.3";
    allow-transfer { 192.233.3.4; };  // Valmar
    notify yes;
};

-------------------------------
/etc/bind/named.conf.local

// Reverse zone for DMZ segment (slave)
zone "3.78.10.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.233.3";
    masters { 192.233.3.3; };  // Tirion
};

-------------------------------
pkill named
named -u bind -g &

-------------------------------
# Di Valmar
rndc reload 3.78.10.in-addr.arpa
sleep 10

# Di Client
nslookup 192.233.3.2
nslookup 192.233.3.5  
nslookup 192.233.3.6

# Di Valmar
nslookup 192.233.3.2 localhost


-------------------------------
# Di Valmar
rndc reload 3.78.10.in-addr.arpa
sleep 10

# Di Client
nslookup 192.233.3.2
nslookup 192.233.3.5  
nslookup 192.233.3.6

# Di Valmar
nslookup 192.233.3.2 localhost