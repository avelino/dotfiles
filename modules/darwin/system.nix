{ pkgs, ... }:

{
  # DNS configuration for macOS
  networking = {
    knownNetworkServices = ["Wi-Fi" "Ethernet"];
    dns = [
      "9.9.9.9"    # Quad9 DNS
      "1.1.1.1"    # Cloudflare DNS
      "8.8.8.8"    # Google DNS
    ];
  };
} 