# frozen_string_literal: true

class NodeComponent < ViewComponent::Base
  def initialize(name:, node:)
    @name = name
    @last_name = @name.split("/").last
    @node = node
    obj = @node.obj
    # obj = @node.obj.obj_hash[@name]
    # p "NodeComponent name=#{name}"
    # p "NodeComponent obj=#{obj}"
    # @node.obj.obj_hash.keys.map { |key| p key }
    @idx = obj.idx
    @level = obj.level
    @children = []
    @node.get_node_children().map { |child_node|
      child_name = [@name, child_node.last_name].join("/")
      @children << NodeComponent.new(name: child_name, node: child_node)
    }
  end
end
