{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

let
  vscodeExtensions = with pkgs-unstable.vscode-extensions; [
    # Nix
    bbenoist.nix
    jnoortheen.nix-ide
    brettm12345.nixfmt-vscode
    mechatroner.rainbow-csv
    # Python
    ms-python.python

    # Docker / Remote
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-containers
    hashicorp.terraform

  ];

  # Flake paths relative to this flake
  flakePath = "/home/thomas/.dotfiles"; # replace with builtins.getFlake if needed
  nixosConfig = "nixosConfigurations.nixos.options";
  homeConfig = "homeConfigurations.thomas.options";

in
{
  nixpkgs.config.allowUnfree = true;
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode; # FHS wrapper
    mutableExtensionsDir = true;

    profiles.default = {
      extensions = vscodeExtensions;

      keybindings = [
        {
          key = "ctrl+`";
          command = "workbench.action.terminal.focus";
          when = "editorTextFocus";
        }
        {
          key = "ctrl+`";
          command = "workbench.action.focusActiveEditorGroup";
          when = "terminalFocus";
        }
        {
          key = "alt+f";
          command = "editor.action.formatDocument";
          when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
        }
      ];

      userSettings = {
        # Global
        "editor.fontFamily" = "CaskaydiaCove Nerd Font Mono";
        "editor.formatOnSave" = true;
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.profiles.linux" = {
          "fish" = {
            "path" = "/usr/bin/fish";
            "args" = [
              "-l"
            ];
          };
        };
        "terminal.integrated.env.linux" = {
          "LANG" = "en_US.UTF-8";
          "LC_ALL" = "en_US.UTF-8";
          "TERM" = "xterm-256color";
          "COLORTERM" = "truecolor";
        };
        "terminal.integrated.shellIntegration.enabled" = false;
        "terminal.integrated.inheritEnv" = false;
        "terminal.integrated.fontFamily" = "CaskaydiaCove Nerd Font Mono";

        "workbench.sideBar.location" = "right";
        "workbench.colorTheme" = "Tokyo Night";

        # Nix settings
        "[nix]" = {
          "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {
            nixd = {
              formatting.command = [ "nixfmt" ];
              options = {
                nixos = {
                  expr = "(builtins.getFlake \"${flakePath}\").${nixosConfig}";
                };
                "home-manager" = {
                  expr = "(builtins.getFlake \"${flakePath}\").${homeConfig}";
                };
              };
            };
          };
        };

        # Python
        "[python]" = {
          "editor.defaultFormatter" = "ms-python.python";
        };
      };
    };
  };
}
