{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../common/1password.nix
    ../common/boot.nix
    ../common/environment.nix
    ../common/flake-support.nix
    ../common/fonts.nix
    ../common/garbage-collection.nix
    ../common/hardware.nix
    ../common/hyprland.nix
    ../common/locale.nix
    ../common/networking.nix
    ../common/nvidia.nix
    ../common/users.nix
    ../common/security.nix
    ../common/xdg.nix
    ../common/xserver.nix
  ];

  # TODO: Move to common
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.ryan = import ../../profile/ryan.nix;
  home-manager.extraSpecialArgs = {
    inherit pkgs pkgs-unstable;
  };

  # Enable networking
  networking.hostName = "gigame";
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Polkit
  security.polkit.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Docker
  virtualisation.docker.enable = true;

  # System State
  system.stateVersion = "23.11";
}
