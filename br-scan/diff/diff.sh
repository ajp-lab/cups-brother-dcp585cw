#!/bin/bash
GOOD="brother-works"
BAD="brother-scan-test"

echo "--- VERGLEICHE INSTALLIERTE PAKETE ---"
docker exec $GOOD dpkg -l > good_pkgs.txt
docker exec $BAD dpkg -l > bad_pkgs.txt
diff -u good_pkgs.txt bad_pkgs.txt | grep "^[+-][^+-]"

echo -e "\n--- VERGLEICHE SANE KONFIGURATION ---"
docker exec $GOOD cat /etc/sane.d/dll.conf > good_sane.txt
docker exec $BAD cat /etc/sane.d/dll.conf > bad_sane.txt
diff -u good_sane.txt bad_sane.txt

echo -e "\n--- PRÜFE BROTHER-SPEZIFISCHE DATEIEN ---"
docker exec $GOOD ls -R /usr/local/Brother > good_brother_files.txt
docker exec $BAD ls -R /usr/local/Brother > bad_brother_files.txt
diff -u good_brother_files.txt bad_brother_files.txt
