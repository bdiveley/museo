class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    new_photo = Photograph.new(photo)
    @photographs << new_photo
    return new_photo
  end

  def add_artist(artist)
    new_artist = Artist.new(artist)
    @artists << new_artist
    return new_artist
  end 
end
