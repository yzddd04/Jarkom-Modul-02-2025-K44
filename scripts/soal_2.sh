## Jalankan script dibawah di Node Eonwe

echo 1 > /proc/sys/net/ipv4/ip_forward
apt update
apt install -y iptables

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.233.0.0/16

## Test di semua Node
apt update
apt install -y iptables
ping -c 5 google.com