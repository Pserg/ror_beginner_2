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
        self.class.validations.each do |value, args|
          #puts "v - #{value}, arg - #{args}"
          args.each do |valid_type|
            #puts "Valid type - #{valid_type[0]}, Value - #{value}"
            send valid_type[0], value, args
          end
        end
      end

      def presence(val, *args)
        #puts args.inspect
        value = self.instance_variable_get("@#{val}")
        raise ArgumentError, 'Attribute error' if value.nil? || value == ''
      end

      def format(val, *args)
        value = self.instance_variable_get("@#{val}")
        arguments = args[0]
        #puts arguments.inspect
        format = arguments[__method__.to_sym]
        #puts "value - #{value}, format - #{format.class}"
        raise ArgumentError, 'Wrong format' if value.to_s !~ format
      end

      def type(val, *args)
        arguments = args[0]
        type = arguments[__method__.to_sym]
        #puts "Valclass - #{eval("@#{val}").class}, Type - #{type}"
        raise ArgumentError, 'Wrong class' unless eval("@#{val}").class == type
      end

      def max_size(val, *args)
        arguments = args[0]
        value = self.instance_variable_get("@#{val}")
        max_size = arguments[__method__.to_sym]
        raise ArgumentError, 'Too much value' if value > max_size
      end
    end
end
