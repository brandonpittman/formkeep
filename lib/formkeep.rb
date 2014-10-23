require "formkeep/version"
require 'pp'
require 'json'
require 'net/http'
require 'yaml/store'

# @author Brandon Pittman
# Helper methods for accessing Formkeep API
module Formkeep
# @author Brandon Pittman
  # Helper methods for accessing Formkeep API
  class Form

    # @!attribute form
    #   @return [String] name of Form to be used
    # @since 0.0.4
    attr_accessor :form

    # Creates a Formkeep::Form object to make calling of other methods simpler.
    # @param [String] form name from `~/.formkeep.yaml`
    # @return [Formkeep::Form] Form object
    # @since 0.0.4
    def initialize(form)
      @form = form
    end

    # @!group Getters
    # @return [Pstore] YAML::Store object
    # @since 0.0.4
    def config
      YAML::Store.new("#{Dir.home}/.formkeep.yaml")
    end

    # @param [String] key to look up
    # @return [String] value of key
    # @since 0.0.4
    def get_key(key)
      store = config
      store.transaction do
        store[key]
      end
    end

    # @param [String] key to add/modify
    # @param [String] value to add/modify
    # @return [String] value that was added/modified
    # @since 0.0.4
    def set_key(key, value)
      store = config
      store.transaction do
        store[key] = value
      end
    end

    # Sets API endpoint
    # @return [String] API endpoint URL
    # @since 0.0.4
    def api
      get_key(form)
    end

    # @return [String] text of API call
    # @since 0.0.4
    def response
      Net::HTTP.get_response(URI(api)).body
    end

    # @return [Array] all submissions
    # @since 0.0.4
    def submissions
      all = JSON.parse(response)["submissions"]
      all.reject { |sub| sub["spam"] }
    end

    # Latest submission info
    # @return [Hash] first submission from submissions array
    # @since 0.0.4
    def latest_submission
      submissions[0]
    end

    # @return [String] name of latest submission
    # @since 0.0.4
    def latest_name
      latest_submission.fetch("name")
    end

    # @return [String] email of latest submission
    # @since 0.0.4
    def latest_email
      latest_submission.fetch("email")
    end
    # @!endgroup

    # @!group Parsers
    # @return [Array] all unread submissions
    # @since 0.0.4
    def unread_submissions
      submissions.reject do |submission|
        submission.fetch("read_at")
      end
    end

    # @return [Array] all read submissions
    # @since 0.0.4
    def read_submissions
      submissions.select do |submission|
        submission.fetch("read_at")
      end
    end
    # @!endgroup
  end
end
