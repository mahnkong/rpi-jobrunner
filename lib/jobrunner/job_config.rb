require 'yaml'

module JobRunner

    class JobConfig
        attr_reader :jobs, :config_file

        def initialize(config_file:)
            @config_file = config_file
            @jobs = YAML.load_file(@config_file)
        end
    end    

end


