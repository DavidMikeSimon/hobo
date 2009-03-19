namespace :hobo_jquery do
  desc "Update the hobo-jquery assets"
  task :update_assets => :environment do
    HOBO_JQUERY_HOME = File.dirname(__FILE__)+"/.."
    FileUtils.cp "#{HOBO_JQUERY_HOME}/public/javascripts/hobo-jquery.js", "#{RAILS_ROOT}/public/javascripts/hobo-jquery.js"
    FileUtils.cp "#{HOBO_JQUERY_HOME}/public/stylesheets/hobo-jquery.css", "#{RAILS_ROOT}/public/stylesheets/hobo-jquery.js" 
  end

  desc "Link the hobo-jquery assets"
  task :link_assets => :environment do
    HOBO_JQUERY_HOME = File.dirname(__FILE__)+"/.."
    FileUtils.ln_sf "#{HOBO_JQUERY_HOME}/public/javascripts/hobo-jquery.js", "#{RAILS_ROOT}/public/javascripts/hobo-jquery.js"
    FileUtils.ln_sf "#{HOBO_JQUERY_HOME}/public/stylesheets/hobo-jquery.css", "#{RAILS_ROOT}/public/stylesheets/hobo-jquery.js" 
  end

  desc "Install JQuery and JQuery-UI"
  task :install_jquery => :environment do
    HOBO_JQUERY_HOME = File.dirname(__FILE__)+"/.."
    FileUtils.cp_r "#{HOBO_JQUERY_HOME}/jquery/javascripts/*", "#{RAILS_ROOT}/public/javascripts/"
    FileUtils.cp_r "#{HOBO_JQUERY_HOME}/jquery/stylesheets/*", "#{RAILS_ROOT}/public/stylesheets/"
  end

  desc "Link JQuery and JQuery-UI"
  task :link_jquery => :environment do
    HOBO_JQUERY_HOME = File.dirname(__FILE__)+"/.."
    Dir["#{HOBO_JQUERY_HOME}/jquery/javascripts/*"].each {|f| FileUtils.ln_sf f, "#{RAILS_ROOT}/public/javascripts/"}
    Dir["#{HOBO_JQUERY_HOME}/jquery/stylesheets/*"].each {|f| FileUtils.ln_sf f, "#{RAILS_ROOT}/public/stylesheets/"}
  end

end
