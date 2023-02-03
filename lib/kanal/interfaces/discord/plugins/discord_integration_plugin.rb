# frozen_string_literal: true

module Kanal
  module Interfaces
    module Discord
      module Plugins
        # This class registers properties and hooks for discord bot library integration
        class DiscordIntegrationPlugin < Kanal::Core::Plugins::Plugin
          def name
            :discord_properties
          end

          def setup(core)
            register_parameters core
            register_hooks core
          end

          def register_parameters(core)
            core.register_input_parameter :dc_message, readonly: true
            core.register_input_parameter :dc_message_text, readonly: true
            core.register_input_parameter :dc_button, readonly: true
            core.register_input_parameter :dc_button_text, readonly: true
            core.register_input_parameter :dc_channel_id, readonly: true
            core.register_input_parameter :dc_username, readonly: true

            core.register_output_parameter :dc_channel_id
            core.register_output_parameter :dc_text
            core.register_output_parameter :dc_reply_markup
            core.register_output_parameter :dc_image_path
            core.register_output_parameter :dc_audio_path
            core.register_output_parameter :dc_document_path
          end

          def register_hooks(core)
            core.hooks.attach :input_just_created do |input|
              input.source = :discord
            end

            core.hooks.attach :input_before_router do |input|
              input.body = (input.dc_button_text || input.dc_message_text)
            end

            core.hooks.attach :output_before_returned do |input, output|
              output.dc_text = output.body
              output.dc_channel_id = input.dc_channel_id
            end
          end
        end
      end
    end
  end
end
