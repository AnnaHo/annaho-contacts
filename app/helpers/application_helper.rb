module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", class: 'btn ico_btn btn_success')
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, 'remove_fields(this)', class: 'btn ico_btn btn_danger')
  end

end
