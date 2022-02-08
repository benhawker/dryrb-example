# frozen_string_literal: true

require 'dry-validation'

class BaseValidator
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def valid?
    contract.call(input).success?
  end

  def output
    contract.call(input).to_h.compact
  end

  def errors
    contract.call(input).errors(locale: I18n.locale).to_h
  end

  private

  def contract
    self.class::Contract.new
  end
end
