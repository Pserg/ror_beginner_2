module Validation
    def self.included(base)
      base.class_variable_set :@@validations, {}
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      def validations
        class_variable_get :@@validations
      end

      def validate(value, validation_type, validation_format = '')
        validations[value] ||= {}
        validations[value][validation_type] = validation_format
      end
    end

    module InstanceMethods

      def valid?
        validate!
        true
      rescue
        false
      end

      private

      def validate!
        self.class.class_variable_get("@@validations").each do |value, arg|
          #puts "v - #{value}, arg - #{arg}"
          arg.each do |valid_type|
            #puts "Valid type - #{valid_type[0]}, Value - #{value}"
            send valid_type[0], value
          end
        end
      end

      def presence(val)
        value = eval("@#{val}")
        raise ArgumentError, 'Attribute error' if value.nil? || value == ''
      end

      def format(val)
        value = eval("@#{val}")
        format = self.class.class_variable_get(:@@validations)[val.to_sym][:format]
        #puts "value - #{value}, format - #{format.class}"
        raise ArgumentError, 'Wrong format' if value.to_s !~ format
      end

      def type(val)
        type = self.class.class_variable_get(:@@validations)[val.to_sym][:type]
        #puts "Valclass - #{eval("@#{val}").class}, Type - #{type}"
        raise ArgumentError, 'Wrong class' unless eval("@#{val}").class == type
      end

      def max_size(val)
        value = eval("@#{val}")
        max_size = self.class.class_variable_get(:@@validations)[val.to_sym][:max_size]
        raise ArgumentError, 'Too much value' if value > max_size
      end
    end
end
