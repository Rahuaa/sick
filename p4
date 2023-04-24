PRAC 9
Part 1
Step 1 : Configure secret on router
enable secret enpa55

Step 2 : Configure console password on router
line console 0
password conpa55
login

Step 3 : Configure SSH login on router 
ip domain-name ccnasecurity.com
username admin secret adminpa55 
line vty 0 4
login local
crypto key generate rsa

Step 4 : Configure OSPF on router
R1
router ospf 1
network 192.168.1.0 0.0.0.255 area 0
network 10.1.1.0 0.0.0.3 area 0

R2
router ospf 1
network 192.168.2.0 0.0.0.255 area 0
network 10.2.2.0 0.0.0.3 area 0
network 10.1.1.0 0.0.0.3 area 0

R3
router ospf 1
network 192.168.3.0 0.0.0.3 area 0
network 10.2.2.0 0.0.0.3 area 0

Verify Connectivity
PC A -> ping 192.168.3.3
PC A -> ping 192.168.2.3
PC B -> ping 192.168.3.3

----------------------------------------------------------------------------------------

PART 2:  Configure IPSec parameters on R1  Only on R1
show version (#)

license boot module c1900 technology-package securityk9

copy run start (#)
reload (#) 

show version (#)

access-list 110 permit ip 192.168.1.0 0.0.0.255 192.168.3.0 0.0.0.255

crypto isakmp policy 10
encryption aes 256
authentication pre-share
group 5
exit
crypto isakmp key vpnpa55 address 10.2.2.2

crypto ipsec transform-set VPN-SET esp-aes esp-sha-hmac
crypto map VPN-MAP 10 ipsec-isakmp
description VPN connection to R3
set peer 10.2.2.2 
set transform-set VPN-SET
match address 110
exit

int se 0/1/0
crypto map VPN-MAP

-----------------------------------------------------------------------------------------

PART 3: Configure IPSec Parameters on R3 (all on  R3)
show version (#)
 
license boot module c1900 technology-package securityk9

copy run start (#)
reload (#)

show version (#)

access-list 110 permit ip 192.168.3.0 0.0.0.255 192.168.1.0 0.0.0.255

crypto isakmp policy 10
encryption aes 256
authentication pre-share
group 5
exit
crypto isakmp key vpnpa55 address 10.1.1.2

crypto ipsec transform-set VPN-SET esp-aes esp-sha-hmac
crypto map VPN-MAP 10 ipsec-isakmp
description VPN connection to R1
set peer 10.1.1.2 
set transform-set VPN-SET
match address 110
exit

int se 0/1/0
crypto map VPN-MAP

-------------------------------------------------------------------------------------------------

PART 4: Verify the IPSec VPN 
R1# show crypto ipsec sa

PCC -> ping 192.168.1.3

R1# show crypto ipsec sa

PCB -> ping 192.168.1.3

R1# ping 192.168.3.3

R3# ping 192.168.1.3

R1# show crypto ipsec sa


==================================================================================================
==================================================================================================



Part 1 : Configure Router
(execute on all routers)
enable secret enpa55

line console 0
password conpa55
login

ip domain-name ccnasecurity.com
username admin secret adminpa55 
line vty 0 4
login local
crypto key generate rsa

R1
router ospf 1
network 192.168.1.0 0.0.0.255 area 0
network 10.1.1.0 0.0.0.3 area 0

R2
router ospf 1
network 192.168.2.0 0.0.0.255 area 0
network 10.2.2.0 0.0.0.3 area 0
network 10.1.1.0 0.0.0.3 area 0

R3
router ospf 1
network 192.168.3.0 0.0.0.3 area 0
network 10.2.2.0 0.0.0.3 area 0

PC A -> ping 192.168.3.3
PC A -> ping 192.168.2.3
PC B -> ping 192.168.3.3

----------------------------------------------------------------------------------------

PART 2:  Configure IPSec parameters on R1  Only on R1
show version (#)

license boot module c1900 technology-package securityk9

copy run start (#)
reload (#) 

show version (#)

access-list 110 permit ip 192.168.1.0 0.0.0.255 192.168.3.0 0.0.0.255

crypto isakmp policy 10
encryption aes 256
authentication pre-share
group 5
exit
crypto isakmp key vpnpa55 address 10.2.2.2

crypto ipsec transform-set VPN-SET esp-aes esp-sha-hmac
crypto map VPN-MAP 10 ipsec-isakmp
description VPN connection to R3
set peer 10.2.2.2 
set transform-set VPN-SET
match address 110
exit

int se 0/1/0
crypto map VPN-MAP

-----------------------------------------------------------------------------------------

PART 3: Configure IPSec Parameters on R3 
(all on  R3)
show version (#)
 
license boot module c1900 technology-package securityk9

copy run start (#)
reload (#)

show version (#)

access-list 110 permit ip 192.168.3.0 0.0.0.255 192.168.1.0 0.0.0.255

crypto isakmp policy 10
encryption aes 256
authentication pre-share
group 5
exit
crypto isakmp key vpnpa55 address 10.1.1.2

crypto ipsec transform-set VPN-SET esp-aes esp-sha-hmac
crypto map VPN-MAP 10 ipsec-isakmp
description VPN connection to R1
set peer 10.1.1.2 
set transform-set VPN-SET
match address 110
exit

int se 0/1/0
crypto map VPN-MAP

-------------------------------------------------------------------------------------------------

PART 4: Verify the IPSec VPN 
R1# show crypto ipsec sa

PCC -> ping 192.168.1.3

R1# show crypto ipsec sa

PCB -> ping 192.168.1.3

R1# ping 192.168.3.3

R3# ping 192.168.1.3

R1# show crypto ipsec sa
