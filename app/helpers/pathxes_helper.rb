module PathxesHelper
  class Hier
=begin
    class HierNode
      def initialize(hier:, logger:)
        @hier = hier
        @logger = logger
        @idx = 1
      end

      def setup_data
        data_add_path("b/bc/klm/nopq/q/w/e")
        data_add_path("b/bc/klm/nopqq/z/x")
        data_add_path("b/bc/def/ghijq/w/e")
        data_add_path("a/bc/klm/nopqq/t/y")
      end

      def data_add_path(path)
        @logger.debug "add_path 1 path=#{path}"
        node = @hier.get_node(path)
        # check_node(node)
        return if node

        @logger.debug "add_path 2"

        prev_node = nil
        array = path.split("/")
        name = array.last
        @logger.debug "name=#{name}"
        node = create_node(name: name)
        check_node(node)
        # check_node(node)
        set_node(path, node)
        array.pop
        @logger.debug "add_path 3"
        while array.size > 0
          @logger.debug "add_path 4"
          prev_node = node

          new_path = array.join("/")
          @logger.debug "new_path=#{new_path}"
          new_node = get_node(new_path)
          if new_node
            node = new_node
            @logger.debug node.class
            @logger.debug "new_path=#{new_path}"
            @logger.debug "node=#{node}"
            @logger.debug "prev_node=#{prev_node}"
            check_node(node)
            check_node(prev_node)
            prev_node.add_parent(node)
            node.add_child(prev_node)
            return
          end
          @logger.debug "add_path 5"

          name2 = array.last
          pathx2 = pathx.parent
          @logger.debug "name2=#{name2}"
          node = create_node(name: name2, pathx2)
          prev_node.add_parent(node)
          @logger.debug "naode.name(#{node.name})<-prev_node.name(#{prev_node.name})"
          node.add_child(prev_node)
          @logger.debug "naode.name(#{node.name})->prev_node.name(#{prev_node.name})"
          @logger.debug "new_path=#{new_path} node.name=#{node.name}"
          set_node(new_path, node)

          array.pop()
        end
      end

      def create_node(name:, obj: nil)
        idx = @idx
        @idx += 1
        level = name.split("/").size
        Node.new(name: name, idx: idx, level: level, obj: obj)
      end
    end
