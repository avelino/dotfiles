{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = {
      "[python]" = {
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "always";
        };
        "editor.insertSpaces" = true;
        "editor.rulers" = [ 88 ];
        "editor.tabSize" = 4;
        "files.associations" = {
          "**/*.html" = "html";
          "**/requirements{/**,*}.{txt,in}" = "pip-requirements";
          "**/templates/**/*.html" = "django-html";
        };
        "python.analysis.extraPaths" = [ "\${workspaceFolder}" ];
        "python.linting.pylintArgs" = [
          "--disable=C0111"
          "--load-plugins=pylint_pydantic"
        ];
      };
      "accessibility.signals.chatRequestSent" = {
        "sound" = "off";
      };
      "accessibility.signals.chatResponseReceived" = {
        "sound" = "off";
      };
      "accessibility.signals.error" = {
        "sound" = "off";
      };
      "accessibility.signals.info" = {
        "sound" = "off";
      };
      "accessibility.signals.warning" = {
        "sound" = "off";
      };
      "accessibility.signals.progress" = {
        "sound" = "off";
      };
      "accessibility.signals.lineHasBreakpoint" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.clear" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.onDebugBreak" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.diffLineDeleted" = {
        "sound" = "off";
      };
      "accessibility.signals.diffLineInserted" = {
        "sound" = "off";
      };
      "accessibility.signals.diffLineModified" = {
        "sound" = "off";
      };
      "accessibility.signals.positionHasError" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.lineHasError" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.lineHasFoldedArea" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.lineHasInlineSuggestion" = {
        "sound" = "off";
      };
      "accessibility.signals.noInlayHints" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.notebookCellCompleted" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.notebookCellFailed" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.taskCompleted" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.taskFailed" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.terminalBell" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.terminalCommandFailed" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.terminalCommandSucceeded" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.terminalQuickFix" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.voiceRecordingStarted" = {
        "sound" = "off";
      };
      "accessibility.signals.voiceRecordingStopped" = {
        "sound" = "off";
      };
      "accessibility.signals.positionHasWarning" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "accessibility.signals.lineHasWarning" = {
        "sound" = "off";
        "announcement" = "auto";
      };
      "autoDocstring.docstringFormat" = "google";
      "autoDocstring.startOnNewLine" = true;
      "calva.autoConnect" = true;
      "calva.evalOnSave" = true;
      "calva.fmt.alignMapItems" = true;
      "calva.fmt.newIndentEngine" = true;
      "calva.highlight.commentFormStyle" = {
        "textDecoration" = "none; opacity: 0.5";
      };
      "calva.highlight.enableBracketColors" = true;
      "calva.paredit.defaultKeyMap" = "strict";
      "calva.prettyPrintingOptions" = {
        "enabled" = true;
        "printEngine" = "pprint";
        "width" = 120;
      };
      "calva.replConnectSequences" = [
        {
          "afterCLJReplJackInCode" = "(println \"REPL is ready!\")";
          "cljsType" = "none";
          "name" = "Project REPL";
          "projectType" = "deps.edn";
        }
      ];
      "calva.showDocstringInParameterHelp" = true;
      "chat.editor.fontFamily" = "Maple Mono";
      "chat.editor.fontSize" = 20;
      "debug.console.fontFamily" = "Maple Mono";
      "editor.accessibilitySupport" = "on";
      "editor.autoClosingBrackets" = "always";
      "editor.autoClosingPairs" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.fontFamily" = "Maple Mono";
      "editor.fontLigatures" = false;
      "editor.fontSize" = 20;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.guides.bracketPairs" = true;
      "editor.guides.indentation" = true;
      "editor.inlayHints.fontSize" = 20;
      "editor.minimap.enabled" = false;
      "editor.scrollbar.horizontal" = "hidden";
      "editor.scrollbar.vertical" = "hidden";
      "editor.semanticHighlighting.enabled" = true;
      "editor.smoothScrolling" = true;
      "editor.suggestFontSize" = 20;
      "files.autoSave" = "afterDelay";
      "files.trimTrailingWhitespace" = true;
      "markdown.preview.fontFamily" = "Maple Mono";
      "markdown.preview.fontSize" = 20;
      "python.analysis.autoImportCompletions" = true;
      "python.analysis.completeFunctionParens" = true;
      "python.analysis.diagnosticMode" = "workspace";
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      "python.analysis.typeCheckingMode" = "basic";
      "python.defaultInterpreterPath" = "\${workspaceFolder}/.venv/bin/python";
      "python.formatting.blackArgs" = [ "--line-length=88" ];
      "python.formatting.provider" = "black";
      "python.linting.banditEnabled" = true;
      "python.linting.enabled" = true;
      "python.linting.flake8Args" = [
        "--max-line-length=88"
        "--extend-ignore=E203"
      ];
      "python.linting.flake8Enabled" = true;
      "python.linting.mypyArgs" = [
        "--ignore-missing-imports"
        "--follow-imports=silent"
        "--strict"
      ];
      "python.linting.mypyEnabled" = true;
      "python.linting.pylintEnabled" = true;
      "python.terminal.activateEnvironment" = true;
      "scm.inputFontFamily" = "Maple Mono";
      "sync.autoDownload" = true;
      "sync.autoUpload" = true;
      "sync.gist" = "2c780b5ef8f5ee3d6c433a74e2e2cca5";
      "sync.syncExtensions" = true;
      "sync.quietSync" = true;
      "terminal.integrated.fontFamily" = "Maple Mono";
      "terminal.integrated.fontSize" = 20;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "terminal.integrated.defaultProfile.osx" = "fish";
      "terminal.integrated.profiles.osx" = {
        "fish" = {
          "path" = "${pkgs.fish}/bin/fish";
          "args" = [ "--login" ];
        };
      };
      "terminal.integrated.profiles.linux" = {
        "fish" = {
          "path" = "${pkgs.fish}/bin/fish";
          "args" = [ "--login" ];
        };
      };
      "window.commandCenter" = 1;
      "workbench.colorTheme" = "Bearded Theme Arc Blueberry";
      "workbench.iconTheme" = "bearded-icons";
      "workbench.list.smoothScrolling" = true;
      "workbench.sideBar.location" = "right";
      "redhat.telemetry.enabled" = true;
      "[nix]" = {
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
      };
    };

    # Extensions
    extensions =
      with pkgs.vscode-extensions;
      [
        bbenoist.nix
        brettm12345.nixfmt-vscode
        eamodio.gitlens
        esbenp.prettier-vscode
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-vscode-remote.remote-containers
        redhat.vscode-yaml
        vue.volar
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-github-actions";
          publisher = "github";
          version = "0.25.8";
          sha256 = "sha256-N9xW/RdVxsGQepnoR1SHRAL48/pk95qQ8I5xc8y3qB4=";
        }
        {
          name = "beardedtheme";
          publisher = "beardedbear";
          version = "8.3.2";
          sha256 = "0zs0j9mmcqyb3yjsbga3d62fd6xkc5fdd068g628xllyg6hyw0ag";
        }
        {
          name = "beardedicons";
          publisher = "beardedbear";
          version = "1.18.0";
          sha256 = "sha256-m8utv500Xk6jLI5ndNfiOoPZfyJcLC2XuNwLdC9J+6w=";
        }
        {
          name = "calva";
          publisher = "betterthantomorrow";
          version = "2.0.410";
          sha256 = "1wankb9vzrflr5n80x2xs76ylanx4pv0wwq1k1b9zr59mk9mz117";
        }
        {
          name = "vscode-markdownlint";
          publisher = "davidanson";
          version = "0.54.0";
          sha256 = "sha256-BrPFFRspJIz1U08hPbLziCmRUeZv2NhRrTCx6qvhOJw=";
        }
        {
          name = "debugpy";
          publisher = "ms-python";
          version = "2024.0.0";
          sha256 = "0vskdvljfzfb6gm5v9sqw0l11db6dv6vgfvxmx0iwr1r1iy5rmc6";
        }
        {
          name = "jupyter-renderers";
          publisher = "ms-toolsai";
          version = "1.0.15";
          sha256 = "1c065s2cllf2x90i174qs2qyzywrlsjkc6agcc9qvdsb426c6r9l";
        }
        {
          name = "vscode-jupyter-cell-tags";
          publisher = "ms-toolsai";
          version = "0.1.8";
          sha256 = "14zzr0dyr110yn53d984bk6hdn0mgva4jxvxzihvsn6lv6kg50yj";
        }
        {
          name = "vscode-jupyter-slideshow";
          publisher = "ms-toolsai";
          version = "0.1.5";
          sha256 = "1p6r5vkzvwvxif3wxqi9599vplabzig27fzzz0bx9z0awfglzyi7";
        }
        {
          name = "vscode-sort-json";
          publisher = "richie5um2";
          version = "1.20.0";
          sha256 = "sha256-Jobx5Pf4SYQVR2I4207RSSP9I85qtVY6/2Nvs/Vvi/0=";
        }
        {
          name = "code-settings-sync";
          publisher = "shan";
          version = "3.4.3";
          sha256 = "sha256-qmWL/IjPeoW57SpU0T9w1KMWuTlV6WTIlzB6vchwtHE=";
        }
        {
          name = "sqltools";
          publisher = "mtxr";
          version = "0.27.1";
          sha256 = "sha256-5XhPaxwr0yvIX0wSKDiDm+1iG947s84ULaWpxfpRcAU=";
        }
      ];
  };

  # Create settings.json for Cursor
  home.file."Library/Application Support/Cursor/User/settings.json".text =
    builtins.toJSON config.programs.vscode.userSettings;

  home.file.".cursorrc".text =
    builtins.toJSON {
      ai = {
        provider = "anthropic";
        model = "claude-3-opus";
        systemPrompt = ''
          You are a helpful AI programming assistant (very experienced).
          You will help me write clean, maintainable, and efficient code.
          You will provide clear explanations and suggestions.
          You will follow best practices and design patterns.
          You will help identify potential issues and improvements.
          Write simple, efficient, readable and testable functions/classes/methods.
          All content generated in the project will be in EN.
          All content generated in chat will be in pt-BR.
          All content generated in composer will be in pt-BR.
        '';
      };
    };

  # Create Cursor rules file
  home.file.".cursor/rules".text = ''
    # Cursor Rules Configuration

    # Editor Rules
    editor.fontFamily = "Maple Mono"
    editor.fontSize = 20
    editor.theme = "Bearded Theme Arc Blueberry"
    editor.minimap = false
    editor.scrollbar = false
    editor.formatOnSave = true
    editor.formatOnPaste = true
    editor.bracketPairColorization = true
    editor.smoothScrolling = true

    # Terminal Rules
    terminal.shell = "${pkgs.fish}/bin/fish"
    terminal.fontFamily = "Maple Mono"
    terminal.fontSize = 20

    # AI Assistant Rules
    ai.model = "claude-3-sonnet"
    ai.temperature = 0.7
    ai.maxTokens = 4096
    # ai.systemPrompt = "You are a helpful AI programming assistant."

    # File Explorer Rules
    explorer.compactFolders = true
    explorer.autoReveal = true

    # Search Rules
    search.smartCase = true
    search.useGlobalIgnoreFiles = true

    # Git Rules
    git.enableSmartCommit = true
    git.autofetch = true
    git.confirmSync = false

    # Language Specific Rules
    [python]
    editor.tabSize = 4
    editor.rulers = [88]
    editor.formatOnSave = true

    [nix]
    editor.tabSize = 2
    editor.formatOnSave = true

    [clojure]
    editor.tabSize = 2
    editor.formatOnSave = true
  '';
}
