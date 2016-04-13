module HoboFields
  module Model
    class RailsAttributeWrapper < ActiveRecord::Type::Value
      def initialize(field_spec)
        @field_spec = field_spec
      end

      def type
        @field_spec.sql_type
      end

      private

      def cast_value(value)
        wrapper_type = @field_spec.model.attr_type(@field_spec.name)
        if wrapper_type && HoboFields.can_wrap?(wrapper_type, value)
          wrapper_type.new(value)
        else
          value
        end
      end
    end
  end
end
