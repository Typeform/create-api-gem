class LogicAction
  def self.from_response(payload)
    case payload[:action]
    when 'jump'
      LogicJump.from_response(payload)
    when 'add', 'subtract', 'multiply', 'divide'
      Calculation.from_response(payload)
    end
  end
end
