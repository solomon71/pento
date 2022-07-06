// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {},
    fontFamily: {
      'fascinate': ['fascinate', 'serif'],
      'baloo-400': ['baloo-400', 'sans-serif'],
      'baloo-800': ['baloo-800', 'sans-serif'],
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
