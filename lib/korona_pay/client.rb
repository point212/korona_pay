require 'faraday'

module KoronaPay::Client
  KORONAPAY_URL = 'https://koronapay.com/transfers/online/api/transfers/'

  def self.client
    @client ||= Faraday.new(
      url: KORONAPAY_URL,
      headers: {'Content-Type' => 'application/json'}
    ) do |f|
      f.response :raise_error
      f.response :json # decode response bodies as JSON
      f.adapter :net_http # Use the Net::HTTP adapter
    end
  end

  def self.tariffs(sending_country, sending_currency, receiving_country, receiving_currency, amount)
    raise KoronaPay::Error unless sending_country && sending_currency && receiving_country && receiving_currency && amount

    resp = client.get('tariffs', { sendingCountryId: sending_country,
                            sendingCurrencyId: sending_currency,
                            receivingCountryId: receiving_country,
                            receivingCurrencyId: receiving_currency,
                            receivingAmount: amount,
                            paymentMethod: 'debitCard',
                            receivingMethod: 'cash'
    })

    raise KoronaPay::Error unless resp.success?
    raise KoronaPay::Error if resp.body.empty?

    data = resp.body.first.slice('exchangeRate', 'receivingAmount', 'sendingAmount')

    {
      exchange_rate: data['exchangeRate'],
      receiving_amount: data['receivingAmount'],
      sending_amount: data['sendingAmount']
    }
  rescue Faraday::Error => e
    raise KoronaPay::Error(e)
  end
end
