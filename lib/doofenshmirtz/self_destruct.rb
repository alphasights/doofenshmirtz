module Doofenshmirtz
  class SelfDestructError < RuntimeError; end

  class SelfDestruct
    Mechanism = Struct.new(:time, :location, :reason)
    @mechanisms = Set.new

    def self.on(time, reason = nil)
      add(time.to_time, caller_locations.first, reason)

      destruct(current_mechanism) if Time.now > current_mechanism.time
    end

    def self.report(reporter = DefaultReporter)
      reporter.new(mechanisms).report
    end

    # private class methods

    def self.add(time, location, reason)
      @mechanisms.add(new_mechanism(time, location, reason))
    end

    def self.current_mechanism
      @mechanism
    end

    def self.destruct(mechanism)
      return unless enforce?

      message = "Self destructed on #{mechanism.time}"
      message += " because: #{mechanism.reason}" unless mechanism.reason.blank?
      fail(SelfDestructError, message)
    end

    def self.enforce?
      Rails.env.test? && ENV["DISABLE_DOOFENSHMIRTZ"] != "true"
    end

    def self.mechanisms
      @mechanisms
    end

    def self.new_mechanism(time, location, reason)
      @mechanism = Mechanism.new(time, location.to_s, reason)
    end

    private_class_method :add
    private_class_method :current_mechanism
    private_class_method :destruct
    private_class_method :enforce?
    private_class_method :mechanisms
    private_class_method :new_mechanism
  end
end
