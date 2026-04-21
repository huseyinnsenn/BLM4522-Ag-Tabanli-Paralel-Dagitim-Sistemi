#!/bin/bash
# Tarih damgalı mantıksal yedek (Logical Backup)
TARIH=$(date +"%Y-%m-%d_%H-%M")
docker exec pg-disaster-recovery pg_dump -U postgres -Fc testdb > ~/postgres_backup/testdb_full_$TARIH.dump
echo "Mantıksal yedek oluşturuldu: testdb_full_$TARIH.dump"