// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import * as bootstrap from "bootstrap"

const setTheme = () => {
  let theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  document.querySelectorAll("[data-bs-theme]").forEach(
    (el) => el.setAttribute('data-bs-theme', theme)
  )
}
window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', setTheme)

document.addEventListener("turbo:load", function () {
  setTheme()
})
