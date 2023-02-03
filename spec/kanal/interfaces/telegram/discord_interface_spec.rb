# frozen_string_literal: true

require "kanal/core/core"
require "kanal/interfaces/discord/discord_interface"

RSpec.describe Kanal::Interfaces::Discord::DiscordInterface do
  it "successfully created without errors" do
    core = Kanal::Core::Core.new

    expect do
      Kanal::Interfaces::Discord::DiscordInterface.new core, "SOME_BOT_TOKEN"
    end.not_to raise_error
  end
end
