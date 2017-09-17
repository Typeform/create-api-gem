class APIRequest
  def self.execute(*args)
    new(*args).tap do |request|
      raise StandardError, 'Failed asserting that the request succeeds' unless request.success?
    end
  end

  def headers
    @response.headers
  end

  def inspect
    "#{@response.code}\n#{@response}"
  end

  private

  def request(args = {})
    RestClient::Request.execute(args) { |r| @response = r }
  end

  def json
    JSON.parse(@response, symbolize_names: true)
  end

  def json?
    json
    return true
  rescue JSON::ParserError
    return false
  end
  end
