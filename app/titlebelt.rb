$: << File.dirname(__FILE__)

require 'titlebelt/data'
require 'titlebelt/runner'

require 'pry'
require 'data_mapper'
require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'
require 'dm-timestamps'

configure do
  DataMapper::setup(:default, File.join('sqlite3://', Dir.pwd, 'development.db'))
end

configure :development do
  DataMapper.finalize
  DataMapper.auto_upgrade!
end

class Result
  include DataMapper::Resource

  property :id,           Serial
  property :winning_team, String
  property :losing_team,  String
  property :date,         DateTime
end

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

helpers do
  def options(property, p)

  end
end

get '/' do
  @title = 'NCAA Titlebelt Analyzer'
  haml :index
end

get '/analyze/:team/:year' do
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
