const plugin = require('tailwindcss/plugin')

module.exports = {
  content: ["./app/**/*.{html,js,erb}"],
  theme: {
    extend: {},
  },
  plugins: [
    plugin(function({ addBase, theme }) {
      addBase({
        'h1': { fontSize: theme('fontSize.4xl') },
      })
    })
  ],
}
