{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;

    userName = "Avelino";
    userEmail = "31996+avelino@users.noreply.github.com";

    signing = {
      key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5OfVvY6xmZdtw5pYJMECnfRfMm7zWMytg+IL9AyNhbu8UdBmGdT6wUiBBBw9CTcdnmDYj08n8gWXV6Jz2eazl7fC27HQr9BzJb35FM1LpnXncSDNxn5Itj89ROIgY70d2obp35K9+I+muFkAYuYJEHjtrGr7KIlC1oM+v+K43Jla4SotoBleLNbec0GwtyeYBB7bL9yhGhpEje+dtpLJFd5H/bDBuvjDg/tPHeAnflg0QfUeYfNDC44psY/uJQGBrob3eLcOdJSIV418JS+z1inC9Iljg+xkHGwWg3TSS2lD4ufZcKumBpc2S7T9XSVVB0KDeFTgyQHNDkCtG5xRb";
      signByDefault = true;
    };

    extraConfig = {
      github.user = "avelino";
      core = {
        editor = "cursor --wait";
        # editor = "zed --wait";
        autocrlf = "input";
      };
      color = {
        ui = "auto";
        diff = {
          indentHeuristic = true;
          algorithm = "histogram";
          meta = "yellow bold";
          frag = "magenta bold";
          new = "green bold";
        };
      };
      diff.tool = "cursor";
      difftool = {
        prompt = true;
        cursor.cmd = "cursor -d \"$LOCAL\" \"$REMOTE\"";
      };
      merge.log = true;
      push.default = "current";
      status = {
        color = true;
        submodulesummary = true;
        showUntrackedFiles = "all";
      };
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit = {
        verbose = true;
      };
      branch.autosetuprebase = "always";
      help.autocorrect = 1;
      init.defaultBranch = "main";
      pull.rebase = true;
      url."https://github.com/".insteadOf = "git://github.com/";
    };

    aliases = {
      st = "status -sb";
      ci = "commit -v -s";
      commit = "commit -v -s";
      up = "pull --ff-only --all -p";
      who = "blame";
      d = "!git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat";
      di = "!d() { git diff --patch-with-stat HEAD~$1; }; git diff-index --quiet HEAD -- || clear; d";
      lg = "log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cI%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph";
      ignored = "ls-files --others -i --exclude-standard";
    };
  };
}
