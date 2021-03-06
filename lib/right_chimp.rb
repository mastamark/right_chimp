require 'rubygems'
require 'bundler'

require 'getoptlong'
require 'thread'
require 'webrick'
require 'singleton'
require 'base64'
require 'rake'

require 'progressbar'
require 'json'
require 'yaml'

require 'highline/import'

require 'right_api_client'
require 'rest-client'
require 'logger'

module Chimp
  require 'right_chimp/version'
  require 'right_chimp/Chimp'
  require 'right_chimp/Log'
  require 'right_chimp/IDManager'

  require 'right_chimp/daemon/ChimpDaemon'
  require 'right_chimp/daemon/ChimpDaemonClient'

  require 'right_chimp/queue/ChimpQueue'
  require 'right_chimp/queue/QueueWorker'
  require 'right_chimp/queue/ExecutionGroup'

  require 'right_chimp/exec/Executor'
  require 'right_chimp/exec/ExecArray'
  require 'right_chimp/exec/ExecRightScript'
  require 'right_chimp/exec/ExecSSH'
  require 'right_chimp/exec/ExecReport'
  require 'right_chimp/exec/ExecNoop'

  require 'right_chimp/resources/Connection'
  require 'right_chimp/resources/Executable'
  require 'right_chimp/resources/Server'
  require 'right_chimp/resources/Task'
end
