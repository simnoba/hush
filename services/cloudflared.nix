{config, ...}: {
  users.groups."cloudflared-secret".gid = 65532;

  age.secrets."cloudflared-tunnel-token" = {
    file = ../secrets/cloudflared-tunnel-token.age;
    group = "cloudflared-secret";
    mode = "0440";
  };

  virtualisation.oci-containers.containers."cloudflared-tunnel" = {
    image = "cloudflare/cloudflared:latest";
    pull = "always";
    autoStart = true;

    extraOptions = [
      "--network=host"
    ];

    volumes = [
      "${config.age.secrets."cloudflared-tunnel-token".path}:/run/secrets/api-token:ro"
    ];
    cmd = ["tunnel" "--no-autoupdate" "run" "--token-file" "/run/secrets/api-token"];
  };
}
