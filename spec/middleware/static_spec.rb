# frozen_string_literal: true

describe Course::Static do
  subject { described_class.new(app).call(mock_request_env) }

  context 'when static file exists in public folder' do
    let(:app) { ->(_env) { [] } }
    let(:mock_request_env) { request_env_for('/public/500.html') }

    it 'returns valid response with status 200' do
      expect(subject).to eq(public_response_200)
    end
  end

  context 'when static file does not exist in public folder' do
    let(:app) { ->(env) {} }
    let(:mock_request_env) { request_env_for('/public/fake.html') }

    it 'returns valid response with status 404' do
      expect(subject).to eq([404, {}, ''])
    end
  end
end
