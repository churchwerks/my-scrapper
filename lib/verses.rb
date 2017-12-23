class Verses
attr_accessor :title, :url
@@all = []

  def self.all
   @@all
  end

  def self.reset_all
   @@all.clear
  end

  def save
  @@all << self
  end

end
