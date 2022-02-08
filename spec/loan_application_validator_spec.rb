# frozen_string_literal: true

require 'spec_helper'
require './lib/loan_application_validator'

describe LoanApplicationValidator do
  subject(:result) { described_class.new.call(input) }

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

  describe '#success?' do
    context 'when success' do
      let(:input) { valid_input }

      it 'returns true' do
        expect(result.success?).to eq true
      end
    end

    context 'when invalid' do
      let(:input) { {} }

      it 'returns false' do
        expect(result.success?).to eq false
      end
    end
  end

  context '#output?' do
    context 'when valid' do
      let(:input) { valid_input }

      it 'returns the coerced output' do
        expect(result.to_h).to eq({
                                    business_naics_code: '123',
                                    business_phone_number: '1234567890',
                                    customers_type: 'large',
                                    email: 'bob@jeff.com',
                                    personal_fico_score: 678,
                                    personal_date_of_birth: '1985-12-12',
                                    personal_user_first_name: 'Jeff'
                                  })
      end
    end
  end
end
