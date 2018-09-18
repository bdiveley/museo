class Photograph
  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(photo_hash)
    @id = photo_hash[:id]
    @name = photo_hash[:name]
    @artist_id = photo_hash[:artist_id]
    @year = photo_hash[:year]
  end
end
