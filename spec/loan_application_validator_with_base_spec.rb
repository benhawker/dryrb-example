# frozen_string_literal: true

require 'spec_helper'
require './lib/loan_application_validator_with_base'

describe LoanApplicationValidatorWithBase do
  subject(:instance) { described_class.new(input) }

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

  describe '#valid?' do
    context 'when valid' do
      let(:input) { valid_input }

      it 'returns true' do
        expect(instance.valid?).to eq true
      end
    end

    context 'when invalid' do
      let(:input) { {} }

      it 'returns false' do
        expect(instance.valid?).to eq false
      end
    end
  end

  describe '#output?' do
    context 'when valid' do
      let(:input) { valid_input }

      it 'returns the coerced output' do
        expect(instance.output).to eq({
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
