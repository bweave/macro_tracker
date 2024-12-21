module ApplicationHelper
  def platform_identifier
    hotwire_native_app? ? "hotwire-native" : "web"
  end

  def page_title
    if hotwire_native_app?
      content_for(:hotwire_native_title) || content_for(:title) ||
        "Macro Tracker"
    else
      content_for(:title) || "Macro Tracker"
    end
  end

  def current_user
    Current.user
  end

  def dynamic_fields_for(f, association, button_text = "Add")
    # stimulus:      controller v
    tag.div data: { controller: "dynamic-fields" } do
      safe_join(
        [
          # render existing fields
          f.fields_for(association) { |ff| yield ff },
          # render "Add" button that will call `add()` function
          # stimulus:         `add(event)` v
          button_tag(
            button_text,
            data: {
              action: "dynamic-fields#add"
            },
            class: "btn btn-outline-primary btn-sm mb-3"
          ),
          # render "<template>"
          # stimulus:           `this.templateTarget` v
          tag.template(data: { dynamic_fields_target: "template" }) do
            f.fields_for association,
                         association.to_s.classify.constantize.new,
                         child_index: "__CHILD_INDEX__" do |ff|
              #           ^ make it easy to gsub from javascript
              yield ff
            end
          end
        ]
      )
    end
  end
end
