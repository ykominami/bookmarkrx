module HierxesHelper
    class Hierxy
        class Hieritem
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
                    generation: @generation
                }
            end
        end
    
        def initialize(pathx)
            @hash ||= {}
            @pathx = pathx
        end
    
        def register(name)
            # Lx.debug "Hierxy register name=#{name}"
            index = @pathx.get(name)
            ary = name.split('/')
            top = ary.shift
            ary.each_with_object([top]){ |item, memo|
                parent_name = memo.last
                child_name = [parent_name, item].join('/')
                memo << child_name
            }.combination(2).each do |array|
                parent_name = array[0]
                child_name = array[1]
                parent_pathx = @pathx.get(parent_name)
                parent_id = parent_pathx.index
                child_pathx = @pathx.get(child_name)
                child_id = child_pathx.index
                @hash[parent_id] ||= {}
                if @hash[parent_id][child_id].nil?
                    generation = child_pathx.level - parent_pathx.level
                    hieritem = Hieritem.new(parent_id:parent_id, child_id:child_id, generation:generation)
                    @hash[parent_id][child_id] = hieritem
                end
            end
        end
    
        def get_size()
            # @hash.size
            @hash.keys.each_with_object( [0] ){ |item, memo|
                memo[0] += @hash[item].size
            }
        end
    
        def to_yaml()
            ary = @hash.map{ |key, value| value.values.map{ |item| item.to_yaml() } }.flatten
            # ary = @hash.map{ |value| value }.flatten
            # ary = @hash
            YAML.dump(ary)
        end
    
        def output_in_yaml(fname)
            File.open(fname, 'w'){ |ofile|
                content = to_yaml()
                ofile.write( content )
            }
        end
    
        def get_generation(parent_id:, child_id:)
            p "parent_id=#{parent_id}"
            p "child_id=#{child_id}"
            gen = -1
            hieritem = @hash[parent_id][child_id]
            gen = hieritem.generation if hieritem
            gen
        end
    
        def print_all
            @hash.keys.each do |parent_id|
                Lx.debug( "print_all parent_id=#{parent_id}")
                @hash[parent_id].keys.each do |child_id|
                    hi = @hash[parent_id][child_id]
                    Lx.debug( hi )
                    Lx.debug( hi.class )
                    Lx.debug("###########################")
                    parent_pathx = @pathx.get_by_index(parent_id)
                    child_pathx = @pathx.get_by_index(child_id)
                    Lx.debug "parent_pathx.path=#{parent_pathx.path}"
                    Lx.debug "child_pathx.path =#{child_pathx.path}"
                    Lx.debug "hi.parent_id     =#{hi.parent_id}"
                    Lx.debug "hi.child_id      =#{hi.child_id}"
                    Lx.debug "hi.generation    =#{hi.generation}"
                    Lx.debug "----------------- print_all"
                end
            end
        end
    
        def print_hash_size
            Lx.debug @hash.size
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
            pathx_by_level(level).map{ |item| item.path }
        end
    end
end
