{
  # Enable the OpenSSH daemon. Port 22 belongs to knot (git over ssh).
  services.openssh = {
    enable = true;
    ports = [2200];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [2200];
  networking.firewall.allowedUDPPorts = [2200];
}
