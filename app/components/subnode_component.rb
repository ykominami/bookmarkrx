# frozen_string_literal: true

class SubnodeComponent < ViewComponent::Base
  def initialize(name)
    @name = name
    # @child = SubnodeComponent.new([name, "child"].join("/"))
    @child = ""
  end
end
