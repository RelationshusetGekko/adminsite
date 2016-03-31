# Be sure to restart your server when you modify this file.

# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths += %w( adminsite/admin )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( admin.css admin.js )
