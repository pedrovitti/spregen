require 'yaml'
require 'trello'

module Spregen
  module Config
    CONFIG_PATH = '~/.spregen-config.yml'

    module_function

    def configure_trello_client
      trello_config = YAML.load_file(File.expand_path(CONFIG_PATH))['trello']
      Trello.configure do |config|
        config.developer_public_key = trello_config['api_key']
        config.member_token = trello_config['member_token']
      end
    end

    def create_config_file(api_key, member_token)
      template = File.read(File.expand_path('../../templates/spregen-config.yml.erb', __FILE__))
      result = ERB.new(template).result(binding)
      File.open(File.expand_path('~/.spregen-config.yml'), 'w') { |file| file.write(result) }
    end
  end
end
