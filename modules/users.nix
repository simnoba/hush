{pkgs, ...}: {
  users.users."exec" = {
    isNormalUser = true;
    description = "exec";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      croc
      fastfetch
      ripgrep
      gitFull
      vim
      cloudflared
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEemzAV7rW6hjqVIy1Pktd7jKtlkayVUNHfcO8H6SQfj hush server ssh key"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIgYUNbgUiLAC6k+RgviJvi3DNyaGgENYmwE+Z/x+Zv meta@arch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdHdHNiznomJyPFm5jXWn9DLXsxMoqc2HOetlhus0JS myServer"
    ];
  };

  local.nix.settings.extra-trusted-users = ["exec"];
}
