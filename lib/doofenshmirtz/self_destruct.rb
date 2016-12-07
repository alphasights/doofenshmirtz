module Doofenshmirtz
  class SelfDestructError < RuntimeError; end

  class SelfDestruct
    Mechanism = Struct.new(:time, :location, :reason)
    @mechanisms = Set.new

    def self.on(time, reason = nil)
      add(time.to_time, caller_locations.first, reason)

      mechanisms.each do |m|
        destruct(m) if Time.now > m.time
      end
    end

    def self.add(time, location, reason)
      @mechanisms.add(Mechanism.new(time, location.to_s, reason))
    end

    def self.mechanisms
      @mechanisms
    end

    def self.destruct(mechanism)
      return unless enforce?
      message = "Self destructed on #{mechanism.time}"
      message += " because: #{mechanism.reason}" unless mechanism.reason.blank?
      fail(SelfDestructError, message)
    end

    def self.report(reporter = DefaultReporter)
      reporter.new(mechanisms).report
    end

    def self.enforce?
      Rails.env.test? && ENV["DISABLE_DOOFENSHMIRTZ"] != "true"
    end

    private_class_method :add
    private_class_method :destruct
    private_class_method :mechanisms
    private_class_method :enforce?
  end
end
