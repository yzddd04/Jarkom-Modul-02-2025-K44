#### Router
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

#### Barat
## Earendil
auto eth0
iface eth0 inet static
    	address 192.233.1.2
        netmask 255.255.255.0	
    	gateway 192.233.1.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

## Elwing
auto eth0
iface eth0 inet static
    	address 192.233.1.3
        netmask 255.255.255.0
    	gateway 192.233.1.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf	

#### Timur
## Cirdan
```
auto eth0
iface eth0 inet static
        address 192.233.2.2
    	netmask 255.255.255.0
    	gateway 192.233.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

## Elrond
auto eth0
iface eth0 inet static
    	address 192.233.2.3
    	netmask 255.255.255.0
    	gateway 192.233.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

## Maglor
auto eth0
iface eth0 inet static
    	address 192.233.2.4
    	netmask 255.255.255.0
    	gateway 192.233.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

#### Pelabuhan DMZ (Switch 3)
## Sirion
```
auto eth0
iface eth0 inet static
    	address 192.233.3.2
    	netmask 255.255.255.0
    	gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

#### Pelabuhan DMZ (Switch 4)
## Tirion
auto eth0
iface eth0 inet static
    	address 192.233.3.3
    	netmask 255.255.255.0
        gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

## Valmar
auto eth0
iface eth0 inet static
    	address 192.233.3.4
    	netmask 255.255.255.0
        gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

## Lindon
auto eth0
iface eth0 inet static
        address 192.233.3.5
    	netmask 255.255.255.0
    	gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf

## Vingilot
auto eth0
iface eth0 inet static
    	address 192.233.3.6
        netmask 255.255.255.0
    	gateway 192.233.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf