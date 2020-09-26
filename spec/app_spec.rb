# frozen_string_literal: true

describe Course::App do
  context 'GET' do
    let(:app) { described_class.new }
    subject { get('/') }

    it 'returns correct response' do
      subject
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('Hello world')
      expect(last_response.headers['Content-Type']).to eq('text/html')
    end
  end
end
