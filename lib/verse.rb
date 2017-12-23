class Verse
attr_accessor :title, :description
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
