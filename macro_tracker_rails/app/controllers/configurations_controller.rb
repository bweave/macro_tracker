class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios
    # NOTE: When/if needed, I could move this to a model in the database
    # and handle fetching specific versions.
    render json: {
             settings: {
               debug: Rails.env.development?,
               primary_color: "#198754", # TODO: kinda sux that this is hardcoded
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
