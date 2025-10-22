# Enable services berdasarkan node
HOSTNAME=$(hostname)

case $HOSTNAME in
    "tirion"|"valmar")
        echo "🔧 Configuring BIND9 autostart..."
        systemctl enable bind9
        systemctl start bind9
        ;;
    "sirion"|"lindon")
        echo "🔧 Configuring nginx autostart..."
        systemctl enable nginx
        systemctl start nginx
        ;;
    "vingilot")
        echo "🔧 Configuring nginx & PHP-FPM autostart..."
        systemctl enable nginx php8.4-fpm
        systemctl start nginx php8.4-fpm
        ;;
    *)
        echo "🔧 No specific services for this node"
        ;;
esac

# Verifikasi status
echo "SERVICE STATUS:"
if systemctl is-active --quiet bind9 2>/dev/null; then echo "✅ bind9: ACTIVE"; fi
if systemctl is-active --quiet nginx 2>/dev/null; then echo "✅ nginx: ACTIVE"; fi
if systemctl is-active --quiet php8.4-fpm 2>/dev/null; then echo "✅ php8.4-fpm: ACTIVE"; fi

echo "✅ Soal 17 selesai: Autostart services configured"