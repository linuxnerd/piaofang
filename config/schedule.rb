# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "log/cron.log"

every 2.day, :at => '1am' do
  runner "scripts/grab_boxoffice_from_m1905.rb"
  runner "scripts/grab_boxoffice_from_mtime.rb"
end

every 3.day, :at => '6am' do
  runner "scripts/grab_oscar_from_m1905.rb"
end
