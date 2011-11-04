require 'foreman'
require "foreman/engine"
require "thor"
require "yaml"

module SnorbySuite

  class ForemanController < Thor
    
    class_option :procfile, :type => :string, :aliases => "-f", :desc => "Default: Procfile"

    attr_accessor :procfile
    
    
    desc "start [PROCESS]", "Start the application, or a specific process"
    method_option :concurrency, :type => :string,  :aliases => "-c", :banner => '"barnyard=3,alert_daemon=2"'
    
    def start(process=nil)
      check_procfile!

      if process
        engine.execute(process)
      else
        engine.start
      end
    end
    
    
    
    desc "create", "Create the procfile for the application, or a specific process"
    method_option :path, :aliases => "-d", :desc => "Directory to write procfile"
       
    def create
      begin
        File.open(SnorbySuite::EMBEDDED_PROCFILE, "w") do |file|
          file.puts "alert_daemon: alert_daemon"
          file.puts "barnyard: barnyard2 -c #{SnorbySuite::BARNYARD} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2 -w #{SnorbySuite::WALDO} --nolock-pidfile"
        end
        
        # read this options[:path] and write file to it.. 
        
        SnorbySuite::EMBEDDED_PROCFILE
      rescue
        create_local_procfile
      end
    end
    
    desc "show", "Show the procfile for the application"
           
    def show
      begin
        #File.open(SnorbySuite::EMBEDDED_PROCFILE, "w") do |file|
          puts "stub..."
          puts "alert_daemon: alert_daemon"
          puts "barnyard: barnyard2 -c #{SnorbySuite::BARNYARD} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2 -w #{SnorbySuite::WALDO} --nolock-pidfile"
        #end
        
        # read this options[:path] and write file to it.. 
        
        SnorbySuite::EMBEDDED_PROCFILE
      rescue
        create_local_procfile
      end
    end

private ##################
    
    def create_local_procfile
      File.open("Procfile", "w") do |file|
        file.puts "alert_daemon: alert_daemon"
        file.puts "barnyard: barnyard2 -c #{SnorbySuite::BARNYARD} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2 -w #{SnorbySuite::WALDO} --nolock-pidfile"
      end
      File.expand_path("Procfile")
    end
    
    def engine
      @engine ||= Foreman::Engine.new(@procfile, options)
    end

    def check_procfile!
      if File.exist?("Procfile")
        @procfile = "Procfile"
      else 
        @procfile = options[:procfile] || create_procfile
      end
    end
    
    # DEFAULT OPTIONS
    #   If a .snorby_suite file exists in the current directory, default options will be read from it. This file should be in YAML format with the long option name as keys. Example:
    #     concurrency: alpha=0,bravo=1
    #     port: 15000
    def options
      original_options = super
      return original_options unless File.exists?(".snorby_suite")
      defaults = YAML::load_file(".snorby_suite") || {}
      Thor::CoreExt::HashWithIndifferentAccess.new(defaults.merge(original_options))
    end

  end

end