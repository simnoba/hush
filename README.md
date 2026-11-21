# hush

NixOS flake configuration for the `hush` server.

## Deploy

```sh
sudo nixos-rebuild switch --flake .#hush
```

## Layout

- `machines/` – host configuration
- `hardware/` – hardware configuration
- `modules/` – shared NixOS modules
- `secrets/` – [agenix](https://github.com/ryantm/agenix) encrypted secrets

## License

GPL-3.0, see [LICENSE](LICENSE).
