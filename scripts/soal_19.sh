nslookup havens.K44.com localhost

curl -s -I http://havens.K44.com/ | head -n 3

www_title=$(curl -s http://www.K44.com/ | grep -o '<title>[^<]*' | head -1)
havens_title=$(curl -s http://havens.K44.com/ | grep -o '<title>[^<]*' | head -1)
echo "www.K44.com title: $www_title"
echo "havens.K44.com title: $havens_title"
    