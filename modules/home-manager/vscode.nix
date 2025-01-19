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
      "window.commandCenter" = 1;
      "workbench.colorTheme" = "Bearded Theme Arc Blueberry";
      "workbench.iconTheme" = "bearded-icons";
      "workbench.list.smoothScrolling" = true;
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
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        redhat.vscode-yaml
        eamodio.gitlens
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "beardedtheme";
          publisher = "beardedbear";
          version = "8.3.2";
          sha256 = "0zs0j9mmcqyb3yjsbga3d62fd6xkc5fdd068g628xllyg6hyw0ag";
        }
        {
          name = "calva";
          publisher = "betterthantomorrow";
          version = "2.0.410";
          sha256 = "1wankb9vzrflr5n80x2xs76ylanx4pv0wwq1k1b9zr59mk9mz117";
        }
        {
          name = "databricks";
          publisher = "databricks";
          version = "1.0.0";
          sha256 = "1r3lc8gn66v6f4xya2xj0m6rsh9kmp6a34pmninkkwwjad6d1vvp";
        }
        {
          name = "vscode-markdownlint";
          publisher = "davidanson";
          version = "0.54.0";
          sha256 = "171qw6mymc9hmm8xin3gwr8r2ac8yfr3s8agagsqq9193cawbcq6";
        }
        {
          name = "vscode-github-actions";
          publisher = "github";
          version = "0.26.2";
          sha256 = "16kp1yxs798jp8ffqq3ixm3pyz4f3wgdkdyjpjy94ppqp4aklixh";
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
          version = "1.0.17";
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
          sha256 = "1zcbdzsv6vv3zwx5ddbarqizs8s9s57dnf328waq8jgqyzjg31i6";
        }
        {
          name = "code-settings-sync";
          publisher = "shan";
          version = "3.4.3";
          sha256 = "0wdlf34bsyihjz469sam76wid8ylf0zx2m1axnwqayngi3y8nrda";
        }
      ];
  };

  # Create settings.json for Cursor
  home.file."Library/Application Support/Cursor/User/settings.json".text =
    builtins.toJSON config.programs.vscode.userSettings;
}
