# frozen_string_literal: true

require "kanal/core/core"
require "kanal/plugins/batteries/batteries_plugin"
require "kanal/interfaces/discord/plugins/discord_integration_plugin"

class FakeChat
  attr_reader :id

  def initialize(id)
    @id = id
  end
end

class FakeDiscordMessage
  attr_reader :text,
              :chat

  def initialize(text: nil, chat_id: nil)
    @text = text
    @chat = FakeChat.new chat_id
  end
end

RSpec.describe Kanal::Interfaces::Discord::Plugins::DiscordIntegrationPlugin do
  it "plugin registered successfully" do
    core = Kanal::Core::Core.new

    expect do
      core.register_plugin Kanal::Interfaces::Discord::Plugins::DiscordIntegrationPlugin.new
    end.not_to raise_error
  end

  it "receives discord-like input and responds with proper output" do
    core = Kanal::Core::Core.new

    core.register_plugin Kanal::Plugins::Batteries::BatteriesPlugin.new
    core.register_plugin Kanal::Interfaces::Discord::Plugins::DiscordIntegrationPlugin.new

    core.router.default_response do
      body "Default response"
    end

    core.router.configure do
      on :body, starts_with: "First" do
        respond do
          body "Got to first one"
        end
      end
    end

    input = core.create_input
    input.dc_message_text = "First one goes..."

    output = core.router.create_output_for_input input

    expect(output.body).to include "Got to first one"
  end
end
