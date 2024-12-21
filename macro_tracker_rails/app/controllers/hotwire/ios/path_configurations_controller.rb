class Hotwire::Ios::PathConfigurationsController < ApplicationController
  allow_unauthenticated_access only: %i[show]

  def show
    render json: {
             settings: {
               debug: Rails.env.development?,
               tabs: [
                 {
                   title: "Today",
                   path: "/",
                   image: "chart.bar",
                   selectedImage: "chart.bar.fill"
                 },
                 {
                   title: "Entries",
                   path: "/entries",
                   image: "note.text",
                   selectedImage: "note.text"
                 },
                 {
                   title: "Goals",
                   path: "/goals",
                   image: "star",
                   selectedImage: "star.fill"
                 },
                 {
                   title: "Food",
                   path: "/foods",
                   image: "fork.knife",
                   selectedImage: "fork.knife.filled"
                 },
                 {
                   title: "Me",
                   path: "/account",
                   image: "person",
                   selectedImage: "person.fill"
                 }
               ]
             },
             rules: [
               {
                 patterns: [ ".*" ],
                 properties: {
                   context: "default",
                   pull_to_refresh_enabled: true
                 }
               },
               {
                 patterns: [ "refresh_historical_location" ],
                 properties: {
                   presentation: "refresh"
                 }
               },
               {
                 patterns: %w[/new$ /edit$],
                 properties: {
                   context: "modal",
                   pull_to_refresh_enabled: false
                 }
               }
             ]
           }
  end
end
