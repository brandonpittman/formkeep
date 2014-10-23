require "formkeep/version"
require 'pp'
require 'json'
require 'net/http'
require 'yaml/store'

# @author Brandon Pittman
module Formkeep
  class Cli

    attr_accessor :form

    def initialize(form)
      @form = form
    end

    # @!group Getters
    def config
      YAML::Store.new("#{Dir.home}/.formkeep.yaml")
    end

    def get_key(key)
      store = config
      store.transaction do
        store[key]
      end
    end

    def set_key(key, value)
      store = config
      store.transaction do
        store[key] = value
      end
    end

    # Sets API endpoint
    def api
      get_key(form)
    end

    def response
      Net::HTTP.get_response(URI(api)).body
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

form = Formkeep::Cli.new("pixelsnatch")
form.latest_submission.class # => Hash
form.submissions.class # => Array
