# frozen_string_literal: true

def with_comma(number)
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

# https://dry-rb.org/gems/dry-validation/1.6/macros/
Dry::Validation.register_macro(:value_between_if_present) do |macro:|
  min = macro.args[0]
  max = macro.args[1]
  key.failure("must be in range #{with_comma(min)}-#{with_comma(max)}") if key? && !value.between?(min, max)
end

Dry::Validation.register_macro(:string_length_between_if_present) do |macro:|
  min = macro.args[0]
  max = macro.args[1]
  if key? && !value.length.between?(min, max)
    key.failure("length must be in range #{with_comma(min)}-#{with_comma(max)}")
  end
end
