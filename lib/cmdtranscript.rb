# encoding: utf-8

require 'docker'

module Nanoc::Filters
  class CommandTranscript < Nanoc::Filter
    identifier :command_transcript

    def run(content, options)
      content
    end
  end
end
