#
# SCP file to server
#
module Chimp
  class ExecSCP < Executor
    attr_accessor :scp_user, :send_file, :retrieve_file, :destination

    def initialize(h={})
      super(h)
      @scp_user = h[:scp_user]

      if !h.has_key?(:send_file) && !h.has_key?(:retrieve_file)
        raise "You must specify either send_file or retrieve_file."
      elsif h[:send_file] && h[:retrieve_file]
        raise "You must decide to either send or retrieve a file."
      end

      @send_file     = h[:send_file]     || nil
      @retrieve_file = h[:retrieve_file] || nil
      @destination   = h[:destination]   || nil
    end

    def run
      host = @server['ip_address'] || @server['ip-address'] || nil
      @scp_user ||= "root"

      if host == nil
        @server.settings
        host = @server['ip_address'] || @server['ip-address']
      end

      if @send_file
        scp_arguments = "#{@send_file} #{@scp_user}@#{host}:#{@destination}"
      else # retrieve file
        scp_arguments = "#{@scp_user}@#{host}:#{@retrieve_file} #{@destination}"
      end

      run_with_retry do
        Log.debug "scp #{scp_arguments}"
        success = system("scp -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{scp_arguments}")

        if not $?.success?
          raise "SCP failed with status: #{$?}"
        end
      end
    end

    def describe_work
      if @send_file
        source = "#{@send_file}"
        dest   = "#{@scp_user}@#{host}:#{@destination}"
      else # retrieve file
        source = "#{@scp_user}@#{host}:#{@retrieve_file}"
        dest   = "#{@destination}"
      end

      return "ExecSCP job_id=#{@job_id} source=\"#{source}\" destination=\"#{dest}\""
    end

    def info
      if @send_file
        return "Send #{@send_file}"
      else
        return "Retrieve #{@retrieve_file}"
      end
    end

    def target
      return @server['nickname']
    end

  end
end
