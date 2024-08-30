require "pathname"

namespace :data do
  require Rails.root + "config/environment.rb"

  def input_yaml_fname
    "bk.html"
  end

  desc "setup"
  task "setup", [:word] do |_, args|
    fname = args.word
    puts fname
    dest_fname = input_yaml_fname
    src_file = Pathname.new(fname)
    dest_file = Pathname.new(dst_fname)
    FileUtils.copy(src_file, dest_file)
  end

  desc "init"
  task "init" do
    ENV["YAML_HIERX"] = "hierx.yaml"
    ENV["YAML_BOOKMARK"] = "link.yaml"
    ENV["YAML_PATH_INDEX"] = "path_index.yaml"
    ENV["HTML_INPUT"] = input_yaml_fname
  end

  desc "app"
  task "app" do
    puts ENV["YAML_HIERX"]
    puts ENV["YAML_BOOKMARK"]
    puts ENV["YAML_PATH_INDEX"]
    puts ENV["HTML_INPUT"]
  end

  desc "init_app"
  task "init_app" => %W(data:init data:app) do
  end

  desc "install pyvenv"
  task "install:pyvenv" do
    system("sh ./bin/python/pyvenvinstall.sh")
  end

  desc "convert html"
  task "convert:html", [:word] do |_, args|
    puts "data convert #{args.word}"
    input_path = args.word
    input_path = ENV["HTML_INPUT"] unless input_path
    of_pn = Ykxutils.make_output_path(input_path: input_path, prefix: "o_")
    Ykxutils.reform_dt_tag(input_path, of_pn)
    system("sh ./bin/python/pythonx.sh #{of_pn.to_s}")
  end

  desc "data reloadz"
  task "reload" => %W(db:reset data:init data:install:pyvenv data:convert:html data:import:all data:fix) do
  end

  desc "data reload"
  task "reloadx" => %W(db:reset data:init data:import:all data:fix) do
  end

  desc "data import all"
  # task "import:all" => %W(data:import:pathx ath_index.yaml data:import:bookmark[link.yaml]) do
  # task "import:all" => %W(data:import:pathx["path_index.yaml"] data:import:bookmark[link.yaml]) do
  # task "import:all" => %W(data:import:pathx[word:path_index.yaml] data:import:bookmark) do
  task "import:all" => %W(data:import:pathx data:import:bookmark) do
  end

  desc "data import and fix"
  task "import:pathx", [:word] do |_, args|
    DEFAULT_PATH_INDEX = "path_index.yaml"
    puts "data import pathx"
    cfg = LogxUtilxes::Logx.config(path: Rails.root)

    cfg["prefix"] = "ip_"

    logger = LogxUtilxes::Logx.create(cfg)

    fname = args.word
    puts "1 fname=#{fname}"
    if fname != nil && File.exist?(fname)
      puts "1.1 fname=#{fname} exist"
    else
      fname = DEFAULT_PATH_INDEX
    end

    if fname != nil && File.exist?(fname)
      puts "1.2 fname=#{fname}"
    else
      fname = nil
    end

    fname = ENV["YAML_PATH_INDEX"] unless fname
    if fname != nil && File.exist?(fname)
      puts "2.1 fname=#{fname} exist"
    else
      puts "2.2 fname=#{fname} not exist"
      fname = nil
    end
    # fname = "../datax/bookmarkr/path_index.yaml" unless fname
    fname = "./path_index.yaml" unless fname
    if fname != nil && File.exist?(fname)
      puts "3.1 fname=#{fname} exist"
    else
      puts "3.2 fname=#{fname} not exist"
      fname = nil
    end
    puts "4 fname=#{fname}"
    pi = PathxesImporters.new(fname, logger)
    pi.import()
    pi.insert_all()
  end

  desc "data import bookmark"
  task "import:bookmark", [:word] do |_, args|
    LINK_YAML = "link.yaml"
    puts "data import bookmark"

    cfg = LogxUtilxes::Logx.config(path: Rails.root)
    cfg["prefix"] = "ib_"
    logger = LogxUtilxes::Logx.create(cfg)
    fname = args.word
    if fname != nil && File.exist?(fname)
      puts "B.1.1 fname=#{fname} exist"
    else
      fname = LINK_YAML
      puts "B.1.2 fname=#{fname}"
    end
    fname = ENV["YAML_BOOKMARK"] unless fname
    if fname != nil && File.exist?(fname)
      puts "B.2.1 fname=#{fname} exist"
    else
      puts "B.2.2 fname=#{fname} not exist"
      fname = nil
    end
    fname = "../datax/bookmarkr/link.yaml" unless fname
    if fname != nil && File.exist?(fname)
      puts "B.3.1 fname=#{fname} exist"
    else
      puts "B.3.2 fname=#{fname} not exist"
      fname = nil
    end
    bm = BookmarksImporters.new(fname, logger)
    array = bm.listupx()
    logger.debug fname
    logger.debug array.size
    begin
      bm.save_link_by_insert(array) if array.size > 0
    rescue => ex
      p ex
      p ex.backtrace
    end
  end

  desc "data fix"
  task "fix", [:word] do |_, args|
    puts "data fix"
    # require Rails.root + "config/environment.rb"

    cfg = LogxUtilxes::Logx.config(path: Rails.root)
    cfg["prefix"] = "fph_"
    cfg["level"] = "debug"
    logger = LogxUtilxes::Logx.create(cfg)
    fname = args.word
    fname = ENV["YAML_HIERX"] unless fname
    fname = "hierx.yaml" unless fname

    @pathxfixer = PathxfixerImporters.new(logger)
    # @hierx = HierxesImporters::Hierxfixer.new(@pathxfixer, @logger)
    # @categoryx = HierxfixerImporters.new(@pathxfixer, @logger)
    @fixer_inst = CategoryxfixersImporters.new(CategoryxitemImporters, Category, @pathxfixer, logger)

    importx = ImportxImporters.new(@fixer_inst, Category, fname, @pathxfixer, logger)

    # importx.make_hierx()

    # importx.make_categoryx()
    importx.make_inst()
    importx.insert_all()
    importx.output_x()
  end

  desc "data import and fix"
  task "import_fix" => ["data:init", "data:import:all", "data:fix"] do
  end
end
