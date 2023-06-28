# OpenVPN-HFN Install

[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/hostingfuze)

OpenVPN installation has only been tested on: Almalinux 8, RockyLinux 8, Ubuntu 22.04, Ubuntu 22.04 with 64 bits platforms

You can connect the whmcs system, email and telegram alerts, web customer management and automatic download / installation for customers.

## Usage

First, get the script and make it executable:

```bash
curl -L -o /opt/openvpn.sh https://raw.githubusercontent.com/hostingfuze/vpn-hfn/main/openvpn.sh --silent
chmod +x /opt/openvpn.sh
```

Then run it:

```sh
/opt/openvpn.sh
```

You need to run the script as root and have the TUN module enabled.

The first time you run it, you'll have to follow the assistant and answer a few questions to setup your VPN server.

1. Public IPv4 address / hostname `.ovpn`
 - The name of sever generates the link web server and vpn server
 - example download files client : https://servername or ip/hfn-client/`files.ovpn`
2. Protocol server OpenVPN 
 - `TCP`
 - `UDP`
3. Port OpenVPN
 - The port where the client connects
4. DNS server for clients
 - those of the system are recommended
 - for good protection use: `1.1.1.3` `1.0.0.3`
5. Internal subnet IPv4 and Internal subnet IPv6
 - You can choose which subnets you want to use for your vpn network
 
After answering the questions above, confirm the installation and start the openvpn server

Now, after installing the openvpn server, we install the web server for management and for the client to have the opportunity to register or download the file `.ovpn`

For management I chose OpenLiteSpeed.

During the installation/configuration process, the system will ask for some confirmations.

For access from the web interface for the admin, it is necessary to configure a password for the openvpn user.
For change password use:

```bash

```
