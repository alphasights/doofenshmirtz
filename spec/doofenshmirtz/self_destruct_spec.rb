require 'spec_helper'

describe Doofenshmirtz::SelfDestruct do
  let(:two_days) { 172800 }
  let(:future) { Time.now + two_days }
  let(:past) { Time.now - two_days }

  context '.on' do
    before do
      allow(Rails).to receive_message_chain('env.test?').and_return true
    end

    it "doesn't explode before the specified time" do
      Doofenshmirtz::SelfDestruct.on(future, "The apocalypse is nigh")
    end

    it "explodes after the specified time" do
      expect { Doofenshmirtz::SelfDestruct.on(past, "The apocalypse is nigh") }.to raise_error(Doofenshmirtz::SelfDestructError)
    end

    it "doesn't explode if the test env variable 'DISABLE_DOOFENSHMIRTZ' is 'true'" do
      ENV["DISABLE_DOOFENSHMIRTZ"] = 'true'
      Doofenshmirtz::SelfDestruct.on(past, "The apocalypse is nigh")
      ENV["DISABLE_DOOFENSHMIRTZ"] = nil
    end

    it "doesn't explode outside the test environment" do
      allow(Rails).to receive_message_chain('env.test?').and_return false
      Doofenshmirtz::SelfDestruct.on(past, "The apocalypse is nigh")
    end

    it "doesn't explode repeatedly from the same cause" do
      Doofenshmirtz::SelfDestruct.on(past, "The apocalypse is averted") rescue Doofenshmirtz::SelfDestructError
      Doofenshmirtz::SelfDestruct.on(future, "The apocalypse has leaves on the track")
    end
  end

  context '.report' do
    it 'requests a report from a reporter' do
      expect_any_instance_of(Doofenshmirtz::DefaultReporter).to receive(:report)
      Doofenshmirtz::SelfDestruct.report
    end
  end
end
