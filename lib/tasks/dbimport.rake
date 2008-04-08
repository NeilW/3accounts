namespace :db do
  namespace :bulkload do

    desc "Load Quickbooks_6 journals into Rails"
    task :qb6journals => :environment do
      ARGV.shift
      Ledger.load_journals(Qb6JournalFile.new(ARGF))
    end

  end
end
