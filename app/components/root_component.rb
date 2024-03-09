# frozen_string_literal: true

class RootComponent < ViewComponent::Base
  def initialize(name:, hier:, child_klass:)
    @name = name
    @children = []
    @hier = hier

    @root_node = @hier.get_root_node()

    @root_node.get_node_children().map { |node|
      if @name && @name.strip.size > 0
        child_name = [@name, node.name].join("/")
      else
        child_name = node.name
      end
      @children << child_klass.new(name: child_name, node: node)
    }
  end
end
