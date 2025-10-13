# Jarkom-Modul-01-2025-K44

Nama                  | NRP
----------------------|-----------
Ahmad Yazid Arifuddin | 5027241040
Tiara Fatimah Azzahra |	5027241090

## Soal 1
Pertama tama buat topologi di GNS3 terlebih dahulu
![alt text](assets/soal1/topologi.png)
setelah itu config di setiap node nya

#### Router
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    	address 192.233.1.1
    	netmask 255.255.255.0

auto eth2
iface eth2 inet static
    	address 192.233.2.1
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
    	address 192.233.1.2
        netmask 255.255.255.0	
    	gateway 192.233.1.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

- Elwing
```
auto eth0
iface eth0 inet static
    	address 192.233.1.3
        netmask 255.255.255.0
    	gateway 192.233.1.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf	
```

#### Timur
- Cirdan
```
auto eth0
iface eth0 inet static
        address 192.233.2.2
    	netmask 255.255.255.0
    	gateway 192.233.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Elrond
```
auto eth0
iface eth0 inet static
    	address 192.233.2.3
    	netmask 255.255.255.0
    	gateway 192.233.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Maglor
```
auto eth0
iface eth0 inet static
    	address 192.233.2.4
    	netmask 255.255.255.0
    	gateway 192.233.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Pelabuhan DMZ (Switch 3)
- Sirion
```
auto eth0
iface eth0 inet static
    	address 192.233.3.2
    	netmask 255.255.255.0
    	gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Pelabuhan DMZ (Switch 4)
- Tirion
```
auto eth0
iface eth0 inet static
    	address 192.233.3.3
    	netmask 255.255.255.0
        gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Valmar
```
auto eth0
iface eth0 inet static
    	address 192.233.3.4
    	netmask 255.255.255.0
        gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Lindon
```
auto eth0
iface eth0 inet static
        address 192.233.3.5
    	netmask 255.255.255.0
    	gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Vingilot
```
auto eth0
iface eth0 inet static
    	address 192.233.3.6
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

## Soal 6

## Soal 7

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

