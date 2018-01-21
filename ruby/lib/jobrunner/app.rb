require 'rufus-scheduler'
require 'logger'
require 'open3'
require 'net/http'
require_relative './job_config.rb'

module JobRunner
    class App
        attr_accessor :logger

        def initialize
            $stdout.sync = true
            @logger = Logger.new($stdout)
            @logger.level = Logger::DEBUG
        end
 
        def run
            config_file = ARGV[0]
            if !config_file || !File.file?(config_file)
                $stderr.puts "Usage: jobrunner <PATH_TO_CONFIG_YAML>"
                exit(1)
            end
            job_config = JobConfig.new(config_file: config_file)
            if ENV["NOTIFY_RASPBERRYPI"]
                http = Net::HTTP.new("raspberrypi", 7777)
            end
            scheduler = Rufus::Scheduler.new
            job_config.jobs.each do | job |
                if job['type'] == 'cron' 
                    @logger.info("registering job '#{job['name']}'")
                    scheduler.cron job['timespec'], :overlap => false do
                        @logger.info("executing job '#{job['name']}' [#{job['command']}]")
                        stdout, stderr, exit_status = Open3.capture3(job['command'])
                        unless exit_status.success?
                            @logger.error("Job '#{job['name']}' failed with code '#{exit_status.exitstatus}', stderr:\n#{stderr}")
                            http.request(Net::HTTP::Get.new("/led/red/on")) if http
                        else
                            @logger.info("job '#{job['name']}' was successfully executed")
                            http.request(Net::HTTP::Get.new("/led/green/blink")) if http
                        end
                    end
                else
                    @logger.info('Jobs with type other than "cron" are not yet supported!')
                end
            end

            scheduler.join
        end
    end    

    if __FILE__ == $0
        app = App.new
        app.run()
    end
end

