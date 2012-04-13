require "snorby_suite/version"

module SnorbySuite
  
  SNORTCONF = File.expand_path("../../etc/snort.conf", __FILE__)
  BARNYARD = File.expand_path("../../etc/barnyard2.conf", __FILE__)
  CLASSIFICATION = File.expand_path("../../etc/classification.config", __FILE__)
  REFERENCE = File.expand_path("../../etc/reference.config", __FILE__)
  GENMSG = File.expand_path("../../etc/gen-msg.map", __FILE__)
  SIDMSG = File.expand_path("../../etc/sid-msg.map", __FILE__)
  WALDO = File.expand_path("../../etc/snorby.waldo", __FILE__)
  UNIFIEDDIR = File.expand_path("../../log/unified", __FILE__)
      
  LOGDIR = File.expand_path(".")
  
  EMBEDDED_PROCFILE = File.expand_path("../Procfile", __FILE__)

  SENSORS = ENV['SUITE_SENSORS'].split(' ') if ENV['SUITE_SENSORS']
  SENSORS ||= %w(LOKI ODIN THOR MAGNI BALDUR FREYA ASGARD RAGNAROK TYR VALKYRIES)
  
  require 'snorby_suite/pcapfactory'
  require 'snorby_suite/foreman'
  
end
