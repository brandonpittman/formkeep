require 'spec_helper'

describe Formkeep do
  let(:test) { Formkeep::Form.new('test') }
  let(:pixelsnatch) { Formkeep::Form.new('pixelsnatch') }
  let(:subs) { pixelsnatch.submissions }

  it 'has a version number', cli: true do
    expect(Formkeep::VERSION).not_to be nil
  end

  it 'pulls the correct API endpoint from the config YAML file', api: true do
    expect(test.api).to eq('test')
  end

  it 'it pulls a submissions array', api: true do
    expect(subs.class).to eq(Array)
  end

  it 'pulls the latest submission', api: true do
    expect(pixelsnatch.latest_submission.class).to eq(Hash) if subs.length > 0
  end

  it 'creates a Sticky Notification', cli: true do
    expect { test.sticky('Just testing Formkeep!') }.not_to raise_error
  end
end
