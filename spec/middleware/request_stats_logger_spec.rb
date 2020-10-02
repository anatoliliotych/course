# frozen_string_literal: true

describe Course::RequestStatsLogger do
  let(:mock_env) { request_env_for('/') }
  let(:app) { ->(env) { [status, env, 'Hello world'] } }
  let(:output) { StringIO.new }
  let(:mock_logger) { ::Logger.new(output, datetime_format: '') }

  subject { described_class.new(app, mock_logger).call(mock_env) }

  context 'when status 200' do
    let(:status) { 200 }
    it 'returns correct output' do
      subject
      expect(output.string).to match(%r{\[\w.+\] Request to '/' started})
      expect(output.string).to match(
        %r{\[\w.+\] Request to '/' finished with response status 200 in \w.+ ms}
      )
    end
  end

  context 'when status 500' do
    let(:status) { 500 }
    it 'returns correct output' do
      subject
      expect(output.string).to match(
        %r{\[\w.+\] Request to '/' finished with response status 500 in \w.+ ms}
      )
    end
  end
end
