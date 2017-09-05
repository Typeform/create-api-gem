class Variables
  attr_accessor :price, :score

  def initialize(price: nil, score: nil)
    @price = price
    @score = score
  end

  def self.from_response(payload)
    new(
      price: payload[:price],
      score: payload[:score]
    )
  end

  def self.default
    Variables.new(score: 0)
  end

  def self.full_example
    Variables.new(price: 10, score: 0)
  end

  def payload
    payload = {}
    payload[:score] = score
    payload[:price] = price unless price.nil?
    payload
  end

  def same?(actual)
    (score.nil? ? Variables.default.score : score) == actual.score &&
      (price.nil? || price == actual.price)
  end
end
