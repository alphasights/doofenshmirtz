require 'spec_helper'

describe Doofenshmirtz::SelfDestruct do
  context 'given a date of 2016-08-01' do
    let(:judgement_day) { '2016-08-01' }
    context 'when the current date is before' do
      it 'lets the code continue' do
        Timecop.freeze(Date.civil(2016, 7, 1))
        expect {Doofenshmirtz::SelfDestruct.on(judgement_day, 'This should break after 2016-08-01') }.to_not raise_error
      end
    end

    context 'when the current date is after' do
      it 'raises an exception' do
        Timecop.freeze(Date.civil(2016, 8, 2))
        expect {Doofenshmirtz::SelfDestruct.on(judgement_day, 'This should break after 2016-08-01') }.to raise_error Doofenshmirtz::SelfDestructError
      end
    end
  end
end
