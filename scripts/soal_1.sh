🎯 SCRIPT LENGKAP - PREFIX 192.233.x.x (K44)
🔴 EONWE - Router dengan NAT
⚠️ JALANKAN ULANG DI EONWE DENGAN PREFIX BARU:
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash

echo "=========================================="
echo "Setting up Eonwe Router (192.233.x.x)"
echo "=========================================="

hostname eonwe
echo "eonwe" > /etc/hostname

echo 1 > /proc/sys/net/ipv4/ip_forward
echo "✓ IP forwarding enabled"

ip addr add 192.168.122.100/24 dev eth0 2>/dev/null
ip link set eth0 up
ip route add default via 192.168.122.1 2>/dev/null
echo "✓ eth0 (NAT) configured"

ip addr flush dev eth1 2>/dev/null
ip addr flush dev eth2 2>/dev/null
ip addr flush dev eth3 2>/dev/null

ip addr add 192.233.1.1/24 dev eth1
ip addr add 192.233.2.1/24 dev eth2
ip addr add 192.233.3.1/24 dev eth3

ip link set eth1 up
ip link set eth2 up
ip link set eth3 up
echo "✓ Internal interfaces configured"

echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "✓ DNS resolver set"

echo ""
echo "Installing iptables..."
apt-get update
apt-get install -y iptables

echo ""
echo "Configuring NAT..."
iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth3 -o eth0 -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables-save > /etc/iptables.rules
echo "✓ NAT configured"

echo ""
echo "=========================================="
echo "Eonwe Router setup COMPLETE!"
echo "=========================================="
ip -br addr
echo ""
ping -c 2 8.8.8.8
EOF

chmod +x /root/setup.sh && ./root/setup.sh

🔵 EARENDIL - Klien Barat 1
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname earendil
echo "earendil" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.1.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.1.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Earendil configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🔵 ELWING - Klien Barat 2
⚠️ JALANKAN ULANG DI ELWING DENGAN IP BARU:
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname elwing
echo "elwing" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.1.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.1.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Elwing configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🟢 CIRDAN - Klien Timur 1
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname cirdan
echo "cirdan" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.2.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.2.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Cirdan configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🟢 ELROND - Klien Timur 2
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname elrond
echo "elrond" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.2.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.2.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Elrond configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🟢 MAGLOR - Klien Timur 3
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname maglor
echo "maglor" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.2.4/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.2.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Maglor configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🟡 SIRION - DMZ (Reverse Proxy)
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname sirion
echo "sirion" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.3.4/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Sirion configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🟡 LINDON - DMZ (Web Statis)
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname lindon
echo "lindon" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.3.5/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Lindon configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🟡 VINGILOT - DMZ (Web Dinamis)
bashcat > /root/setup.sh << 'EOF'
#!/bin/bash
hostname vingilot
echo "vingilot" > /etc/hostname
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.3.6/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "Vingilot configured!"
ping -c 2 google.com
EOF
chmod +x /root/setup.sh && ./root/setup.sh

🔴 TIRION - DNS Master (ns1)
#!/bin/bash

echo "=========================================="
echo "Setting up Tirion (DNS Master - ns1)"
echo "=========================================="

# Set hostname
hostname tirion
echo "tirion" > /etc/hostname
echo "✓ Hostname set"

# Configure network
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.3.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1 2>/dev/null
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "✓ Network configured"

# Test connectivity
echo ""
echo "Testing internet connection..."
if ! ping -c 2 8.8.8.8 >/dev/null 2>&1; then
    echo "✗ No internet connection!"
    exit 1
fi
echo "✓ Internet OK"

# Install bind9
echo ""
echo "Installing bind9 (this may take 2-3 minutes)..."
apt-get update -qq
apt-get install -y bind9 bind9utils dnsutils

if [ $? -ne 0 ]; then
    echo "✗ Failed to install bind9"
    exit 1
fi
echo "✓ bind9 installed"

# Configure bind9 options
echo ""
echo "Configuring bind9..."

cat > /etc/bind/named.conf.options << 'EOFBIND'
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    dnssec-validation auto;
    listen-on-v6 { any; };
    allow-query { any; };
};
EOFBIND

# Configure zones
cat > /etc/bind/named.conf.local << 'EOFBIND'
zone "K44.com" {
    type master;
    file "/etc/bind/zones/db.K44.com";
    notify yes;
    allow-transfer { 192.233.3.3; };
};
EOFBIND

