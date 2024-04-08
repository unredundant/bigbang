{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  nixos-modules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    # TODO: Can I simply import all of the modules somehow?
    nixos-modules._1password
    nixos-modules.boot
    nixos-modules.environment
    nixos-modules.flake-support
    nixos-modules.fonts
    nixos-modules.garbage-collection
    nixos-modules.hardware
    nixos-modules.hyprland
    nixos-modules.locale
    nixos-modules.networking
    nixos-modules.pueue
    nixos-modules.users
    nixos-modules.xdg
    nixos-modules.xserver
  ];

  # TODO: Move to common
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.ryan = import ../../profile/ryan.nix;
  home-manager.extraSpecialArgs = {
    inherit pkgs pkgs-unstable;
  };

  # Enable networking
  networking.hostName = "frame";
  networking.networkmanager.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Finger Print Reader
  services.fprintd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  system.stateVersion = "23.11";
}
