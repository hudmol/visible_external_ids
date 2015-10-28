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
#    alias_method :sidebar_plugins_for_pre_visible_external_ids, :sidebar_plugins_for
#    def sidebar_plugins_for(record)
#      result = sidebar_plugins_for_pre_visible_external_ids(record)
#      if Array(record["external_ids"]).length > 0
#        menu_item = ""
#        menu_item << "<li><a href='#external_ids'>"
#        menu_item << I18n.t("external_id._plural")
#        menu_item << '<span class="glyphicon glyphicon-chevron-right"></span></a></li>'
#        result = result + menu_item.html_safe
#      end
#      result.html_safe
#    end

    alias_method :show_plugins_for_pre_visible_external_ids, :show_plugins_for
    def show_plugins_for(record, context)
      result = show_plugins_for_pre_visible_external_ids(record, context)

      if !ASUtils.wrap(record["external_ids"]).empty?
        result << render_aspace_partial(:partial => "external_ids/show", :locals => {:external_ids => ASUtils.wrap(record["external_ids"]), :obj => record})
      end

      result
    end

#    alias_method :form_plugins_for_pre_visible_external_ids, :form_plugins_for
#    def form_plugins_for(jsonmodel_type, context)
#      result = form_plugins_for_pre_visible_external_ids(jsonmodel_type, context)

#      result << render_aspace_partial(:partial => "shared/subrecord_form",
#                                      :locals => {:form => context, :name => 'external_ids',
#                                        :cardinality => :zero_to_many, :plugin => true})


#      if !ASUtils.wrap(context.obj["external_ids"]).empty?
#        result << render_aspace_partial(:partial => "external_ids/edit", :locals => {:external_ids => ASUtils.wrap(context.obj["external_ids"]), :form => context})
#      end

#      result
#    end
  end
end
