{config, ...}: {
  # KNOT_MASTER_KEY=<base64>;
  # KNOT_ADMIN_SECRET=<base16>;
  age.secrets."knot-env".file = ../secrets/knot-env.age;

  # Frontend is tangled.org: register knot.plue.space under Settings → Knots there.
  # HTTP (127.0.0.1:5555) is exposed through the cloudflared tunnel.
  services.tangled.knot-rs = {
    enable = true;
    environmentFile = config.age.secrets."knot-env".path;
    settings = {
      server = {
        hostname = "knot.plue.space";
        admins = [
          "did:plc:usucbdwz7frtkxjzxqtdtulu"
        ];
        # git over ssh on the standard port; the system sshd lives on 2200
        ssh_listen_addr = "[::]:22";
      };
      atproto.plc_directory = "https://plc.directory";
      contact.email = "admin@plue.space";
      # enables `knot-server admin ...` (members, invites, bans); value lives in knot-env.age
      acl.legacy_admin_secret_env = "KNOT_ADMIN_SECRET";
      xrpc = {
        trusted_proxy_header = "x-forwarded-for";
        trusted_proxies = ["127.0.0.1" "::1"];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.allowedUDPPorts = [22];
}
