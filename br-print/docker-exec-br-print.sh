# Drucker anlegen
docker exec -it cups-dcp585cw lpadmin -p DCP585CW -E -v lpd://192.168.50.10/BINARY_P1 -P /usr/share/cups/model/brdcp585cw.ppd

# Testdruck senden
docker exec -it cups-dcp585cw lp -d DCP585CW /etc/hosts
