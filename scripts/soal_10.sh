apt update
apt install nginx php8.4-fpm php8.4-cli -y

--------------------------------
/var/www/html/index.php

<!DOCTYPE html>
<html>
<head>
    <title>War of Wrath - Vingilot</title>
</head>
<body>
    <h1>Welcome to Vingilot</h1>
    <p>The ship that sails the heavens</p>
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About Vingilot</a></li>
    </ul>
    <p>Server Time: <?php echo date('Y-m-d H:i:s'); ?></p>
    <p>PHP Version: <?php echo phpversion(); ?></p>
</body>
</html>

--------------------------------
nano /var/www/html/about.php

<!DOCTYPE html>
<html>
<head>
    <title>About - Vingilot</title>
</head>
<body>
    <h1>About Vingilot</h1>
    <p>The vessel of Eärendil that sails through the skies</p>
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
    </ul>
    <p>This page is served by PHP <?php echo phpversion(); ?></p>
    <p>Request URI: <?php echo $_SERVER['REQUEST_URI']; ?></p>
</body>
</html>

--------------------------------
/etc/nginx/sites-available/default

server {
    listen 80;
    server_name app.K44.com;
    root /var/www/html;
    index index.php index.html index.htm;

    # PHP-FPM configuration
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    # Rewrite rule: /about -> about.php (without .php extension)
    location = /about {
        try_files $uri $uri/ /about.php?$args;
    }

    # Deny access to other .php files if not found
    location ~ /\.ht {
        deny all;
    }
}

--------------------------------
pkill nginx
pkill php-fpm

php-fpm8.4 -D
nginx

--------------------------------
ps aux | grep -E '(nginx|php-fpm)'

--------------------------------
# 1. Test DNS
nslookup app.K44.com

# 2. Test PHP execution
curl http://app.K44.com/ | grep "PHP Version"

# 3. Test rewrite rule
curl http://app.K44.com/about | grep "About Vingilot"

# 4. Verify no .php extension in URL
curl -I http://app.K44.com/about