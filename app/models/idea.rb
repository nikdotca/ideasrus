class Idea < ActiveRecord::Base
  
  validates_presence_of :text, :poster
  
  attr_accessor :text, :poster
  def initialize( *args )
    super( *args )
    @votes = 0
  end
  def self.find_from_twitter
    results = Twitter::Search.new.to('ideasrus').fetch
    results['results'].map do |r|
      build_from_hash( r )
    end 
  end
  
  def self.find_from_twitter_for(username)
    results = Twitter::Search.new.to('ideasrus').from(username).fetch
    results['results'].map do |r|
      build_from_hash( r )
    end
  end
  
  def vote_up
    @votes += 1
  end
  
  def votes
    @votes
  end
  
  private
  def self.build_from_hash( hash )
    Idea.create( :text => hash['text'], :poster => hash["from_user"] )
  end

end
