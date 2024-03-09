class ImportxImporters < BasefixerImporters
  def initialize(fixer_inst, ar_klass, hierx_fname, pathxfixer, logger)
    @inst = fixer_inst
    @ar_klass = ar_klass
    @hierx_fname = hierx_fname
    @pathxfixer = pathxfixer

    @logger = logger
    # @pathxfixer = PathxfixerImporters.new(@logger)
    # @hierx = HierxesImporters::Hierxfixer.new(@pathxfixer, @logger)
    # @categoryx = HierxfixerImporters.new(@pathxfixer, @logger)
    # @inst = klass.new(@pathxfixer, @logger)
  end

  def make_inst()
    Pathx.all.each do |pathx|
      # @logger.debug "##################################### pathx.id=#{pathx.id}"
      @inst.register(pathx.path)
    end
    @pathxfixer.save_additional_to_db()
  end

  def insert_all()
    @inst.insert_all()
  end

  def to_array()
    @ac_klass.to_a
  end
  
  def to_yaml()
    ary = to_array()
    # ary = @hash.map{ |value| value }.flatten
    # ary = @hash
    YAML.dump(ary)
  end

  def output_x()
    # @ar_klass.
    output_in_yaml(@hierx_fname)
  end

  def hierx_print()
    @logger.debug("====")
    @hierx.pathx_print_all
    @logger.debug("====")
    @hierx.print_all
    @logger.debug("====")
    @hierx.print_hash_size
  end

  def print_pathx_by_level()
    @logger.debug("====")
    1.upto(20).each do |level|
      puts "#level=#{level}"
      @hierx.pathx_by_level(level).each do |item|
        puts " #{item.path}"
      end
    end
    @logger.debug("====")
    @hierx.pathx_get_all_path().map { |path| puts path }
  end

  def print_pathx_path_by_level()
    @logger.debug("====")
    1.upto(20).each do |level|
      @logger.debug "#level=#{level}"
      hierx.pathx_get_path_by_level(level).each do |path|
        # puts " #{path}"
        #p path.class
        @logger.debug path
        # exit
      end
    end
  end

  def print_hierx(item)
    #=begin
    @logger.debug item[:parent_id]
    @logger.debug item[:child_id]
    @logger.debug item[:generation]
    #=end
    @logger.debug "==="
  end

  def check_by_level()
    item_1 = @hierx.pathx_by_level(1)[0]
    puts "item_1.path=#{item_1.path}"
    item_20 = @hierx.pathx_by_level(10)[0]
    puts "item_20.path=#{item_20.path}"

    @hierx.get_generation(parent_id: item_1.index, child_id: item_20.index)
  end
end
