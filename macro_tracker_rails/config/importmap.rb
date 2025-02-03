# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/strada", to: "@hotwired--strada.js" # @1.0.0
pin_all_from "app/javascript/controllers", under: "controllers"
pin "popper", to: "popper.min.js"
pin "bootstrap", to: "bootstrap.min.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.7/dist/chart.js"
pin "@kurkle/color",
    to: "https://ga.jspm.io/npm:@kurkle/color@0.3.4/dist/color.esm.js"
