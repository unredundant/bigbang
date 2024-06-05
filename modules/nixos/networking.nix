{config, ...}: {
  networking.hostName = config.host.name;
  services.connman.enable = true;
  services.connman.wifi.backend = "iwd";

  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
    };
  };
}
