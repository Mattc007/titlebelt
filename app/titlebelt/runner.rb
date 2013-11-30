module TitleBelt
  class Runner
  
    class << self
      def analyze(team = 'Nebraska', start_year = 1971)
        data = Data.process(start_year)
        date, winner = nil, nil

        results = [team]
        streak = 0

        data.each do |game|
          if team.downcase == game[1].downcase || team.downcase == game[2].downcase
            date = game[0]
            game[1].downcase == team.downcase ? winner = game[1] : winner = game[2]
            break
          end
        end

        raise 'team not found' unless date

        data.each do |game|
          # next game where previous winner is loser, and this game isn't a tie
          if game[0] > date && game[2] == winner && game[3] == false
            winner = game[1]
            date = game[0]
            results[-1] = [results[-1], streak, game[4]]
            streak = 0
            results << winner
          else  
            streak += 1 if game[1] == winner
          end
        end

        results[-1] = [winner, streak, nil]

        return results
      end
    end
  end
end
