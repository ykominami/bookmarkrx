class BasefixerImporters
  def initialize(klass, ar_klass, pathxfixer, logger)
    @klass = klass
    @ar_klass = ar_klass
    @hash ||= {}
    @pathxfixer = pathxfixer
    @logger = logger
  end

  def register(name)
    index = @pathxfixer.get(name)
    ary = name.split("/")
    top = ary.shift
    ary.each_with_object([top]) { |item, memo|
      parent_name = memo.last
      child_name = [parent_name, item].join("/")
      memo << child_name
    }.combination(2).each do |array|
      parent_name = array[0]
      child_name = array[1]
      parent_pathx = @pathxfixer.get(parent_name)

      parent_id = parent_pathx.index
      child_pathx = @pathxfixer.get(child_name)
      child_id = child_pathx.index
      @hash[parent_id] ||= {}
      if @hash[parent_id][child_id].nil?
        generation = child_pathx.level - parent_pathx.level
        baseitem = @klass.new(parent_id: parent_id, child_id: child_id, generation: generation)
        #
        @pathxfixer.get_by_index(parent_id)
        @pathxfixer.get_by_index(child_id)
        #
        @pathxfixer.get_by_index(baseitem.parent_id)
        @pathxfixer.get_by_index(baseitem.child_id)
        @hash[parent_id][child_id] = baseitem
      end
    end
  end

  def get_generation(parent_id:, child_id:)
    @logger.debug "parent_id=#{parent_id}"
    @logger.debug "child_id=#{child_id}"
    gen = -1
    baseitem = @hash[parent_id][child_id]
    gen = baseitem.generation if baseitem
    gen
  end

  def get_size()
    # @hash.size
    @hash.keys.each_with_object([0]) { |item, memo|
      memo[0] += @hash[item].size
    }
  end

  def insert_all()
    puts "basefixer insert_all()"

    array = to_array()
    @ar_klass.insert_all(array) if array.size > 0
  end

  def to_yaml()
    ary = to_array()
    # ary = @hash.map{ |value| value }.flatten
    # ary = @hash
    YAML.dump(ary)
  end

  def output_in_yaml(fname)
    File.open(fname, "w") { |ofile|
      content = to_yaml()
      ofile.write(content)
    }
  end

  def print_all
    @hash.keys.each do |parent_id|
      @logger.debug("print_all parent_id=#{parent_id}")
      @hash[parent_id].keys.each do |child_id|
        hi = @hash[parent_id][child_id]
        @logger.debug(hi)
        @logger.debug(hi.class)
        @logger.debug("###########################")
        parent_pathx = @pathx.get_by_index(parent_id)
        child_pathx = @pathx.get_by_index(child_id)
        @logger.debug "parent_pathx.path=#{parent_pathx.path}"
        @logger.debug "child_pathx.path =#{child_pathx.path}"
        @logger.debug "hi.parent_id     =#{hi.parent_id}"
        @logger.debug "hi.child_id      =#{hi.child_id}"
        @logger.debug "hi.generation    =#{hi.generation}"
        @logger.debug "----------------- print_all"
      end
    end
  end

  def print_hash_size
    @logger.debug @hash.size
  end

  def pathx_print_all
    @pathx.print_all
  end

  def pathx_by_level(level)
    @pathx.get_by_level(level)
  end

  def pathx_get_all_path()
    @pathx.get_all_path()
  end

  def pathx_get_path_by_level(level)
    pathx_by_level(level).map { |item| item.path }
  end
end
