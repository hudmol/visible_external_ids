if AppConfig.has_key?(:show_external_ids)
  # this plugin is superceded by the core changes controlled
  # by the AppConfig setting :show_external_ids

  puts "***"
  puts "The plugin visible_external_ids has been superceded."
  puts "To view external ids in the frontend, set `AppConfig[:show_external_ids] = true`"
  puts "and remove 'visible_external_ids' from AppConfig[:plugins]"

  raise "plugin visible_external_ids no longer needed"
end


Rails.application.config.after_initialize do
  PluginHelper.class_eval do

    alias_method :sidebar_plugins_for_pre_visible_external_ids, :sidebar_plugins_for
    def sidebar_plugins_for(record)
      result = sidebar_plugins_for_pre_visible_external_ids(record)
      if Array(record["external_ids"]).length > 0 || @rendered_external_id_form
        @rendered_external_id_section_id ||= "external_ids"
        menu_item = ""
        menu_item << "<li><a href='##{@rendered_external_id_section_id}'>"
        menu_item << I18n.t("external_id._plural")
        menu_item << '<span class="glyphicon glyphicon-chevron-right"></span></a></li>'
        result = result + menu_item.html_safe
      end
      result.html_safe
    end


    alias_method :form_plugins_for_pre_visible_external_ids, :form_plugins_for
    def form_plugins_for(jsonmodel_type, context)
      result = form_plugins_for_pre_visible_external_ids(jsonmodel_type, context)

      if @rendered_external_id_form
        result << @rendered_external_id_form
      end

      result
    end


    alias_method :show_plugins_for_pre_visible_external_ids, :show_plugins_for
    def show_plugins_for(record, context)
      result = show_plugins_for_pre_visible_external_ids(record, context)

      if !ASUtils.wrap(record["external_ids"]).empty?
        result << render_aspace_partial(:partial => "external_ids/show", :locals => {:external_ids => ASUtils.wrap(record["external_ids"]), :obj => record})
      end

      result
    end

  end


  ApplicationHelper.class_eval do
    alias_method :render_aspace_partial_pre_visible_external_ids, :render_aspace_partial
    def render_aspace_partial(args)

      if !args[:locals].blank? && !args[:locals][:name].blank? && args[:locals][:name] == "external_ids"
        args[:locals][:hidden] = false
        @rendered_external_id_section_id = args[:locals][:section_id] || args[:locals][:form].id_for("external_ids")
        @rendered_external_id_form = render_aspace_partial_pre_visible_external_ids(args);
        return ""
      end

      render_aspace_partial_pre_visible_external_ids(args);
    end
  end

end
