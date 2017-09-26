class FieldLogic
  attr_accessor :field_ref, :type, :actions

  def initialize(field_ref: nil, type: nil, actions: [])
    @field_ref = field_ref
    @actions = actions
    @type = type
  end

  def self.from_response(payload)
    field_ref = payload[:ref] unless payload[:ref].nil?
    actions = payload[:actions].nil? ? [] : payload[:actions].map { |action_payload| LogicAction.from_response(action_payload) }
    type = payload[:type]
    FieldLogic.new(field_ref: field_ref, type: type, actions: actions)
  end

  def payload
    payload = {}
    payload[:ref] = field_ref unless field_ref.nil?
    payload[:type] = type unless type.nil?
    payload[:actions] = actions.map(&:payload) unless actions.empty?
    payload
  end

  def same?(actual)
    (field_ref.nil? || field_ref == actual.field_ref) &&
      type == actual.type &&
      actions.all? do |action|
        actual_action = actual.actions.find do |a|
          begin
            a.same?(action)
          rescue NoMethodError
            false
          end
        end
        action.same?(actual_action)
      end && actions.length == actual.actions.length
  end

  def self.full_example(logic_block, form)
    non_logic_blocks = %i[group payment statement]
    actions = if non_logic_blocks.include?(logic_block.type)
                [
                  LogicJump.create_always_jump(form)
                ]
              else
                [
                  LogicJump.create_field_logic_jump(form, Block.block_symbol_to_string(logic_block.type)),
                  Calculation.full_example(logic_block)
                ]
              end
    FieldLogic.new(field_ref: logic_block.ref, type: 'field', actions: actions)
  end
end
