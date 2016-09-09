require 'doofenshmirtz'
require 'ostruct'

describe Doofenshmirtz::DefaultReporter do
  let(:mechanism) { OpenStruct.new time: future, location: __FILE__, reason: "Scorched earth" }
  let(:mechanisms) { Set.new <<  mechanism }
  let(:two_days) { 172800 }
  let(:future) { Time.now + two_days }
  let(:past) { Time.now - two_days }

  subject { Doofenshmirtz::DefaultReporter.new(mechanisms) }

  context '#new' do
    it 'stores the details of any impending self-destructs' do
      expect(subject.mechanisms).to eq mechanisms
    end
  end

  context '#report' do
    before { allow(Time).to receive(:zone).and_return Time } # Avoid having to import activesupport

    it 'prints nothing if there are no self-destructs' do
      mechanisms.clear
      expect(subject).not_to receive(:puts)

      subject.report
    end

    it "doesn't report self-destructs that are already destructing" do
      mechanism.time = past
      expect(subject).to receive(:puts).with(/Pending/)
      expect(subject).not_to receive(:puts).with(/will self destruct/)

      subject.report
    end

    it "prints a report of future self-destructs" do
      Doofenshmirtz::SelfDestruct.on(future, "The apocalypse is nigh")

      # Could get rid of some of this ugliness by injecting an instance of the
      # reporter, rather than the reporter class, but that would probably mean
      # changing the interface or some equivalently ugly hack in the app code,
      # so saving that for another day
      mechanisms = Doofenshmirtz::SelfDestruct.send(:mechanisms)
      reporter = Doofenshmirtz::DefaultReporter.new(mechanisms)
      allow(Doofenshmirtz::DefaultReporter).to receive(:new).and_return reporter
      allow(subject).to receive(:puts)

      expect(reporter).to receive(:puts).with(/Pending/)
      expect(reporter).to receive(:puts).with(/will self destruct/)

      Doofenshmirtz::SelfDestruct.report
    end
  end
end