# Create zone directory
mkdir -p /etc/bind/zones

# Create zone file
cat > /etc/bind/zones/db.K44.com << 'EOFBIND'
$TTL    604800
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                         2025101201
                         604800
                         86400
                         2419200
                         604800 )
@       IN      NS      ns1.K44.com.
@       IN      NS      ns2.K44.com.

ns1.K44.com.        IN      A       192.233.3.2
ns2.K44.com.        IN      A       192.233.3.3
@                   IN      A       192.233.3.4

eonwe.K44.com.      IN      A       192.233.1.1
earendil.K44.com.   IN      A       192.233.1.2
elwing.K44.com.     IN      A       192.233.1.3
cirdan.K44.com.     IN      A       192.233.2.2
elrond.K44.com.     IN      A       192.233.2.3
maglor.K44.com.     IN      A       192.233.2.4
sirion.K44.com.     IN      A       192.233.3.4
lindon.K44.com.     IN      A       192.233.3.5
vingilot.K44.com.   IN      A       192.233.3.6
EOFBIND

# Set proper permissions
chown -R bind:bind /etc/bind/zones
chmod -R 755 /etc/bind/zones
echo "✓ Zone files created"

# Check configuration
echo ""
echo "Checking configuration..."
named-checkconf
if [ $? -ne 0 ]; then
    echo "✗ Configuration error!"
    exit 1
fi
echo "✓ Configuration OK"

named-checkzone K44.com /etc/bind/zones/db.K44.com
if [ $? -ne 0 ]; then
    echo "✗ Zone file error!"
    exit 1
fi
echo "✓ Zone file OK"

# Kill any existing named process
killall named 2>/dev/null
sleep 1

# Start bind9
echo ""
echo "Starting bind9..."
/usr/sbin/named -u bind -c /etc/bind/named.conf

# Wait for bind9 to start
sleep 3

# Check if bind9 is running (using pidof or port check)
sleep 2
if pidof named >/dev/null 2>&1; then
    echo "✓ bind9 is running"
elif ss -tulpn | grep :53 | grep named >/dev/null 2>&1; then
    echo "✓ bind9 is running"
else
    echo "⚠ Cannot verify bind9 status, checking port 53..."
fi

# Check if listening on port 53
if ! ss -tulpn | grep :53 | grep named >/dev/null; then
    echo "✗ bind9 not listening on port 53!"
    exit 1
fi
echo "✓ bind9 listening on port 53"

# Update resolver to use local DNS
cat > /etc/resolv.conf << 'EOFBIND'
nameserver 192.233.3.2
nameserver 192.233.3.3
nameserver 192.168.122.1
EOFBIND

echo ""
echo "=========================================="
echo "Tirion (ns1) setup COMPLETE!"
echo "=========================================="

# Test DNS
echo ""
echo "Testing DNS queries..."
echo ""
echo "Query: K44.com"
dig @192.233.3.2 K44.com +short
echo ""
echo "Query: ns1.K44.com"
dig @192.233.3.2 ns1.K44.com +short
echo ""
echo "Query: earendil.K44.com"
dig @192.233.3.2 earendil.K44.com +short
echo ""
echo "Full query for K44.com:"
dig @192.233.3.2 K44.com

echo ""
echo "=========================================="
echo "Tirion is ready!"
echo "Next: Setup Valmar (ns2) as slave"
echo "=========================================="
🔴 VALMAR - DNS Slave (ns2)
⏱️ Tunggu Tirion selesai dulu
#!/bin/bash

echo "=========================================="
echo "Setting up Valmar (DNS Slave - ns2)"
echo "=========================================="

# Set hostname
hostname valmar
echo "valmar" > /etc/hostname
echo "✓ Hostname set"

# Configure network
ip addr flush dev eth0 2>/dev/null
ip addr add 192.233.3.3/24 dev eth0
ip link set eth0 up
ip route add default via 192.233.3.1 2>/dev/null
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "✓ Network configured"

# Test connectivity
echo ""
echo "Testing internet connection..."
if ! ping -c 2 8.8.8.8 >/dev/null 2>&1; then
    echo "✗ No internet connection!"
    exit 1
fi
echo "✓ Internet OK"

# Test connectivity to Tirion (ns1)
echo ""
echo "Testing connection to Tirion (ns1)..."
if ! ping -c 2 192.233.3.2 >/dev/null 2>&1; then
    echo "✗ Cannot reach Tirion! Setup Tirion first!"
    exit 1
