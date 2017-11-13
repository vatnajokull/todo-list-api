# https://robots.thoughtbot.com/catching-json-parse-errors-with-custom-middleware

class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue ActionDispatch::Http::Parameters::ParseError => error
    regexp = %r{application\/json}

    return error unless env['HTTP_ACCEPT'] =~ regexp || env['CONTENT_TYPE'] =~ regexp

    error_output = "There was a problem in the JSON you submitted: #{error}"

    return [400, { 'Content-Type' => 'application/json' }, [{ status: 400, error: error_output }.to_json]]
  end
end
