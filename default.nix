{ver ? "10"}:
let
  pkgs = import <nixpkgs> {};

  /* start example */
  envPkgs = with pkgs;
    [
      # Custom
      nodejs

      # NixPkgs
      git
      xsel
    ];
    /* end example */

  # Create a project relative config directory for storing all external program information
  configPath = builtins.toPath (builtins.getEnv "PWD") + "/.nixconfig";
  nodejs = pkgs."nodejs-${ver}_x";

in
  if pkgs.lib.inNixShell
  then pkgs.mkShell
    { buildInputs = envPkgs;
      shellHook = ''
        export PATH="$PWD/node_modules/.bin/:$PATH"
        [ "$NODE_ENV" != "ci" ] && npm i || npm ci
        npm dedupe
        npm prune
        npm audit fix
      '';
    }
  else envPkgs

