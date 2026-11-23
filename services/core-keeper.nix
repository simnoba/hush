{
  virtualisation.oci-containers.containers."core-keeper-dream" = {
    image = "escaping/core-keeper-dedicated";
    autoStart = true;

    environment = {
      WORLD_NAME = "Dream";
      MAX_PLAYERS = "10";
      WORLD_MODE = "1";
      WORLD_INDEX = "0";
    };

    volumes = [
      "/home/exec/core_keeper_dream/server-data:/home/steam/core-keeper-data"
    ];
  };
}
