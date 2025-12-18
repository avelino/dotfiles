{ config, pkgs, lib, ... }:

let
  # Definições centralizadas para fácil manutenção
  defaultEditor = "nvim";
  defaultPager = "less -FirSwX";
  logseqPaths = {
    notes = "~/notes";
    cloud = "~/logseq-avelino";
  };
  logseqFunctionBody =
    let
      body = builtins.readFile ./fish/logseq.fish;
    in lib.replaceStrings [ "@NOTES_DIR@" "@CLOUD_DIR@" ] [ logseqPaths.notes logseqPaths.cloud ] body;
  nixCmdRepoDir = "~/dotfiles";
  nixCmdFunctionBody =
    let
      body = builtins.readFile ./fish/nix-cmd.fish;
    in lib.replaceStrings [ "@REPO_DIR@" ] [ nixCmdRepoDir ] body;
in
{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v9.8";
          sha256 = "sha256-xWaMd5POCDeeFTsGtHbIvsPelIp+GZPC1X1CseCo3BA=";
        };
      }
    ];

    # Custom completions
    shellAbbrs = {
      g = "git";
      v = "nvim";
      c = "cursor";
      wi = "windsurf";
      z = "zed-preview";
    };

    functions = {
      ls = "command eza $argv";
      ll = "command eza -l $argv";
      la = "command eza -la $argv";
      lt = "command eza --tree $argv";
      l = "command eza -l $argv";
      tree = "command eza --tree $argv";

      # Git functions
      g = "command git $argv";
      ga = "command git add $argv";
      gc = "command git commit $argv";
      gp = "command git push $argv";
      gpl = "command git pull $argv";
      gs = "command git status $argv";
      gd = "command git diff $argv";
      gl = "command git log $argv";

      # editor
      c = "command cursor $argv";
      wi = "command windsurf $argv";
      v = "command nvim $argv";
      z = "command zed-preview $argv";

      # Define logseq function (body loaded from external file)
      logseq = {
        description = "logseq shortcut with new functions";
        body = logseqFunctionBody;
      };

      # Define nix-cmd function
      nix-cmd = {
        description = "nix and homebrew environment management";
        body = nixCmdFunctionBody;
      };
    };

    shellInit = builtins.readFile ./fish/shellInit.fish;

    interactiveShellInit = builtins.readFile ./fish/interactiveShellInit.fish;
  };

  home = {
    sessionVariables = {
      SHELL = "${pkgs.fish}/bin/fish";
      EDITOR = defaultEditor;
      VISUAL = defaultEditor;
      PAGER = defaultPager;
      MANPAGER = defaultPager;
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      # eza color theme aligned to Monokai Pro (Filter Ristretto)
      # di (dir) = #FF955C (orange), ln (symlink) = #78DCE8, ex (exec) = #A9DC76
      # fi (file) = #FCFCFA, or (orphan) = #FF6188
      EZA_COLORS = "di=38;2;255;149;92:ln=38;2;120;220;232:ex=38;2;169;220;118:fi=38;2;252;252;250:or=38;2;255;97;136";
    };

    packages =
      lib.optionals pkgs.stdenv.isLinux (with pkgs; [
        fzf
        fd
        bat
      ]);

    # Create Fish directories
    file = {
      ".config/fish/.keep".text = "";
    };
  };
}
