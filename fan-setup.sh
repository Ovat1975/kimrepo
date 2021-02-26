#NOT BIN/BASH FILE

echo "options thinkpad_acpi experimental=1 fan_control=1" >/etc/modprobe.d/thinkpad_acpi.conf

sudo rmmod thinkpad_acpi ; sudo modprobe thinkpad_acpi

apt install thinkfan

 tp_fan /proc/acpi/ibm/fan

 tp_thermal /proc/acpi/ibm/thermal (0, 10, 15, 2, 10, 5, 0, 3, 0, 3)

 (0,    0,  41)
 (1,    40, 51)
 (2,    50, 56)
 (3,    55, 61)
 (4,    60, 65)
 (5,    64, 68)
 (7,    67, 32767)


 service thinkfan restart


 journalctl -f
