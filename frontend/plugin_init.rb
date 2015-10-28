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
      end

      render_aspace_partial_pre_visible_external_ids(args);
    end
  end

end
