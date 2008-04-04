namespace :db do
  namespace :bulkload do

    desc "Load Quickbooks_6 data into Rails"
    task :quickbooks6 => :environment do
      require 'fastercsv'
      ARGV.shift
      splitter=/[\t\r\n]/
      columns = ARGF.readline.split(splitter)
      columns[0] = "Account"
      puts FasterCSV.generate_line(columns)
      @current_account = ""
      ARGF.each_line do |line|
        split_line = line.split(splitter)
        case line
        when /^\t/
          split_line[0] = @current_account
          puts FasterCSV.generate_line(split_line)
        when /^Total/
          @current_account = remove_last_colon(@current_account)
        else
          @current_account = join_with_colons(@current_account, split_line[0])
        end
      end
    end

    def remove_last_colon(from_string)
      temp = from_string.split(":")
      temp.delete_at(-1)
      temp.join(":")
    end

    def join_with_colons(current_string, appendage)
      if current_string.nil? || current_string == ""
        appendage
      else
        "#{current_string}:#{appendage}"
      end
    end

  end
end
