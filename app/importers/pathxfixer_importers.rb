require "yaml"

class PathxfixerImporters
  def initialize(logger)
    @logger = logger
    @hash = {}
    @hash_by_index = {}
    @hash_by_level = {}
    numx = Pathx.pluck(:idx).max()
    num = (num == nil) ? 1 : numx + 1
    @initial_next_index = num
    @next_index = @initial_next_index
    @hash_additional = {}
    @hash_db_by_path = Pathx.all.each_with_object({}) { |item, memo| memo[item.path] = item }
  end

  def register(path)
    item_in_db = @hash_db_by_path.fetch(path, false)
    if item_in_db
      index = item_in_db.idx
    else
      index = @next_index
      @next_index += 1
    end
    item = PathxitemImporters.new(path, index, @logger)
    @hash_additional[path] = item unless item_in_db

    @hash_by_index[index] = item
    @hash[path] = item
    @hash_by_level[item.level] ||= []
    @hash_by_level[item.level] << item

    item
  end

  def reset_index(hash, start_index)
    ret = hash.map { |key, item| item.index }.sort
      .each_with_object([start_index, {}]) { |it, memo|
      x = memo[0]
      hashx = memo[1]
      hashx[it] = x
      memo[0] = x + 1
    }
    old_new_hash = ret[1]
    hash.map { |key, item| item.index = old_new_hash[item.index] }
  end

  def save_additional_to_db
    @logger.debug "## save_additional_to_db"

    # reset_index(@hash_additional, @initial_next_index)
    array = @hash_additional.map { |key, item|
      {
        path: item.path, idx: item.index, last_item: item.last_item,
      }
    }
    if array.size > 0
      @logger.debug "## save_additional_to_db 1"
      @logger.debug array
      Pathx.insert_all(array)
    end
  end

  def get(path)
    # @logger.debug "Pathxz#get path=#{path}"
    raise unless path.instance_of?(String)
    item = @hash[path]
    item = register(path) unless item
    item_by_path = @hash[path]
    item_by_index = @hash[item.index]
    item
  end

  def get_by_index(index)
    raise unless index.instance_of?(Integer)
    @hash_by_index[index]
  end

  def get_by_level(level)
    # @logger.debug @hash
    list = @hash_by_level[level]
    list = [] unless list
    list
  end

  def get_all_path()
    @hash.keys
  end

  def print_all()
    @logger.debug "========== Pathx print_all S"
    @hash.each do |key, value|
      @logger.debug "#{key}"
      @logger.debug " #{value}"
    end
    @logger.debug "========== Pathx print_all E"
  end
end
