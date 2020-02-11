variable "DIGITALOCEAN_ACCESS_TOKEN" {
        type = string
}
resource "digitalocean_ssh_key" "default" {
  name       = "VPN ssh-key"
  public_key = file("|SSH_KEY|")
}

provider "digitalocean" {
        token = var.DIGITALOCEAN_ACCESS_TOKEN
}
resource "digitalocean_droplet" "vpn" {
        name = "|NAME|"
        image = "ubuntu-18-04-x64"
        region = "nyc3"
        ipv6 = true
        size = "s-1vcpu-1gb"
        private_networking = false
        ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}
resource "digitalocean_firewall" "vpn" {
  name = digitalocean_droplet.vpn.name

  droplet_ids = [digitalocean_droplet.vpn.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "51820"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "ip" {
        value = digitalocean_droplet.vpn.ipv4_address
}
