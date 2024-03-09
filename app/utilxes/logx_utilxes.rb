require 'pathname'
require 'yaml'
require 'loggerx'

module LogxUtilxes
    class Lx < Loggerx::Loggerx; end

    class Logx
        def self.config(path: nil, additional_path: nil)
          dir = path ? path : Rails.root
          top_pathname = Pathname.new(dir)
          top_pathname = top_pathname + additional_path if additional_path
          yaml_pathname = top_pathname + "config/logger.yml"
          content = yaml_pathname.read()
          YAML.safe_load(content)
        end
    
        def self.create(hash)
          # prefix, fname, log_dir_pn, stdout_flag, level = hash_to_args(hash)
          Lx.create_by_hash(hash)
        end
    end
end