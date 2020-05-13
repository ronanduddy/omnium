# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    # perhaps there's a better approach to loading in all these helpers
    Dir['./spec/support/helpers/ast_node_helpers/*.rb'].sort.each do |file|
      require file
    end
  end
end
