# frozen_string_literal: true

class NodepathxComponent < NodeComponent
  def initialize(name:, node:)
    @name = name
    @last_name = @name.split("/").last
    @node = node
    @obj = @node.obj.klass.where(path: @name).to_a.last
    @idx = @obj.idx
    @level = @obj.level
    p "@idx=#{@idx}"
    p "@level=#{@level}"
    @children = []
    @node.get_node_children().map { |child_node|
      child_name = [@name, child_node.last_name].join("/")
      @children << NodepathxComponent.new(name: child_name, node: child_node)
    }
  end
end
