# frozen_string_literal: true

RSpec.describe Kanal::Interfaces::Discord do
  it "has a version number" do
    expect(Kanal::Interfaces::Discord::VERSION).not_to be nil
  end
end
