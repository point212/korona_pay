# frozen_string_literal: true

RSpec.describe KoronaPay do
  describe '#exchange_rate' do
    subject { described_class.exchange_rate(from, to) }

    let(:from) { 'RUS' }
    let(:to) { 'GEO' }

    it 'get exchange rate from KoronaPay' do
      VCR.use_cassette('exchange_rate') do
        expect(subject).not_to be_nil
        expect(subject).to match Float(35.1186)
      end
    end
  end
end
