require "yaml"

class PathxesImporters
  def initialize(fname, logger)
    @hash = {}
    @insert_data = []
    content = File.read(fname)
    @obj = YAML.safe_load(content)
    @logger = logger
  end

  def import()
    @obj.each do |key, value|
      next unless value

      array = value.split("/")
      array.unshift()
      new_value = array.join("/")
      @hash[key] = new_value
      last_item = array.pop
      @insert_data << { idx: key, path: new_value, last_item: last_item }
    end
  end

  def get_size()
    @hash.size
  end

  def insert_all()
    # Pathy.insert_all ary
    Pathx.insert_all @insert_data if @insert_data.size > 0
  end
end
