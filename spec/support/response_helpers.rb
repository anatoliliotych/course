# frozen_string_literal: true

module ResponseHelpers
  def response_404
    [404, { 'Content-Length' => '19', 'Content-Type' => 'text/html' }, ["<h1>Error 404</h1>\n"]]
  end

  def response_500
    [500, { 'Content-Length' => '19', 'Content-Type' => 'text/html' }, ["<h1>Error 500</h1>\n"]]
  end

  def public_response_200
    [200, { 'Content-Length' => '19', 'Content-Type' => 'text/html' }, ["<h1>Error 500</h1>\n"]]
  end
end
