require "yaml"

class BookmarksImporters < BasefixerImporters
  def initialize(fname, logger)
    @logger = logger

    @hash = {}
    content = File.read(fname)
    @obj = YAML.safe_load(content)
  end

  def f(idxnum)
    @logger.debug idxnum
    idx = idxnum.to_i
    @logger.debug idx
    hs = { idx: idx }
    @logger.debug hs
    ary = Pathx.where(hs).to_a
    @logger.debug ary
    @logger.debug ary.class
    @logger.debug ary.size
    exit if ary.size == 0

    ary[0].id
  end

  def save_link(link)
    # @logger,debug link
    # pathx_index = link["path_index"]
    pathx_index = link["pathx_id"]
    idx = f(pathx_index)
    exit if idx == nil

    hs = {
      href: link["href"],
      desc: link["desc"],
      add_date: link["add_date"],
      last_modified: link["last_modified"],
      pathx_id: idx,
    }

    Bookmark.new(hs).save
  end

  def save_link_by_insert(array)
    Bookmark.insert_all(array) if array.size > 0
  end

  def listup(obj)
    obj.map { |k, v|
      # puts k
      # v.map{ |item| save_link( item ) }
      v.map { |item|
        idx = item["path_index"]
        item.delete("path_index")
        item["add_date"] = Time.at(item["add_date"].to_i) if item["add_date"]
        item["last_modified"] = Time.at(item["last_modified"].to_i) if item["last_modified"]
        item["pathx_id"] = idx
        item["created_at"] = Time.current
        item["updated_at"] = Time.current
        save_link(item)
        # ary << item
        @logger.debug item
      }
    }
  end

  def listupx()
    listupb(@obj)
  end

  def listupb(obj)
    obj.each_with_object([]) { |item, memo|
      key = item[0]
      value = item[1]
      value.map { |item|
        idx = item["path_index"]
        item.delete("path_index")
        item["add_date"] = Time.at(item["add_date"].to_i) if item["add_date"]
        item["last_modified"] = Time.at(item["last_modified"].to_i) if item["last_modified"]
        item["pathx_id"] = idx
        item["created_at"] = Time.current
        item["updated_at"] = Time.current
        # ary << item
        # @logger.debug item
        memo << item
      }
    }
  end
end
