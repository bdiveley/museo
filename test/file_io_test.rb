require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_io'
require 'pry'

class FileIOTest < Minitest::Test
  def test_it_can_load_artists
    artists = FileIO.load_artists('./data/artists.csv')
    assert_equal 6, artists.length
    artist_4 = {
      id: "4",
      name: "Walker Evans",
      born: "1903",
      died: "1975",
      country: "United States"
    }
    assert_equal artist_4, artists[3]
  end

  def test_it_can_load_photographs
    photographs = FileIO.load_photographs('./data/photographs.csv')
    assert_equal 4, photographs.length
    photograph_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    assert_equal photograph_3, photographs[2]
  end
end
