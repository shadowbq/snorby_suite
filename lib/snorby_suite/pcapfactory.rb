#!/usr/bin/env ruby
#
## reading and writing packets to and from pcap files.
require 'pcaprub'
require 'packetfu'

module SnorbySuite

  include PacketFu

  class Pcapfactory

    attr_accessor :count, :filename, :verbose, :iface

    def initialize(args={})
      @pcaps = []
      @verbose = args[:verbose] || true
      #@iface = args[:iface] || PCAPRUB::Pcap.lookupdev || "lo"
      @iface = args[:iface] || "lo"
      @filename = args[:fname] || "tmp/factory.pcap"
      @count = args[:count] || 1000
      self.flush if File.exists? @filename
    end

    def flush
      @pcaps = []
      if File.exists? @filename
        File.unlink( @filename )
      else
        raise "File #{@filename} does not exists"
      end
    end
    
    def gen_packet_udp
      pkt = PacketFu::UDPPacket.new
      pkt.ip_src = [rand(2**32-1)].pack("N")
      pkt.ip_dst = [rand(2**32-1)].pack("N")
      pkt.udp_dst = rand(5000 - 1025) + 1025
      pkt.udp_src = rand(5000 - 1025) + 1025
      pkt.recalc
    end

    def gen_packet_tcp
      pkt = PacketFu::TCPPacket.new(:flavor=>"Windows")
      pkt.ip_src = [rand(2**32-1)].pack("N")
      pkt.ip_dst = [rand(2**32-1)].pack("N")
      pkt.tcp_flags.syn= rand(2)
      pkt.tcp_flags.ack= rand(2)
      pkt.tcp_flags.urg= rand(2)
      pkt.tcp_flags.psh= rand(2)
      pkt.tcp_flags.fin= rand(2)
      pkt.tcp_flags.rst= rand(2)
      pkt.tcp_dst=81
      pkt.tcp_src = rand(5000 - 1025) + 1025
      pkt.payload ="all I wanna do is ALERT.. #{rand(1000000) + 100}"
      pkt.recalc
    end

    def gen_packet_icmp
      pkt = PacketFu::ICMPPacket.new
      pkt.ip_src = [rand(2**32-1)].pack("N")
      pkt.ip_dst = [rand(2**32-1)].pack("N")
      pkt.icmp_type = rand(19)
      pkt.icmp_code = rand(20)
      pkt.payload = "0123456789abcdefghijklmnop"
      pkt.recalc
      pkt.to_s
    end

    def gen_packet_ethernet
      pkt = PacketFu::EthPacket.new
      pkt.eth_saddr="01:02:03:04:05:06"
      pkt.eth_daddr="0a:0b:0c:0d:0e:0f"
      pkt.payload="I'm a lonely little eth packet with no real protocol information to speak of."
      pkt.recalc
      pkt.to_s
    end
    
    def gen_packet_arp
      pkt = PacketFu::ARPPacket.new(:flavor => "Linux")
      pkt.arp_hw = 1
      pkt.arp_proto = 0x0800
      pkt.arp_hw_len = 6
      pkt.arp_proto_len = 4
      pkt.arp_opcode = 2
      pkt.arp_src_mac = Array.new(6) { rand(6) }.pack('c*')
      pkt.arp_src_ip = Array.new(4) { rand(4) }.pack('c*')
      pkt.arp_dst_mac =  Array.new(6) { rand(6) }.pack('c*')
      pkt.arp_dst_ip = Array.new(4) { rand(4) }.pack('c*')
      pkt.payload = Array.new(4) { rand(4) }.pack('c*')
    end

    
    def generate(args={})
      generators = args[:generators] || [:udp, :tcp, :icmp]
      @start_time = Time.now.utc
      puts "Generating random packets... (#{@start_time})" if verbose
      self.count.times do
        @pcaps << eval("gen_packet_" + generators[rand(generators.size)].to_s)
      end
    end

    def write_pcaps
      pfile = PacketFu::PcapFile.new
      res = pfile.array_to_file(:filename => @filename, :array => @pcaps, :append => true)
      puts "Wrote packets to disk in #{Time.now.utc - @start_time} seconds" if verbose
    end

    def read_speed
      read_bytes_start = Time.now.utc
      puts "Reading packet bytes..." if verbose
        packet_bytes = PcapFile.read_packet_bytes @filename
      puts "Read #{packet_bytes.size} packet byte blobs in #{Time.now.utc - read_bytes_start} seconds." if verbose

      read_packets_start = Time.now.utc
      puts "Reading packets..."if verbose
        packet_bytes = PcapFile.read_packets @filename
      puts "Read #{packet_bytes.size} parsed packets in #{Time.now.utc - read_packets_start} seconds." if verbose
    end

    def wire_scan
      puts "Dumping them on the wire..." if verbose
      inj = PacketFu::Inject.new(:iface => self.iface)
      inj.array_to_wire(:array=>@pcaps)
      puts "Done!" if verbose
    end

  end

end
