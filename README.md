# hush

NixOS flake configuration for the `hush` server.

## Deploy

```sh
sudo nixos-rebuild switch --flake .#hush
```

We use [nh](https://github.com/nix-community/nh) (nix-helper) to build and deploy the config:

```sh
nh os switch --target-host <host> -H hush
```

## Layout

- `hosts/<name>/` – host configuration and hardware
- `modules/` – system modules
- `services/` – services, one file each
- `secrets/` – [agenix](https://github.com/ryantm/agenix) encrypted secrets

## License

GPL-3.0, see [LICENSE](LICENSE).
