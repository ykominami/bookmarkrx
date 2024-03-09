require "yaml"

class PathxitemImporters
  attr_accessor :path, :index, :level, :last_item

  def initialize(path, index, logger)
    @logger = logger
    # @logger.debug "============ Pathxitem START"
    raise unless path.instance_of?(String)
    @path = path
    array = path.split("/")
    @level = array.size
    @last_item = array.pop
    raise unless index.instance_of?(Integer)
    @index = index
    # @logger.debug "============ Pathxitem END"
  end
end
