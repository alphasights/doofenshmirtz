require 'spec_helper'

describe Doofenshmirtz::VERSION do
  it 'is a version number' do
    expect(subject).to match /^(\d+\.?)+$/
  end
end
