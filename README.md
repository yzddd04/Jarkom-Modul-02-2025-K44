# Jarkom-Modul-02-2025-K44

Nama                  | NRP
----------------------|-----------
Ahmad Yazid Arifuddin | 5027241040
Tiara Fatimah Azzahra |	5027241090

## Soal 1
#### Router
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.233.2.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.233.1.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 192.233.3.1
    netmask 255.255.255.0
```

#### Barat
- Earendil
```
auto eth0
iface eth0 inet static
    address 192.233.2.2
    netmask 255.255.255.0
    gateway 192.233.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

- Elwing
```
auto eth0
iface eth0 inet static
    address 192.233.2.3
    netmask 255.255.255.0
    gateway 192.233.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Timur
- Cirdan
```
auto eth0
iface eth0 inet static
    address 192.233.1.2
    netmask 255.255.255.0
    gateway 192.233.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Elrond
```
auto eth0
iface eth0 inet static
    address 192.233.1.3
    netmask 255.255.255.0
    gateway 192.233.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Maglor
```
auto eth0
iface eth0 inet static
    address 192.233.1.4
    netmask 255.255.255.0
    gateway 192.233.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Pelabuhan DMZ (Switch 3)
- Sirion
```
auto eth0
iface eth0 inet static
    address 192.233.3.10
    netmask 255.255.255.0
    gateway 192.233.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Pelabuhan DMZ (Switch 4)
- Tirion
```
auto eth0
iface eth0 inet static
    address 192.233.3.2
    netmask 255.255.255.0
    gateway 192.233.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Valmar
```
auto eth0
iface eth0 inet static
    address 192.233.3.3
    netmask 255.255.255.0
    gateway 192.233.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Lindon
```
auto eth0
iface eth0 inet static
    address 192.233.3.4
    netmask 255.255.255.0
    gateway 192.233.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Vingilot
```
auto eth0
iface eth0 inet static
    address 192.233.3.5
    netmask 255.255.255.0
    gateway 192.233.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```


## Soal 2

- Jlakan script dibawah di Node Eonwe
```
echo 1 > /proc/sys/net/ipv4/ip_forward
apt update
apt install -y iptables

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.233.0.0/16

# Test di semua Node
apt update
apt install -y iptables
ping -c 5 google.com # Tes Internet
```
## Soal 3

- Sebelum melakukan tes koneksi antar client barta dan timur jalanin script dibawah ini di bagian Node
```
iptables -A FORWARD -i eth1 -o eth2 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth1 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth3 -j ACCEPT
iptables -A FORWARD -i eth3 -o eth1 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth3 -j ACCEPT
iptables -A FORWARD -i eth3 -o eth2 -j ACCEPT
```

## Soal 4

##### KONFIGURASI DNS MASTER (TIRION)
```
nano /etc/bind/named.conf.local
zone "k44.com" {
    type master;
    notify yes;
    also-notify { 192.233.3.3; };
    allow-transfer { 192.233.3.3; };
    file "/etc/bind/k44.com";
};

zone "3.89.10.in-addr.arpa" {
	type master;
    notify yes;
    also-notify { 192.233.3.3; };
    allow-transfer { 192.233.3.3; };
    file "/etc/bind/3.89.10.in-addr.arpa";
};
```

```
nano /etc/bind/k44.com
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     ns1.k44.com. root.k44.com. (
                        2024400401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

@       IN      NS      ns1.k44.com.
@       IN      NS      ns2.k44.com.
@       IN      A       192.233.3.10
ns1     IN      A       192.233.3.2
ns2     IN      A       192.233.3.3
eonwe     IN      A       192.168.122.247
earendil  IN      A       192.233.2.2
elwing    IN      A       192.233.2.3
cirdan   IN      A       192.233.1.2
elrond    IN      A       192.233.1.3
maglor    IN      A       192.233.1.4
sirion   IN      A       192.233.3.10
lindon   IN      A       192.233.3.4
vingilot  IN      A       192.233.3.5
www     IN      CNAME   sirion.k44.com.
static IN      CNAME   lindon.k44.com.
app   IN      CNAME   vingilot.k44.com.
```

```
nano /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";

        dnssec-validation no;

        forwarders { 192.168.122.1; };
        allow-query { any; };
        auth-nxdomain no;
        listen-on-v6 { any; };
};
```

```
nano /etc/bind/3.89.10.in-addr.arpa
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     k44.com. root.k44.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

3.89.10.in-addr.arpa.       IN      NS      k44.com.
10      IN      PTR     sirion.k44.com.
4       IN      PTR     lindon.k44.com.
5       IN      PTR     vingilot.k44.com.

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
```

