; A Records untuk web services
sirion       IN    A    192.233.3.2
lindon       IN    A    192.233.3.6
vingilot     IN    A    192.233.3.5

; CNAME Records
www          IN    CNAME    sirion
static       IN    CNAME    lindon
app          IN    CNAME    vingilot

-------------------------------
@       IN      SOA     ns1.K44.com. admin.K44.com. (
                        2024100203      ; Serial  ← NAIKKAN jadi 2024100203

                        
-------------------------------
# Di Tirion
pkill named
named -u bind -g &

# Di Valmar
rndc reload K44.com
sleep 10


-------------------------------
# Test A records
nslookup sirion.K44.com
nslookup lindon.K44.com
nslookup vingilot.K44.com

# Test CNAME records
nslookup www.K44.com
nslookup static.K44.com  
nslookup app.K44.com