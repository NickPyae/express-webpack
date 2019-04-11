module.exports = {
  presets: [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current',
        },
      },
    ],
  ],
  plugins: [
    '@babel/plugin-transform-modules-commonjs',
    [
      '@babel/plugin-transform-runtime',
      {
        corejs: 2,
      },
    ],
    'source-map-support',
  ],
  sourceMaps: true,
};
