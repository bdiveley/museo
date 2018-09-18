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
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).count > 1
    end
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

  def load_photographs(file)
    photo_data = FileIO.load_photographs(file)
    photo_data.each do |photo_hash|
      add_photograph(photo_hash)
    end
  end

  def load_artists(file)
    artist_data = FileIO.load_artists(file)
    artist_data.each do |artist_hash|
      add_artist(artist_hash)
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      range.include?(photo.year.to_i)
    end
  end

  def calculate_artist_age_by_photo(photo)
    found = @artists.find do |artist|
      artist.id == photo.artist_id
    end
    age = photo.year.to_i - found.born.to_i
  end

  def artists_photographs_by_age(artist)
    grouped_by_age = {}
    @photographs.each do |photo|
      grouped_by_age[calculate_artist_age_by_photo(photo)] = photo.name
    end
    return grouped_by_age.to_a.reverse.to_h
  end
end
