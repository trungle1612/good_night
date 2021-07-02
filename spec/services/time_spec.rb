# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Time do
  describe 'valid' do
    subject(:valid) { described_class.valid? datetime }
    let(:datetime) { "#{date} #{hour}:#{min}" }
    let(:date) { '2020-01-01' }
    let(:hour) { '01' }
    let(:min)  { '10' }

    context 'when datetime valid' do
      it { expect(valid).to eq true }
    end

    context 'when hour is invalid' do
      let(:hour) { '99' }
      it { expect(valid).to eq false }
    end

    context 'when minute is invalid' do
      let(:min) { '99' }
      it { expect(valid).to eq false }
    end
  end
end
