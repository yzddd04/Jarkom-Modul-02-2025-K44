apt update
apt install nginx -y

--------------------------------
mkdir -p /var/www/html/annals

echo "Annals of Beleriand - Volume 1" > /var/www/html/annals/volume1.txt
echo "Annals of Beleriand - Volume 2" > /var/www/html/annals/volume2.txt
echo "Annals of Beleriand - Volume 3" > /var/www/html/annals/volume3.txt

mkdir /var/www/html/annals/archives
echo "Ancient Records" > /var/www/html/annals/archives/ancient.txt

--------------------------------
server {
    listen 80;
    server_name static.K44.com;
    root /var/www/html;
    index index.html index.htm;

    # Autoindex untuk directory /annals
    location /annals/ {
        autoindex on;
    }
}
