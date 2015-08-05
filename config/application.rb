config.filter_parameters :password, :password_confirmation

config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"