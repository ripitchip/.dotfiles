{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
  xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;

  # Declarative PNPM setup so pnpm doesn't need to edit config.fish
  xdg.configFile."fish/conf.d/pnpm.fish".text = ''
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    if not test -d $PNPM_HOME
      mkdir -p $PNPM_HOME
    end
    # Ensure PNPM_HOME is on PATH (idempotent)
    if not contains $PNPM_HOME $fish_user_paths
      fish_add_path -Ua $PNPM_HOME
    end
  '';
}
