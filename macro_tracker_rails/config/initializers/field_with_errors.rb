ActionView::Base.field_error_proc =
  proc { |html_tag, instance| html_tag.html_safe }
