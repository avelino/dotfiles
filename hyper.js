"use strict";
const foregroundColor = '#f8f8f2'
const backgroundColor = '#22212C'
const selection = '#454158'
const comment = '#9580FF'
const red = '#FF9580'
const green = '#8AFF80'
const yellow = '#FFFF80'
const magenta = '#FF80BF'
const cyan = '#80FFEA'
const gray = '#666666'
const brightBlack = '#999999'
const brightWhite = '#ffffff'

module.exports = {
    config: {
	modifierKeys: { altIsMeta: true },
        updateChannel: 'stable',
        fontSize: 22,
        fontFamily: '"MesloLGS NF"',
        fontWeight: 'bold',
        fontWeightBold: 'bold',
        lineHeight: 1,
        letterSpacing: 0,
        cursorAccentColor: '#e51c98',
        cursorShape: 'BLOCK',
        cursorBlink: false,
	    cursorColor: '#e51c98',
        foregroundColor: foregroundColor,
        // terminal background color
        // opacity is only supported on macOS
        backgroundColor: backgroundColor,
        // terminal selection color
        selectionColor: 'rgba(248,28,229,0.3)',
        // border color (window, tabs)
        borderColor: selection,
        css: `
      .hyper_main {
        border-color: #22212C !important;
      }
      .tabs_list .tab_tab.tab_active .tab_text  {
        background: ${backgroundColor};
      }
      .tab_active:before {
        border-color: rgb(68, 71, 90);
      }
    `,

        termCSS: '',
        workingDirectory: '~/projects/',
        showHamburgerMenu: '',
        showWindowControls: '',
        padding: '0px 0px 10px 8px',
        colors: [
            selection,
            red,
            green,
            yellow,
            comment,
            magenta,
            cyan,
            gray,
            brightBlack,
            red,
            green,
            yellow,
            comment,
            magenta,
            cyan,
            brightWhite
        ],
        shell: '/opt/homebrew/bin/zsh',
        shellArgs: ['--login'],
        env: {},
        bell: 'SOUND',
        copyOnSelect: true,
        defaultSSHApp: true,
        quickEdit: false,
        macOptionSelectionMode: 'vertical',
        webGLRenderer: false,
        webLinksActivationKey: '',
        disableLigatures: true,
    },
    plugins: ["hyper-font-smoothing", "hyper-search", "hyper-dracula"],
    localPlugins: [
  "fig-hyper-integration",
    ],
    keymaps: {},
};
