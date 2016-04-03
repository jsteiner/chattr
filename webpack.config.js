var path = require("path");

module.exports = {
  entry: "./elm/Main.elm",

  output: {
    path: path.resolve(__dirname + '/static/js'),
    filename: '[name].js',
    libraryTarget: 'var',
    library: 'Elm'
  },

  module: {
    loaders: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack',
      },
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    inline: true,
    stats: { colors: true },
  },
};
