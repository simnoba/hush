# hush

NixOS flake configuration for the `hush` server.

## Deploy

```sh
sudo nixos-rebuild switch --flake .#hush
```

## Layout

- `hosts/<name>/` – host configuration and hardware
- `modules/` – system settings
- `services/` – apps, one file each
- `secrets/` – [agenix](https://github.com/ryantm/agenix) encrypted secrets

## License

GPL-3.0, see [LICENSE](LICENSE).
