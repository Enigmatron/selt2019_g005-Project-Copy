# frozen_string_literal: true

require 'rspec'

RSpec.describe ApplicationRecord do
  it 'succeeds' do
    expect { ApplicationRecord.create! }.to raise_error NotImplementedError
  end
end
