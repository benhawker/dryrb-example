# frozen_string_literal: true

require 'dry/schema'
require 'uri'

DATE_REGEX = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/ # YYYY-MM-DD
CUSTOMER_TYPES = %w[large small government consumers none].freeze

# An example only using dry-schema
LoanApplicationSimpleSchema = Dry::Schema.Params do
  required(:business_naics_code).filled(:string)
  required(:business_phone_number).filled(:string, size?: 10)
  required(:customers_type).filled(:string, included_in?: CUSTOMER_TYPES)
  required(:email).filled(:string, format?: URI::MailTo::EMAIL_REGEXP)
  optional(:personal_fico_score).value(:integer)
  required(:personal_date_of_birth).filled(:string, format?: DATE_REGEX)
  required(:personal_user_first_name).filled(:string, min_size?: 2)
end
