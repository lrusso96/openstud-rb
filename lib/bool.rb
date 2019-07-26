# frozen_string_literal: true

# @abstract
class Class
  # attr_accessor, but for bool!
  # @param [Array] args
  def bool_accessor(*args)
    args.each do |arg|
      define_method("#{arg}?") { !instance_variable_get("@#{arg}").nil? }

      define_method("#{arg}!") do
        instance_variable_set("@#{arg}", true)
        self
      end
    end
  end
end
