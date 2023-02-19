module Validation
  def validate(*args) # :name, :presence
    param, command, arg = args
    hash = {
      presence: lambda {
                  raise 'значение не должно быть пустым' unless param.is_nil? || param.is_empty?
                },
      format: -> { raise 'неправильный формат' if param !~ arg },
      type: -> {   raise 'неправильный тип данных' if param.insstance_of?(arg) }
    }
    define_method(:validate!) do |command|
      hash[command]
    end

    define_method(:valid?) do
      validate!
      true
    rescue StartandError
      false
    end
  end
end
