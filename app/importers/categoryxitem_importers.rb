class CategoryxitemImporters < BaseitemImporters
  attr_reader :parent_id, :child_id, :generation

  def initialize(parent_id:, child_id:, generation:)
    @parent_id = parent_id
    @child_id = child_id
    @generation = generation
  end

  def to_yaml()
    {
      parent_id: @parent_id,
      child_id: @child_id,
      generation: @generation,
    }
  end
end