##### KONFIGURASI DNS SLAVE (Valmar)
```
apt update && apt install bind9 -y

nano /etc/bind/named.conf.local
zone "k44.com" {
    type slave;
    masters { 192.233.3.2; };
    file "/etc/bind/k44.com";
};

zone "3.89.10.in-addr.arpa" {
	type slave;
    masters { 192.233.3.2; };
	file "/etc/bind/3.89.10.in-addr.arpa";
};

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
```


##### Pengujian dari Klien
```
nano /etc/resolve.conf
nameserver 192.233.3.2
nameserver 192.233.3.3
nameserver 192.168.122.1
```



##### Konfigurasi Tirion
```
ip addr add 192.233.3.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1
```

```
apt update && apt install -y bind9 bind9utils
```

/etc/bind/zones/db.K44.com
```
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
```

/etc/bind/named.conf.options
```
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    allow-query { any; };
    listen-on { any; };
    recursion yes;
};
```

/etc/bind/named.conf.local
```
zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
    allow-transfer { 192.233.3.4; };
    also-notify { 192.233.3.4; };
};
```

```
pkill named
named -g -u bind &
```

##### Konfigurasi Valmar
Setting ip addres
```
ip addr add 192.233.3.4/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1
```
/etc/bind/named.conf.options

```
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    allow-query { any; };
    listen-on { any; };
    recursion yes;
};
```
/etc/bind/named.conf.local
```
zone "K44.com" {
    type slave;
    file "/var/cache/bind/db.K44.com";
    masters { 192.233.3.3; };    ; Tirion
};
```

```
# Start BIND9
pkill named
named -g -u bind &

# Verifikasi zone transfer
ls -la /var/cache/bind/db.K44.com
```

## Soal 5

```
echo "earendil" > /etc/hostname
hostname earendil
```

nano /etc/hosts
```
127.0.0.1       localhost
192.233.1.2       earendil.K44.com earendil
```
/root/set-hostname-K44.sh

```
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
```
kemudian jalankan script dibawah ini
```
chmod +x /root/set-hostname-K44.sh
./root/set-hostname-K44.sh
```
nano /etc/resolv.conf
```
nameserver 192.233.3.3
nameserver 192.233.3.4
nameserver 192.168.122.1
```

##### konfigurasi Tirion

```
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
```
/etc/bind/named.conf.options

```
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
```
nano /etc/bind/named.conf.local

```
zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
};
```
Start bind9
```
pkill named
named -g -u bind &
sleep 3
```

cek
```
ps aux | grep named
```

## Soal 6

##### Konfigurasi Tirion
/etc/bind/zones/db.K44.com

```
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
@       IN      A       192.233.3.2    ; Apex -> Sirion

ns1     IN      A       192.233.3.3    ; Tirion
ns2     IN      A       192.233.3.4    ; Valmar

; All other hosts...
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
```

/etc/bind/named.conf.local

```
// Zone for K44.com
zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
    allow-transfer { 192.233.3.4; };  // Valmar
    notify yes;
};
```
/etc/bind/named.conf.options

```
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
```

##### Konfigurasi Valmar
/etc/bind/named.conf.local

```
zone "K44.com" {
    type slave;
    file "/var/cache/bind/db.K44.com";
    masters { 192.233.3.3; };  # Tirion
};
```
atur izin permission
```
chown bind:bind /var/cache/bind/db.K44.com
```

```
# Di Tirion dan Valmar
named -u bind -g &

# Di Valmar
rndc reload K44.com
sleep 5
```
## Soal 7
Tirion
```
; A Records untuk web services
sirion       IN    A    192.233.3.2
lindon       IN    A    192.233.3.6
vingilot     IN    A    192.233.3.5

; CNAME Records
www          IN    CNAME    sirion
static       IN    CNAME    lindon
app          IN    CNAME    vingilot
```

tambah serial number +1
```
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                        2024100203      ; Serial  ← NAIKKAN jadi 2024100203
```

restart kemudian lakukan zone transfer
```
# Di Tirion
pkill named
named -u bind -g &

# Di Valmar
rndc reload K44.com
sleep 10
```

kemudian tes dari klien
```
# Test A records
nslookup sirion.K44.com
nslookup lindon.K44.com
nslookup vingilot.K44.com

# Test CNAME records
nslookup www.K44.com
nslookup static.K44.com  
nslookup app.K44.com
```
## Soal 8

## Soal 9

## Soal 10 

## Soal 11

## Soal 12

## Soal 13

## Soal 14

## Soal 15

## Soal 16

## Soal 17

## Soal 18

## Soal 19

## Soal 20

