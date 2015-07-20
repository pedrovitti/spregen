module Spregen
  module Config
    extend self

    def configure_trello_client
      trello_config = YAML.load_file('config.yml')["trello"]
      Trello.configure do |config|
        config.developer_public_key = trello_config["api_key"]
        config.member_token = trello_config["member_token"]
      end
    end

  end

end