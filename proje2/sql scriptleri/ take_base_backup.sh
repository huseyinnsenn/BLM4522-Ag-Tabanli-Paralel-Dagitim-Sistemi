#!/bin/bash
# Fiziksel tam yedek (Base Backup) alma scripti
docker exec -it pg-disaster-recovery pg_basebackup \
  -U postgres \
  -D /mnt/archive/base_backup \
  -Fp -Xs -P
echo "Base backup başarıyla /mnt/archive/base_backup dizinine alındı."