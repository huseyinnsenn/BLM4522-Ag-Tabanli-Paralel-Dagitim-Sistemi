#!/bin/bash
# Point-in-Time Recovery (PITR) Operasyonu
# DİKKAT: Mevcut veri klasörünü siler ve yedekten döner!

TARGET_TIME="2026-04-21 08:16:34.832 +0300" # Örnektir, kendi zamanını yaz

docker stop pg-disaster-recovery

docker run --rm \
  -v ~/postgres_backup/data:/var/lib/postgresql/data \
  -v ~/postgres_backup/archive:/mnt/archive \
  -u root postgres:15 \
  bash -c "rm -rf /var/lib/postgresql/data/* && \
           cp -r /mnt/archive/base_backup/* /var/lib/postgresql/data/ && \
           touch /var/lib/postgresql/data/recovery.signal && \
           echo \"restore_command = 'cp /mnt/archive/%f %p'\" >> /var/lib/postgresql/data/postgresql.conf && \
           echo \"recovery_target_time = '$TARGET_TIME'\" >> /var/lib/postgresql/data/postgresql.conf && \
           echo \"recovery_target_action = 'promote'\" >> /var/lib/postgresql/data/postgresql.conf && \
           chown -R postgres:postgres /var/lib/postgresql/data"

docker start pg-disaster-recovery
echo "PITR İşlemi tamamlandı. Sistem $TARGET_TIME anına geri döndürüldü."