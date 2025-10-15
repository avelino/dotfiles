{ pkgs, ... }:

{
  # DNS configuration for macOS
  networking = {
    knownNetworkServices = [ "Wi-Fi" "Ethernet" ];
    dns = [
      "9.9.9.9" # Quad9 DNS
      "1.1.1.1" # Cloudflare DNS
      "8.8.8.8" # Google DNS
    ];
  };

  environment.etc = {
    "zshrc" = {
      text = ''
        # System-wide profile for interactive zsh(1) shells.

        # Setup user specific overrides for this in ~/.zshrc. See zshbuiltins(1)
        # and zshoptions(1) for more details.

        # Correctly display UTF-8 with combining characters.  We'll assume UTF-8 if the
        # locale(1) binary is missing entirely.
        if [[ ! -x /usr/bin/locale ]] || [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
            setopt COMBINING_CHARS
        fi

        # Disable the log builtin, so we don't conflict with /usr/bin/log
        disable log

        # Save command history
        HISTFILE=''${ZDOTDIR:-$HOME}/.zsh_history
        HISTSIZE=2000
        SAVEHIST=1000

        # Beep on error
        setopt BEEP

        # Use keycodes (generated via zkbd) if present, otherwise fallback on
        # values from terminfo
        if [[ -r ''${ZDOTDIR:-$HOME}/.zkbd/''${TERM}-''${VENDOR} ]] ; then
            source ''${ZDOTDIR:-$HOME}/.zkbd/''${TERM}-''${VENDOR}
        else
            typeset -g -A key

            [[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
            [[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
            [[ -n "$terminfo[kf3]" ]] && key[F3]=$terminfo[kf3]
            [[ -n "$terminfo[kf4]" ]] && key[F4]=$terminfo[kf4]
            [[ -n "$terminfo[kf5]" ]] && key[F5]=$terminfo[kf5]
            [[ -n "$terminfo[kf6]" ]] && key[F6]=$terminfo[kf6]
            [[ -n "$terminfo[kf7]" ]] && key[F7]=$terminfo[kf7]
            [[ -n "$terminfo[kf8]" ]] && key[F8]=$terminfo[kf8]
            [[ -n "$terminfo[kf9]" ]] && key[F9]=$terminfo[kf9]
            [[ -n "$terminfo[kf10]" ]] && key[F10]=$terminfo[kf10]
            [[ -n "$terminfo[kf11]" ]] && key[F11]=$terminfo[kf11]
            [[ -n "$terminfo[kf12]" ]] && key[F12]=$terminfo[kf12]
            [[ -n "$terminfo[kf13]" ]] && key[F13]=$terminfo[kf13]
            [[ -n "$terminfo[kf14]" ]] && key[F14]=$terminfo[kf14]
            [[ -n "$terminfo[kf15]" ]] && key[F15]=$terminfo[kf15]
            [[ -n "$terminfo[kf16]" ]] && key[F16]=$terminfo[kf16]
            [[ -n "$terminfo[kf17]" ]] && key[F17]=$terminfo[kf17]
            [[ -n "$terminfo[kf18]" ]] && key[F18]=$terminfo[kf18]
            [[ -n "$terminfo[kf19]" ]] && key[F19]=$terminfo[kf19]
            [[ -n "$terminfo[kf20]" ]] && key[F20]=$terminfo[kf20]
            [[ -n "$terminfo[kbs]" ]] && key[Backspace]=$terminfo[kbs]
            [[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
            [[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
            [[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
            [[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
            [[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
            [[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
            [[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
            [[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
            [[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
            [[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
        fi

        # Default key bindings
        [[ -n ''${key[Delete]} ]] && bindkey "''${key[Delete]}" delete-char
        [[ -n ''${key[Home]} ]] && bindkey "''${key[Home]}" beginning-of-line
        [[ -n ''${key[End]} ]] && bindkey "''${key[End]}" end-of-line
        [[ -n ''${key[Up]} ]] && bindkey "''${key[Up]}" up-line-or-search
        [[ -n ''${key[Down]} ]] && bindkey "''${key[Down]}" down-line-or-search

        # Default prompt
        PS1="%n@%m %1~ %# "

        # Useful support for interacting with Terminal.app or other terminal programs
        [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"
      '';
      knownSha256Hashes = [
        "4d1ab5704f9d167a042fecac0d056c8a79a8ebd71e032d3489536c8db9ffe3e0"
        "fb5827cb4712b7e7932d438067ec4852c8955a9ff0f55e282473684623ebdfa1"
        "c5a00c072c920f46216454978c44df044b2ec6d03409dc492c7bdcd92c94a110"
        "40b0d8751adae5b0100a4f863be5b75613a49f62706427e92604f7e04d2e2261"
        "2af1b563e389d11b76a651b446e858116d7a20370d9120a7e9f78991f3e5f336"
      ];
    };

    "zprofile" = {
      text = ''
        # System-wide profile for interactive zsh(1) login shells.

        # Setup user specific overrides for this in ~/.zprofile. See zshbuiltins(1)
        # and zshoptions(1) for more details.

        if [ -z "$LANG" ]; then
            export LANG=C.UTF-8
        fi

        if [ -x /usr/libexec/path_helper ]; then
            eval "$(/usr/libexec/path_helper -s)"
        fi
      '';
      knownSha256Hashes = [
        "f320016e2cf13573731fbee34f9fe97ba867dd2a31f24893d3120154e9306e92"
        "db8422f92d8cff684e418f2dcffbb98c10fe544b5e8cd588b2009c7fa89559c5"
        "0235d3c1b6cf21e7043fbc98e239ee4bc648048aafaf6be1a94a576300584ef2"
      ];
    };
  };

  system.activationScripts.migrateZshConfigs.text = ''
    for file in zshrc zprofile; do
      target="/etc/$file"
      if [ -e "$target" ] && [ ! -L "$target" ]; then
        timestamp=$(date +%s)
        backup="$target.before-nix-darwin"
        if [ -e "$backup" ]; then
          backup="$backup.$timestamp"
        fi
        echo "Moving $target to $backup"
        mv "$target" "$backup"
      fi
    done
  '';
}
