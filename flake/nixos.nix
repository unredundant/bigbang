{inputs}: {
  meta = {
    specialArgs = {
      inherit inputs;
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = import ../modules/overlays ++ [inputs.hyprpanel.overlay];
      };
    };
    nixpkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      overlays = import ../modules/overlays ++ [inputs.hyprpanel.overlay];
    };
  };

  frame = {
    imports = [../hosts/frame/configuration.nix];
    deployment = {
      allowLocalDeployment = true;
      targetUser = "ryan";
    };
  };

  gigame = {
    imports = [../hosts/gigame/configuration.nix];
    deployment = {
      allowLocalDeployment = true;
      targetUser = "ryan";
    };
  };

  cloudy = {
    imports = [../hosts/cloudy/configuration.nix];
    deployment = {
      allowLocalDeployment = true;
      buildOnTarget = true;
      targetUser = "ryan";
    };
  };
}
