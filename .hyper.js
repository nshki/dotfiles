//==============================================================================
//                       _                           _
//                      | |__  _   _ _ __   ___ _ __(_)___
//                      | '_ \| | | | '_ \ / _ \ '__| / __|
//                     _| | | | |_| | |_) |  __/ |_ | \__ \
//                    (_)_| |_|\__, | .__/ \___|_(_)/ |___/
//                             |___/|_|           |__/
//
//==============================================================================

module.exports = {
  config: {
    fontSize: 14,
    fontFamily: '"Fira Code", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',
    cursorColor: 'rgba(248, 28, 229, 0.75)',
    cursorShape: 'BLOCK',
    foregroundColor: '#fff',
    backgroundColor: '#000',
    borderColor: '#333',
    css: '',
    termCSS: '',
    padding: '12px 14px',
    colors: {
      black: '#000000',
      red: '#ff0000',
      green: '#33ff00',
      yellow: '#ffff00',
      blue: '#0066ff',
      magenta: '#cc00ff',
      cyan: '#00ffff',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#ff0000',
      lightGreen: '#33ff00',
      lightYellow: '#ffff00',
      lightBlue: '#0066ff',
      lightMagenta: '#cc00ff',
      lightCyan: '#00ffff',
      lightWhite: '#ffffff'
    },
    shell: '',
    enableVibrancy: true,
    confirmQuit: true,
  },

  plugins: [
    'hypercwd',
    'hyper-one-light',
    'hyper-confirm',
  ],

  localPlugins: []
};
