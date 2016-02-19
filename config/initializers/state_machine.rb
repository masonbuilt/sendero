# https://github.com/pluginaweek/state_machine/issues/295

# Rails 4.1.0.rc1 and StateMachine don't play nice

module StateMachine::Integrations::ActiveModel
  alias_method :around_validation_protected, :around_validation
  def around_validation(*args, &block)
    around_validation_protected(*args, &block)
  end
end