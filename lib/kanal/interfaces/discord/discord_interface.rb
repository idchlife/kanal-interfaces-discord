# frozen_string_literal: true

require "kanal/core/interfaces/interface"
require "kanal/plugins/batteries/batteries_plugin"
require_relative "./plugins/discord_integration_plugin"

require 'discordrb'
require 'json'

module Kanal
  module Interfaces
    module Discord
      # This interface helps working with discord
      class DiscordInterface < Kanal::Core::Interfaces::Interface
        def initialize(core, bot_token)
          super(core)

          @bot_token = bot_token

          @core.register_plugin Kanal::Plugins::Batteries::BatteriesPlugin.new
          @core.register_plugin Kanal::Interfaces::Discord::Plugins::DiscordIntegrationPlugin.new
        end

        def start
          bot = Discordrb::Bot.new token: @bot_token

          bot.button do |event|
            event.defer_update

            input = @core.create_input
            input.dc_button = event
            input.dc_button_text = event.custom_id
            input.dc_username = event.user.username
            input.dc_channel_id = event.channel.id

            output = router.create_output_for_input input

            send_output event, output
          end

          bot.message do |event|
            input = @core.create_input
            input.dc_message = event
            input.dc_message_text = event.text
            input.dc_username = event.author.username
            input.dc_channel_id = event.channel.id

            puts "input.dc_channel_id: #{input.dc_channel_id}"

            output = router.create_output_for_input input

            send_output event, output
          end

          bot.run
        end

        def send_output(event, output)
          components = nil
          buttons = []

          dc_reply_markup = output.dc_reply_markup

          dc_reply_markup&.each do |button_name|
            button = {
              type: 2,
              label: button_name,
              style: 1,
              custom_id: button_name
            }

            buttons.append button
          end

          if buttons.count.positive?
            components = [
              {
                type: 1,
                components: buttons
              }
            ]
          end

          uri = URI("https://discord.com/api/channels/#{event.channel.id}/messages")

          headers = {
            "Content-Type" => "application/json",
            "Authorization" => "Bot #{@bot_token}"
          }

          body = {
            content: output.dc_text,
            tts: false
          }

          body["components"] = components if components

          Net::HTTP.post(uri, body.to_json, headers)

          image_path = output.dc_image_path

          event.channel.send_file file: File.open(output.dc_image_path, 'r') if image_path && File.exist?(image_path)

          audio_path = output.dc_audio_path

          event.channel.send_file file: File.open(output.dc_audio_path, 'r') if audio_path && File.exist?(audio_path)

          document_path = output.dc_document_path

          event.channel.send_file file: File.open(output.dc_document_path, 'r') if document_path && File.exist?(document_path)
        end

        private

        # def guess_mimetype(filename)
        #   images = {
        #     "image/jpeg" => %w[jpg jpeg],
        #     "image/png" => ["png"],
        #     "image/bmp" => ["bmp"]
        #   }
        #
        #   # TODO: rewrite with .find or .each
        #   for pack in [images] do
        #     for mime, types in pack do
        #       for type in types do
        #         return mime if filename.include? type
        #       end
        #     end
        #   end
        #
        #
        #   "application/octet-stream"
        # end
      end
    end
  end
end
