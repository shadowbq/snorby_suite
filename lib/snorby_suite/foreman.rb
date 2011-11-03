require 'foreman'
require "foreman/engine"

module SnorbySuite

  class ForemanController
    
    attr_accessor :procfile
    
    def start(process=nil)
      check_procfile!

      if process
        engine.execute(process)
      else
        engine.start
      end
    end
    
    def create_procfile
      
      begin
        File.open(SnorbySuite::EMBEDDED_PROCFILE, "w") do |file|
          file.puts "alert_daemon: alert_daemon"
          file.puts "barnyard: barnyard2 -c #{SnorbySuite::BARNYARD} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2 -w #{SnorbySuite::WALDO} --nolock-pidfile"
        end
        SnorbySuite::EMBEDDED_PROCFILE
      rescue
        File.open("Procfile", "w") do |file|
          file.puts "alert_daemon: alert_daemon"
          file.puts "barnyard: barnyard2 -c #{SnorbySuite::BARNYARD} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2 -w #{SnorbySuite::WALDO} --nolock-pidfile"
        end
        File.expand_path("Procfile")
      end
      
    end
    
    def engine
      @engine ||= Foreman::Engine.new(@procfile)
    end

    def check_procfile!
      if File.exist?("Procfile")
        @procfile = "Procfile"
      else 
        @procfile = create_procfile
      end
    end

  end

end