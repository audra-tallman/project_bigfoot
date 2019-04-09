class State

@@all = []

  attr_accessor :name, :url, :reports

  def initialize(name, url)
    @name= name
    @url= url
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.states_only
    @@all.slice(0..48)
  end

end
