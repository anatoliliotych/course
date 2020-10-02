# frozen_string_literal: true

describe Course::ErrorStatusHandler do
  subject { described_class.new(app).call({}) }

  context 'when 404 status' do
    let(:app) { ->(env) { [404, env, ''] } }

    it 'returns valid response' do
      expect(subject).to eq(response_404)
    end
  end

  context 'when 500 status' do
    let(:app) { ->(env) { [500, env, ''] } }
    it 'returns correct response' do
      expect(subject).to eq(response_500)
    end
  end
end
