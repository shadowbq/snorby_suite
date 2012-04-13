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
          SnorbySuite::SENSORS.each do |rsensor|  
            file.puts "alert_daemon_#{rsensor}: alert_daemon --sensor #{rsensor}"
            file.puts "barnyard_#{rsensor}: barnyard2 -c #{SnorbySuite::BARNYARD} -h #{rsensor} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2.#{rsensor} -w #{SnorbySuite::WALDO}.#{rsensor} --nolock-pidfile"
          end
        end
        SnorbySuite::EMBEDDED_PROCFILE
      rescue
        File.open("Procfile", "w") do |file|
          SnorbySuite::SENSORS.each do |rsensor|  
            file.puts "alert_daemon_#{rsensor}: alert_daemon --sensor #{rsensor}"
            file.puts "barnyard_#{rsensor}: barnyard2 -c #{SnorbySuite::BARNYARD} -h #{rsensor} -C #{SnorbySuite::CLASSIFICATION} -R #{SnorbySuite::REFERENCE} -G #{SnorbySuite::GENMSG} -S #{SnorbySuite::SIDMSG} -d #{SnorbySuite::UNIFIEDDIR} -l #{SnorbySuite::LOGDIR} -f snort.u2.#{rsensor} -w #{SnorbySuite::WALDO}.#{rsensor} --nolock-pidfile"
          end
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