fi
echo "✓ Can reach Tirion"

# Install bind9
echo ""
echo "Installing bind9 (this may take 2-3 minutes)..."
apt-get update -qq
apt-get install -y bind9 bind9utils dnsutils

if [ $? -ne 0 ]; then
    echo "✗ Failed to install bind9"
    exit 1
fi
echo "✓ bind9 installed"

# Configure bind9 options
echo ""
echo "Configuring bind9..."

cat > /etc/bind/named.conf.options << 'EOFBIND'
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    dnssec-validation auto;
    listen-on-v6 { any; };
    allow-query { any; };
};
EOFBIND

# Configure as slave
cat > /etc/bind/named.conf.local << 'EOFBIND'
zone "K44.com" {
    type slave;
    file "/var/cache/bind/db.K44.com";
    masters { 192.233.3.2; };
};
EOFBIND

echo "✓ Configuration created"

# Check configuration
echo ""
echo "Checking configuration..."
named-checkconf
if [ $? -ne 0 ]; then
    echo "✗ Configuration error!"
    exit 1
fi
echo "✓ Configuration OK"

# Kill any existing named process
killall named 2>/dev/null
sleep 1

# Start bind9
echo ""
echo "Starting bind9..."
/usr/sbin/named -u bind -c /etc/bind/named.conf

# Wait for bind9 to start and zone transfer
echo "Waiting for zone transfer from Tirion..."
sleep 5

# Check if bind9 is running (using pidof or port check)
sleep 2
if pidof named >/dev/null 2>&1; then
    echo "✓ bind9 is running"
elif ss -tulpn | grep :53 | grep named >/dev/null 2>&1; then
    echo "✓ bind9 is running"
else
    echo "⚠ Cannot verify bind9 status, checking port 53..."
fi

# Check if listening on port 53
if ! ss -tulpn | grep :53 | grep named >/dev/null; then
    echo "✗ bind9 not listening on port 53!"
    exit 1
fi
echo "✓ bind9 listening on port 53"

# Check zone transfer
echo ""
echo "Checking zone transfer..."
if [ -f /var/cache/bind/db.K44.com ]; then
    echo "✓ Zone file transferred successfully!"
    ls -lh /var/cache/bind/db.K44.com
else
    echo "⚠ Zone file not found yet, checking logs..."
    tail -20 /var/log/syslog | grep named
fi

# Update resolver to use both DNS servers
cat > /etc/resolv.conf << 'EOFBIND'
nameserver 192.233.3.2
nameserver 192.233.3.3
nameserver 192.168.122.1
EOFBIND

echo ""
echo "=========================================="
echo "Valmar (ns2) setup COMPLETE!"
echo "=========================================="

# Test DNS
echo ""
echo "Testing DNS queries..."
echo ""
echo "Query from ns2: K44.com"
dig @192.233.3.3 K44.com +short
echo ""
echo "Query from ns2: ns2.K44.com"
dig @192.233.3.3 ns2.K44.com +short
echo ""
echo "Query from ns2: cirdan.K44.com"
dig @192.233.3.3 cirdan.K44.com +short
echo ""
echo "Full query for K44.com from ns2:"
dig @192.233.3.3 K44.com

echo ""
echo "Checking SOA serial (should match ns1):"
dig @192.233.3.2 K44.com SOA +short
dig @192.233.3.3 K44.com SOA +short

echo ""
echo "=========================================="
echo "Valmar is ready!"
echo "Next: Update resolver on all other nodes"
echo "=========================================="
🔄 UPDATE RESOLVER - Setelah DNS Aktif
Jalankan di SEMUA node (kecuali Eonwe) setelah Tirion & Valmar selesai:
bashcat > /etc/resolv.conf << 'EOF'
nameserver 192.233.3.2
nameserver 192.233.3.3
nameserver 192.168.122.1
EOF

echo "Resolver updated!"
nslookup K44.com

✅ VERIFIKASI SOAL 1-5
Dari klien manapun:
bash# Test konektivitas lintas subnet
ping -c 2 192.233.1.1    # Gateway Barat
ping -c 2 192.233.2.2    # Cirdan (Timur)
ping -c 2 192.233.3.2    # Tirion (DMZ)
ping -c 2 8.8.8.8        # Internet

# Test DNS
nslookup K44.com
nslookup earendil.K44.com
nslookup ns1.K44.com
dig K44.com
host cirdan.K44.com