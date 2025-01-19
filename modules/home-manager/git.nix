{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isDesktop = osConfig.host.desktop.enable;
  workUser = {
    email = "ryan@withodyssey.com";
    signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvZU9QjyJpanD7LGnSn4e5gcOdLqL8nkUYfowWyrFvl";
  };
in {
  programs.git = {
    enable = true;
    userName = "Ryan Brink";
    userEmail = "dev@ryanbr.ink";

    includes = [
      {
        condition = "gitdir:~/Workspace/withodyssey/";
        contents = {
          user = workUser;
        };
      }
      {
        condition = "gitdir:~/Workspace/ryan-odyssey/";
        contents = {
          user = workUser;
        };
      }
    ];

    difftastic = {
      enable = true;
      background = "dark";
    };

    aliases = {
      blah = "git add .; git commit -m 'blah'; git push";
      co = "checkout";
      cs = "commit --allow-empty-message -m ''";
      cm = "commit -m";
      dft = "difftool";
      dlog = "!f() { GIT_EXTERNAL_DIFF=difft git log -p --ext-diff $@; }; f";
      main = "git co main; git pl";
      pl = "pull";
      ps = "push";
    };

    extraConfig = {
      commit = {
        gpgsign = true;
      };
      diff = {
        tool = "difftastic";
      };
      difftool = {
        prompt = false;
      };
      "difftool \"difftastic\"" = {
        cmd = "difft \"$LOCAL\" \"$REMOTE\"";
      };
      init = {
        defaultBranch = "main";
      };
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = lib.mkIf isDesktop {
        program =
          if isDarwin
          then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
          else "/run/current-system/sw/bin/op-ssh-sign";
      };
      push = {
        autoSetupRemote = true;
      };
      user = {
        signingKey = osConfig.host.gitSigningKey;
      };
    };
  };

  programs.git-cliff = {
    enable = true;
  };
}
