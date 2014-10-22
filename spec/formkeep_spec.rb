require 'spec_helper'

describe Formkeep do

  let(:form) {Formkeep::Cli.new}

  it 'has a version number' do
    expect(Formkeep::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(form.api("test")).to eq("test")
  end
end
