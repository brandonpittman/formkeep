require 'spec_helper'

describe Formkeep do

  let(:test) {Formkeep::Cli.new("test")}
  let(:pixelsnatch) {Formkeep::Cli.new("pixelsnatch")}

  it 'has a version number' do
    expect(Formkeep::VERSION).not_to be nil
  end

  it 'pulls the correct API endpoint from the config YAML file' do
    expect(test.api).to eq("test")
  end

  it "it pulls a submissions array" do
    expect(pixelsnatch.submissions.class).to eq(Array)
  end

  it "pulls the latest submission" do
    expect(pixelsnatch.latest_submission.class).to eq(Hash)
  end
end