=end
    attr_reader :hash, :obj_hash, :klass

    def initialize
      cfg = LogxUtilxes::Logx.config()

      cfg["prefix"] = "hier_"
      @logger = LogxUtilxes::Logx.create(cfg)

      @hash = {}
      @obj_hash = {}
      @klass = nil
    end

    def register_klass(klass)
      @klass = klass
    end

    def add_obj(path, obj)
      @obj_hash[path] = obj

      # @logger.debug "add_obj 1 path=#{path}"
      node = get_node(path)
      node.set_obj(obj)
      # check_node(node)
      return if node

      # @logger.debug "add_obj 2"

      prev_node = nil
      array = path.split("/")
      name = array.last
      # @logger.debug "name=#{name}"
      node = create_node(name: name, obj: obj)
      check_node(node)
      # check_node(node)
      set_node(path, node)
      array.pop
      # @logger.debug "add_obj 3"
      while array.size > 0
        # @logger.debug "add_obj 4"
        prev_node = node

        new_path = array.join("/")
        parent_obj = obj.parent
        # @logger.debug "new_obj=#{new_path}"
        new_node = get_node(new_path)
        new_node.set_obj(parent_obj)
        if new_node
          node = new_node
          # @logger.debug node.class
          # @logger.debug "new_obj=#{new_path}"
          # @logger.debug "node=#{node}"
          # @logger.debug "prev_node=#{prev_node}"
          check_node(node)
          check_node(prev_node)
          prev_node.add_parent(node)
          node.add_child(prev_node)
          return
        end
        # @logger.debug "add_path 5"

        name2 = array.last
        parent2_obj = parent_obj.parent
        # @logger.debug "name2=#{name2}"
        node = create_node(name: name2)
        node.set_obj(parent_2_obj)

        prev_node.add_parent(node)
        # @logger.debug "naode.name(#{node.name})<-prev_node.name(#{prev_node.name})"
        node.add_child(prev_node)
        # @logger.debug "naode.name(#{node.name})->prev_node.name(#{prev_node.name})"
        # @logger.debug "new_path=#{new_path} node.name=#{node.name}"
        set_node(new_path, node)

        array.pop()
        obj = parent2_obj
      end
      # return if get_root_node()
      # @logger.debug "root node.name=#{node.name}"
      add_root_path(child_node: node)
    end

    def make_data()
      @hiernode = HierNode.new(hier: self, logger: @logger)
      @hirenode.setup_data()
    end

    def check_node(node)
      if node
        # if node.instance_of?(NodeHiers::Node)
        if node.instance_of?(Node)
          #
        elsif node.instance_of?(Array)
          #
        else
          p node.class
          raise
        end
      end
    end

    def create_node(name:)
      # NodeHiers::Node.new(name: name)
      Node.new(name: name, obj: self)
    end

    def add_path(path)
      # @logger.debug "add_path 1 path=#{path}"
      node = get_node(path)
      # check_node(node)
      return if node

      # @logger.debug "add_path 2"

      prev_node = nil
      array = path.split("/")
      name = array.last
      # @logger.debug "name=#{name}"
      node = create_node(name: name)
      check_node(node)
      # check_node(node)
      set_node(path, node)
      array.pop
      # @logger.debug "add_path 3"
      while array.size > 0
        # @logger.debug "add_path 4"
        prev_node = node

        new_path = array.join("/")
        # @logger.debug "new_path=#{new_path}"
        new_node = get_node(new_path)
        if new_node
          node = new_node
          # @logger.debug node.class
          # @logger.debug "new_path=#{new_path}"
          # @logger.debug "node=#{node}"
          # @logger.debug "prev_node=#{prev_node}"
          check_node(node)
          check_node(prev_node)
          prev_node.add_parent(node)
          node.add_child(prev_node)
          return
        end
        # @logger.debug "add_path 5"

        name2 = array.last
        # @logger.debug "name2=#{name2}"
        node = create_node(name: name2)
        prev_node.add_parent(node)
        # @logger.debug "naode.name(#{node.name})<-prev_node.name(#{prev_node.name})"
        node.add_child(prev_node)
        # @logger.debug "naode.name(#{node.name})->prev_node.name(#{prev_node.name})"
        # @logger.debug "new_path=#{new_path} node.name=#{node.name}"
        set_node(new_path, node)

        array.pop()
      end
      # return if get_root_node()
      # @logger.debug "root node.name=#{node.name}"
      add_root_path(child_node: node)
    end

    def add_root_path(child_node:)
      root_node = get_root_node()
      unless root_node
        root_node = create_node(name: "")
        set_root_node(root_node)
      end

      child_node.add_parent(root_node)
      root_node.add_child(child_node)
    end

    def get_node(hier_name)
      @hash[hier_name]
    end

    def set_node(hier_name, node)
      @hash[hier_name] ||= node
    end

    def get_node_tree()
      get_root_node().get_node_tree()
    end

    def get_root_node()
      get_node("")
    end

    def set_root_node(node)
      set_node("", node)
    end
  end

  class Node
    attr_reader :name, :last_name, :obj

    def initialize(name:, idx: -1, level: -1, obj: nil)
      railse unless name.instance_of?(String)
      @name = name
      @idx = idx
      @level = level
      @last_name = @name.split("/").last
      @parent = nil
      @children = []
      set_obj(obj)
    end

    def set_obj(obj)
      @obj = obj
    end

    def add_parent(node)
      if @parent
        raise
        return
      end

      @parent = node
    end

    def add_child(node)
      @children << node
    end

    def get_node_tree()
      output = []
      output << @name
      @children.each do |child_node|
        output << child_node.get_node_tree()
      end
      output
    end

    def to_s()
      @name
    end

    def get_node_children()
      @children
    end
  end
=begin
  class Pathxz
    class Pathxitem
      attr_reader :path, :index, :level

      def initialize(path, index)
        # Lx.debug "============ Pathxitem START"
        raise unless path.instance_of?(String)
        @path = path
        array = path.split("/")
        @level = array.size
        @last_item = array.pop
        raise unless index.instance_of?(Integer)
        @index = index
        # Lx.debug "============ Pathxitem END"
      end
    end

    def initialize()
      @hash = {}
      @hash_by_index = {}
      @hash_by_level = {}
      @next_index = 1
    end

    def register(path)
      index = @next_index
      @next_index += 1
      # Lx.debug "Pathxz register 1"
      item = Pathxitem.new(path, index)
      # Lx.debug "Pathxz register 2"
      @hash_by_index[index] = item
      @hash[path] = item
      @hash_by_level[item.level] ||= []
      @hash_by_level[item.level] << item
      item
    end

    def get(path)
      # Lx.debug "Pathxz#get path=#{path}"
      raise unless path.instance_of?(String)
      item = @hash[path]
      item = register(path) unless item
      item
    end

    def get_by_index(index)
      raise unless index.instance_of?(Integer)
      @hash_by_index[index]
    end

    def get_by_level(level)
      #p @hash
      list = @hash_by_level[level]
      list = [] unless list
      list
    end

    def get_all_path()
      @hash.keys
    end

    def print_all()
      Lx.debug "========== Pathx print_all S"
      @hash.each do |key, value|
        Lx.debug "#{key}"
        Lx.debug " #{value}"
      end
      Lx.debug "========== Pathx print_all E"
    end
  end
=end
end
