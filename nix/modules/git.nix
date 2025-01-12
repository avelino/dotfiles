{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Avelino";
    userEmail = "31996+avelino@users.noreply.github.com";
    signing = {
      key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5OfVvY6xmZdtw5pYJMECnfRfMm7zWMytg+IL9AyNhbu8UdBmGdT6wUiBBBw9CTcdnmDYj08n8gWXV6Jz2eazl7fC27HQr9BzJb35FM1LpnXncSDNxn5Itj89ROIgY70d2obp35K9+I+muFkAYuYJEHjtrGr7KIlC1oM+v+K43Jla4SotoBleLNbec0GwtyeYBB7bL9yhGhpEje+dtpLJFd5H/bDBuvjDg/tPHeAnflg0QfUeYfNDC44psY/uJQGBrob3eLcOdJSIV418JS+z1inC9Iljg+xkHGwWg3TSS2lD4ufZcKumBpc2S7T9XSVVB0KDeFTgyQHNDkCtG5xRb";
      signByDefault = true;
      gpgPath = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      github.user = "avelino";
      
      color = {
        ui = "auto";
        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };
        diff = {
          indentHeuristic = true;
          algorithm = "histogram";
          meta = "yellow bold";
          frag = "magenta bold";
          new = "green bold";
        };
      };

      core = {
        editor = "cursor --wait";
        autocrlf = "input";
      };

      difftool = {
        prompt = true;
      };

      diff = {
        tool = "nvimdiff";
      };

      difftool.nvimdiff = {
        cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      };

      merge = {
        log = true;
      };

      mergetool.ediff = {
        cmd = "emacsclient -c --eval \"(ediff-merge-files-with-ancestor \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" nil \\\"$MERGED\\\")\"";
      };

      push = {
        default = "current";
      };

      status = {
        color = true;
        submodulesummary = true;
        showUntrackedFiles = "all";
      };

      apply = {
        whitespace = "fix";
      };

      gpg = {
        format = "ssh";
      };

      commit = {
        gpgsign = true;
        verbose = true;
      };

      branch = {
        autosetuprebase = "always";
      };

      help = {
        autocorrect = 1;
      };

      http = {
        cookiefile = "~/dotfiles/gitcookies";
      };

      url."https://github.com/".insteadOf = "git://github.com/";

      alias = {
        st = "status -sb";
        ci = "commit -v -s";
        commit = "commit -v -s";
        up = "pull --ff-only --all -p";
        who = "blame";
        d = "!git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat";
        di = "!d() { git diff --patch-with-stat HEAD~$1; }; git diff-index --quiet HEAD -- || clear; d";
        url = "! bash -c 'git config --get remote.origin.url | sed -E s/.+:\\(.+\\)\\.git$/https:\\\\/\\\\/github\\\\.com\\\\/\\\\1/g'";
        lg = "log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cI%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph";
        review = "log --summary --patch --stat=100 --dirstat --ignore-all-space --reverse --decorate --find-renames=33 --find-copies-harder --cc";
        ignored = "ls-files --others -i --exclude-standard";
        # golang/core alias
        change = "codereview change";
        gofmt = "codereview gofmt";
        mail = "codereview mail";
        pending = "codereview pending";
        submit = "codereview submit";
        sync = "codereview sync";
      };
    };
    ignores = [
      # Compiled source
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "*.pyc"
      "*.pyo"

      # Packages
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"
      "*.msi"

      # Logs and databases
      "*.log"
      "*.sqlite"

      # OS generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
      "desktop.ini"

      # Temporary files
      "*.bak"
      "*.swp"
      "*.swo"
      "*~"
      "*#"

      # IDE files
      ".vscode"
      ".idea"
      ".iml"
      "*.sublime-workspace"
    ];
  };
} 