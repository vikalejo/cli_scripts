require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, 'http://www.slowapi.com/delay/0.3')
    .with(headers: {'Accept'=>'*/*', 'Host'=>'www.slowapi.com', 'User-Agent'=>'Ruby'})
    .to_return(status: 200, body: 'response_from_slowapi', headers: {})
  end
end

