# frozen_string_literal: true

require 'spec_helper'
require './lib/loan_application_simple_schema'

describe LoanApplicationSimpleSchema do
  subject(:result) { described_class.call(input) }

  let(:valid_input) do
    {
      business_naics_code: '123',
      business_phone_number: '1234567890',
      customers_type: 'large',
      email: 'bob@jeff.com',
      personal_fico_score: '678',
      personal_date_of_birth: '1985-12-12',
      personal_user_first_name: 'Jeff'
    }
  end

  # https://dry-rb.org/gems/dry-schema/1.5/basics/working-with-schemas/#calling-a-schema
  describe '#result' do
    context 'when valid' do
      let(:input) { valid_input }

      it 'returns success? true' do
        expect(result.success?).to eq true
      end
    end

    context 'when invalid' do
      let(:input) { {} }

      it 'returns failure? true' do
        expect(result.failure?).to eq true
      end
    end
  end

  # https://dry-rb.org/gems/dry-schema/1.5/basics/working-with-schemas/#working-with-error-messages
  describe '#errors' do
    context 'when valid' do
      let(:input) { valid_input }

      it 'returns no errors' do
        expect(result.errors(full: true).to_h).to eq({})
      end
    end

    context 'when invalid' do
      let(:input) { {} }

      it 'returns the error messages' do
        expect(result.errors(full: true).to_h).to eq(
          business_naics_code: ['business_naics_code is missing'],
          business_phone_number: ['business_phone_number is missing'],
          customers_type: ['customers_type is missing'],
          email: ['email is missing'],
          personal_date_of_birth: ['personal_date_of_birth is missing'],
          personal_user_first_name: ['personal_user_first_name is missing']
        )
      end
    end
  end
end
