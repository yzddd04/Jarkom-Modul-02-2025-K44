# Update zone file
cat > /etc/bind/zones/K44.com.zone << 'EOF'
$TTL    30
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                              2024102004 ; Serial
                          604800     ; Refresh
                           86400     ; Retry
                        2419200     ; Expire
                            30 )    ; Negative Cache TTL
;
@       IN      NS      ns1.K44.com.
@       IN      NS      ns2.K44.com.

; A records
@       IN      A       10.15.43.37
ns1     IN      A       10.15.43.35
ns2     IN      A       10.15.43.36
sirion  IN      A       10.15.43.37
lindon  IN      A       10.15.43.40
vingilot IN     A       10.15.43.39

; CNAME records
www     IN      CNAME   sirion
static  IN      CNAME   lindon
app     IN      CNAME   vingilot
morgoth IN      CNAME   melkor

; TXT record
melkor  IN      TXT     "Morgoth (Melkor)"
EOF

systemctl restart bind9

nslookup -type=TXT melkor.K44.com localhost
nslookup -type=CNAME morgoth.K44.com localhost