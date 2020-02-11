# Firesocks - Pi-Hole ad-blocker via WireGuard.

This is unpaid job from one of the freelancer-like sites. This about 18 hours of work. I don't know if this too much for such project.

Requiremets of the customer:
1. All should work from console/terminal.
2. Output should be in colors.
3. Should be self containted (git clone & and run ./firesocks ...)
3. Should work from Linux/MacOS X/Windows (should detect OS).
4. Generate ed25519 ssh "session" key.
5. Create droplet on Digital Ocean (API token provided by user).
6. Configure provider firewall.
7. Configure host firewall.
8. Bootstrap sever (update&upgrade, install wireguard, docker, docker-compose etc).
9. Create WireGaurd VPN endpoint and deploy Pi-Hole via docker (docker-compose).
10. Add unbound as resolver for Pi-Hole.
11. Install wireguard on client host.
12. Connect to VPN and expose pi-hole admin panel and redriect all DNS queries via VPN to Pi-Hole instance.
13. Create additional users.
14. Generate qrcode for mobile devices (with Wireguard configuration).

Not finised requirements:
1. Display web page when domain is blocked.
2. Windows part (only stub functionality was writen).
3. Monitor VPN connection and terminate it after specified time.

Tech used: Linux, MacOS X, WireGuard, docker, docker-compose, terraform, ssh, pi-hole,unbound, qrterminal, Windows, powershell.

Demo of functionality.
[<img src="https://asciinema.org/a/300286.png" width=500 height=333>](https://asciinema.org/a/300286)

You can put Digital API access token in env var:

```
export FIRESOCKS_DO_TOKEN=XXXXXXXXXXXXXXXX
```

Or you will be promtpted to enter token.

In both cases token is verified if is working.

The token is nerver saved on the disk.

Creation of the droplet, ssh-key and firewall rules (on provider side) are executed via terraform soultion (https://www.terraform.io/)

You can find template soultion in template/ folder. 


Full automatic operation:

```
./firesocs start
```
to stop (remove droplet)
```
./firesock stop
```

Step by step operations:


This will create new droplet with this steps:

1. Genereate new ed25519 ssh key and store it in state/firesocks_sshkey_ed25519_current-date_random
2. Generate name for new droplet (random string)
3. Check if DO token is OK
4. Generate terraform solution (from template) and save it to state/droplet.tf
5. Run terraform and create droplet and activate provider firewall:
  Alllow 22/tcp and 51820/udp for inbound, allow all traffic for outbound
6. Create new droplet

Create new droplet
```
./firesocks vm create
```

Check if droplet is ready (check ssh access)
```
./firesocks vm ping
```

Wait for node to be ready (check if ssh connection works)
```
./firesocks vm wait
```


Bootstraping (update&upgrade,docker-compose,docker, mosh, wiregurard)
```
./firesocks vm bootstrap
```

You can add extra packages to install to the file "extra.packages"


After bootstrap it's recommended to reboot droplet (for example new kernel)
```
./firesocks vm reboot
```

Enable firewall on droplet (provider firewall is activated durning droplet's creation)
```
./firesocks vm firewall
```

Setup vpn server
```
./firesocks vpn server setup
```

Install WireGuard clinet
```
./firesocks vpn client install
```

Configure client connection
```
./firesocks vpn client setup
```

Connect to VPN
```
./firesocks vpn up
```

Test VPN
```
./firesocks vpn ping
```


Connecting to the droplet
```
./firesocks vm ssh
```

or via vpn connection


mosh or ssh
```
./firesocks vpn mosh
./firesocks vpn ssh
```

Shutdown VPN connection
```
./firesocks vm down
```

Terminiating vm
```
./firesocks vm destroy
```
