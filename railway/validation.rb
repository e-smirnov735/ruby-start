module Validation
  def validate(*args) # :name, :presence
    if args[1] == :presence
      raise 'значение не должно быть пустым' unless args[0].is_nil? || args[0].is_empty?
    elsif args[1] == :format
      raise "неправильный формат" if args[0] !~ args[2]
    elsif args[1] == :type
      
    end
end
