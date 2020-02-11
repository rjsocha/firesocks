[![asciicast](https://asciinema.org/a/300286.png =500x333)](https://asciinema.org/a/300286)

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
