module Utilities
  class Data
    require 'open-uri'
    require 'csv'

    class << self

      def grab
        url ||= 'http://homepages.cae.wisc.edu/~dwilson/rsfc/history/howell/'

        (1869..2010).each do |year|
          begin
            open("../var/#{year}.txt", 'wb') do |file|
              puts "getting #{year}..."
              file << open("#{url}cf#{year}gms.txt").read
              puts "done!"
            end
          rescue
            puts "could not get a file for the year #{year}"
          end
        end
      end

      def process
        data_blob = {} # { team: [wins, losses, ties] }
        (2010...2011).each do |year|
          begin
            puts "opening #{year}.txt"
            parsed_file = CSV.read("../var/#{year}.txt", { col_sep: "\t" })
            if parsed_file
              puts "opened #{year}.txt!"

              parsed_file.each do |row|
                winning_team = row[0]
                losing_team = row[3]
                puts "#{winning_team} | #{losing_team}"
              end
            end
          rescue Exception => e
            puts "#{e.message}"
          end
        end
      end

    end

  end
end

