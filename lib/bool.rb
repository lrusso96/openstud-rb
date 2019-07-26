class Class
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