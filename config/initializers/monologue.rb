Monologue.config do |config|

  # inherit Rail's named routes like store_path

  config.site_name = "WillowFlare"
  config.blog_name = "Blog"
  config.site_subtitle = "Your personal mobile gaming feed"
  config.site_url = "http://willowflare.com"

  config.meta_description = "WillowFlare: the Best Mobile Games, for you, by you. At this blog, we bring you the latest mobile gaming news."
  config.meta_keyword = "mobile, game"

  config.admin_force_ssl = false
  config.posts_per_page = 5
  config.preview_size = 1000

  config.disqus_shortname = "iqiq"

  # LOCALE
  config.twitter_locale = "en" # "fr"
  config.facebook_like_locale = "en_US" # "fr_CA"
  config.google_plusone_locale = "en"

  # config.layout               = "layouts/application"

  # ANALYTICS
  #config.gauge_analytics_site_id = "YOUR COGE FROM GAUG.ES"
  config.google_analytics_id = "UA-77066601-1"

  config.sidebar = ["latest_posts", "latest_tweets", "categories", "tag_cloud"]


  #SOCIAL
  config.twitter_username = "willowflare"
  config.facebook_url = "https://www.facebook.com/willowflare"
  config.facebook_logo = 'logo.png'
  # config.google_plus_account_url = "https://plus.google.com/u/1/.../posts"
  # config.linkedin_url = "http://www.linkedin.com/in/myhandle"
  # config.github_username = "myhandle"
  config.show_rss_icon = true

end