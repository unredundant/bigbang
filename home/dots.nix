{
  config,
  lib,
  ...
}: let
  nu_config_file_path = if config.os == "macos" then "/Users/ryan/Library/Application\ Support/nushell/config.nu" else ".config/nushell/config.nu";
  nu_env_file_path = if config.os == "macos" then "/Users/ryan/Library/Application\ Support/nushell/env.nu" else ".config/nushell/env.nu";
in {
  # TODO: Move this to a common options file
  options = {
    os = lib.mkOption {
      default = "nixos";
      type = lib.types.str;
      description = ''
        Operating system for current configuration
      '';
    };
    desktopEnabled = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = ''
        Set true if a desktop environment is present
      '';
    };
  };

  config = {
    home = {
      # Alacritty
      file.".config/alacritty/alacritty.toml".source = ../dots/alacritty/alacritty.toml;
      file.".config/alacritty/rose-pine-moon.toml".source = ../dots/alacritty/rose-pine-moon.toml;

      # Bat
      file.".config/bat/config".source = ../dots/bat/config;
      file.".config/bat/themes/Catppucin-macchiato.tmTheme".source = ../dots/bat/themes/Catppuccin-macchiato.tmTheme;

      # Git
      file.".gitconfig".source =
        if config.desktopEnabled
        then
          (
            if config.os == "macos"
            then ../dots/git/gitconfig-desktop-macos
            else ../dots/git/gitconfig-desktop-nixos
          )
        else ../dots/git/gitconfig-shell;

      # GitUI
      file.".config/gitui/key_bindings.ron".source = ../dots/gitui/key_bindings.ron;

      # Hyprland
      file.".config/hypr".source = ../dots/hypr;
      file.".config/hypr".recursive = true;

      # Mako
      file.".config/mako/config".source = ../dots/mako/config;

      # Nushell
      file.".config/nushell" = {
        source = ../dots/nushell;
        recursive = true;
      };
      file."${nu_config_file_path}".source = ../dots/nushell/config.nu;
      file."${nu_env_file_path}".source = ../dots/nushell/env.nu;

      # Nvim
      file.".config/nvim".source = ../dots/nvim;
      file.".config/nvim".recursive = true;

      # Qutebrowser
      file.".config/qutebrowser/config.py".source = ../dots/qutebrowser/config.py;

      # SSH
      file.".ssh/config".source =
        if config.desktopEnabled
        then
          (
            if config.os == "macos"
            then ../dots/ssh/config-desktop-macos
            else ../dots/ssh/config-desktop-nixos
          )
        else ../dots/ssh/config-shell;

      # Starship
      file.".config/starship.toml".source = ../dots/starship/starship.toml;

      # WLogout
      file.".config/wlogout/config".source = ../dots/wlogout/config.json;

      # Waybar
      file.".config/waybar".source = ../dots/waybar;
      file.".config/waybar".recursive = true;

      # Wofi
      file.".config/wofi/style.css".source = ../dots/wofi/style.css;

      # Zellij
      file.".config/zellij".source = ../dots/zellij;
      file.".config/zellij".recursive = true;
    };
  };
}
