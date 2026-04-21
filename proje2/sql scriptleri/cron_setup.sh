#!/bin/bash
# Cron job tanımlama: Her gece 02:00'de yedek al
(crontab -l 2>/dev/null; echo "0 2 * * * ~/postgres_backup/otomatik_yedek.sh") | crontab -
echo "Yedekleme görevi cron sistemine başarıyla eklendi."