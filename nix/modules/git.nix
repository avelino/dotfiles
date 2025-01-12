{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Avelino";
    userEmail = "t@avelino.xxx";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      color.ui = true;
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      ".env"
      ".direnv"
      "node_modules"
    ];
  };
} 