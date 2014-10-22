require "formkeep/version"
require 'pp'
require 'json'
require 'net/http'
require 'yaml/store'

# @author Brandon Pittman
module Formkeep
  class Cli
    # @!group Getters
    def config
      YAML::Store.new("#{Dir.home}/.formkeep.yaml")
    end

    def get_key(key)
      config.transaction do
        config[key]
      end
    end

    def set_key(key, value)
      config.transaction do
        config[key] = value
      end
    end

    # Sets API endpoint
    def api(form_name)
      get_key(form_name)
    end

    def response
      Net::HTTP.get_response(URI(endpoint)).body
    end

    def submissions
      JSON.parse(response)["submissions"]
    end

    # Latest submission info
    def latest_submission
      submissions[0]
    end

    def latest_name
      latest_submission.fetch("name")
    end

    def latest_email
      latest_submission.fetch("email")
    end
    # @!endgroup

    # @!group Parsers
    def unread_submissions
      submissions.reject do |submission|
        submission.fetch("read_at")
      end
    end

    def read_submissions
      submissions.select do |submission|
        submission.fetch("read_at")
      end
    end
    # @!endgroup
  end
end
