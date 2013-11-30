module TitleBelt
  class Data
    require 'open-uri'

    class << self

      def grab
        url ||= 'http://homepages.cae.wisc.edu/~dwilson/rsfc/history/howell/'

        (1869..2011).each do |year|
          begin
            open("app/titlebelt/data/#{year}.txt", 'wb') do |file|
              puts "getting #{year}..."
              file << open("#{url}cf#{year}gms.txt").read
              puts "done!"
            end
          rescue Exception => e
            puts "could not get a file for the year #{year}"
            puts e.message
          end
        end
      end

      def process(start_year = 1971)
        results = [] # [ [day, winner, loser], * ]

        epoch_date = Date.new(start_year.to_i,1,1)

        (1869...2011).each do |year|
          begin
            open("app/titlebelt/data/#{year}.txt") do |file|
              file.each do |row|
                if row.gsub(/\s/,'').length > 1
                  row.squeeze!(' ').gsub!(/\s[@].+/,'')

                  date = Date.strptime(row[0..9], '%m/%d/%Y')
                  break if date < epoch_date

                  days = (date - epoch_date).to_i

                  row = row[11..-1]
                  split_row = row.split(/(\b(?=\d))|((?<=\d)\b)/)

                  tie_score = split_row[2].to_i == split_row[6].to_i

                  if split_row[2].to_i > split_row[6].to_i
                    winning_team = split_row[0].strip
                    losing_team = split_row[4].strip
                  else
                    winning_team = split_row[4].strip
                    losing_team = split_row[0].strip
                  end

                  results << [days, winning_team, losing_team, tie_score, date]

                end
              end
            end
          rescue Exception => e
            puts "#{e.message}"
          end
        end
        results
      end
    end
  end
end

