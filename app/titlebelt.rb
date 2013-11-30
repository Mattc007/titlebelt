$: << File.dirname(__FILE__)

require 'titlebelt/data'
require 'titlebelt/runner'

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @title = 'NCAA Titlebelt Analyzer'
  haml :index
end

get '/:team/:year' do
  @team = params[:team]
  @year = params[:year]

  haml :show 

  # if @results = TitleBelt::Runner.analyze(team, year)
  #   @title = "Analyzer results for #{team} in #{year}"
  #   haml :show
  # else
  #   redirect '/'
  # end
end
