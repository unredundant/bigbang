{
  config,
  lib,
  ...
}: let
  admin = config.host.admin.name;
in {
  # TODO: find a way to merge this with the default home-manager config
  imports = [
    ../common
    ../home-manager/alacritty.nix
    ../home-manager/apps.nix
    ../home-manager/art.nix
    ../home-manager/bat.nix
    ../home-manager/bottom.nix
    ../home-manager/direnv.nix
    ../home-manager/dots.nix
    ../home-manager/git.nix
    ../home-manager/gitui.nix
    ../home-manager/neovim.nix
    ../home-manager/networking.nix
    ../home-manager/nushell.nix
    ../home-manager/rclone.nix
    ../home-manager/starship.nix
    ../home-manager/terminal.nix
    # ../home-manager/wayland.nix
    ../home-manager/zellij.nix
  ];

  home = {
    username = admin;
    homeDirectory = lib.mkForce "/Users/${admin}";
    stateVersion = "24.05";
  };
}
