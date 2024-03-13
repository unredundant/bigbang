{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      kotlin-language-server
      lua-language-server
      nil
      rust-analyzer
      stylua
      tailwindcss-language-server
      vscode-langservers-extracted
    ])
    ++ (
      if config.os == "nixos"
      then
        (with pkgs-unstable; [
          htmx-lsp # Can't currently compile on Mac due to C compiler issues :(
        ])
      else []
    );
}
