# frozen_string_literal: true

# validator module
module Validator
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
