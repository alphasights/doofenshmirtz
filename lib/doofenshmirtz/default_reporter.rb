require "colorize"

module Doofenshmirtz
  class DefaultReporter
    include ActionView::Helpers::DateHelper

    attr_accessor :mechanisms

    def initialize(mechanisms)
      self.mechanisms = mechanisms
    end

    def report
      return if mechanisms.empty?

      puts
      puts "Pending Self Destruct Mechanisms:"

      mechanisms.each do |m|
        next unless m.time > Time.zone.now

        puts "  #{m.location}".yellow
        puts "  will self destruct in #{time_ago_in_words(m.time)} ".light_red
        puts "  because: #{m.reason}".light_red unless m.reason.blank?
        puts
      end
    end
  end
end
