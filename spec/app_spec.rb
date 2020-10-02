# frozen_string_literal: true

describe Course::App do
  let(:app) do
    Rack::Builder.new do
      use Course::RequestStatsLogger
      use Course::ErrorStatusHandler
      use Course::Static
      use Course::Rescuer
      run Course::App.new
    end
  end

  subject { get(path) }
  context 'GET' do
    before(:each) do
      subject
    end

    context 'when root' do
      let(:path) { '/' }

      it 'returns valid response with status 200' do
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq('Hello world')
        expect(last_response.headers['Content-Type']).to eq('text/plain')
      end
    end

    context 'static page in public folder' do
      context 'when exists' do
        let(:path) { '/public/500.html' }

        it 'returns valid response with status 200' do
          expect(last_response.status).to eq(200)
          expect(last_response.body).to match(%r{<h1>Error 500</h1>})
          expect(last_response.headers['Content-Type']).to eq('text/html')
        end
      end
      context 'when does not exist' do
        let(:path) { '/public/fake.html' }

        it 'returns valid response with status 404' do
          expect(last_response.status).to eq(404)
          expect(last_response.body).to match(%r{<h1>Error 404</h1>})
          expect(last_response.headers['Content-Type']).to eq('text/html')
        end
      end
    end

    context 'non existing page' do
      let(:path) { '/fake.html' }

      it 'returns valid response with status 404' do
        expect(last_response.status).to eq(404)
        expect(last_response.body).to match(%r{<h1>Error 404</h1>})
        expect(last_response.headers['Content-Type']).to eq('text/html')
      end
    end
  end

  context 'when app raises error' do
    let(:path) { '/500.html' }
    before(:each) do
      allow_any_instance_of(Course::App).to receive(:serve_request).and_raise('boom')
    end

    it 'returns valid response with status 500' do
      subject
      expect(last_response.status).to eq(500)
      expect(last_response.body).to match(%r{<h1>Error 500</h1>})
      expect(last_response.headers['Content-Type']).to eq('text/html')
    end

    it 'returns correct output' do
      expect_any_instance_of(Logger).to receive(:info).with(
        %r{\[\w.+\] Request to '/500.html' failed with exception boom}
      )
      expect_any_instance_of(Logger).to receive(:info).with(
        /Backtrace: /
      )
      expect_any_instance_of(Logger).to receive(:info).with(
        %r{\[\w.+\] Request to '/500.html' finished with response status 500 in \w.+ ms}
      )
      subject
    end
  end
end
