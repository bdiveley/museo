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

  def find_artist_by_id(search_id)
    @artists.find do |artist|
      artist.id == search_id
    end
  end

  def find_photograph_by_id(search_id)
    @photographs.find do |photo|
      photo.id == search_id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    multiples = []
    @artists.each do |artist|
      number = @photographs.count do |photo|
        photo.artist_id == artist.id
      end
      multiples << artist if number > 1
    end
    return multiples
  end

  def photographs_taken_by_artists_from(location)
    artists_from_location = artists_from(location)
    photos = []
    artists_from_location.each do |artist|
      photos << find_photographs_by_artist(artist)
    end
    return photos.flatten 
  end

  def artists_from(location)
    @artists.find_all do |artist|
      artist.country == location
    end
  end
end
