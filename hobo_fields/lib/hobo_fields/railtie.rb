require 'hobo_fields'
require 'rails'

module HoboFields
  class Railtie < Rails::Railtie

    ActiveSupport.on_load(:active_record) do
      unless ActiveRecord::Base.respond_to?(:attribute)
        require 'hobo_fields/extensions/active_record/attribute_methods'
      end
      require 'hobo_fields/extensions/active_record/fields_declaration'
    end

  end
end
