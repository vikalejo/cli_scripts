require 'spec_helper'
require 'developer_challenge/slow_api.rb'

describe DeveloperChallenge::SlowApi do
  let(:app) { described_class.new }
  let(:response) { 'response_from_slowapi' }

  subject { app.slowapi(number) }

  describe '.slowapi' do
    before do
      allow(app).to receive(:do_request_and_write_response).and_return(true)
      subject
    end

    context 'with parameter correct' do
      let(:number) { '1' }

      it 'do_request and log response succesfully' do
        expect(subject).to be true
      end
    end

    context 'with some error' do
      shared_examples 'some error occurred' do
        it 'returns false' do
          expect(subject).to be false
        end
      end

      context 'with number param incorrect' do
        context 'sending 0 times' do
          let(:number) { '0' }

          it_behaves_like 'some error occurred'
        end

        context 'sending a string' do
          let(:number) { 'something' }

          it_behaves_like 'some error occurred'
        end
      end
    end
  end

  describe '.do_request_to_slowapi' do
    it 'request to slowapi' do
      expect(app.send(:do_request_to_slowapi).body).to eq response
    end
  end
end
