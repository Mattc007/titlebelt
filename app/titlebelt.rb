$: << File.dirname(__FILE__)

require 'titlebelt/data'
require 'titlebelt/runner'

require 'pry'

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @title = 'NCAA Titlebelt Analyzer'
  haml :index
end

get '/:team/:year' do
  team = params[:team]
  year = params[:year]

  @title = "Results starting for #{year} #{team}"

  if @results = TitleBelt::Runner.analyze(team, year)
    @title = "Results for #{team}, #{year}"
    haml :show
  else
    redirect '/'
  end
end
