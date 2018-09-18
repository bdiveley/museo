require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require 'pry'

class CuratorTest < Minitest::Test

  def test_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_it_starts_with_no_artists_or_photos
    curator = Curator.new

    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }

    rue = curator.add_photograph(photo_1)
    moonrise = curator.add_photograph(photo_2)

    assert_equal [rue, moonrise], curator.photographs
    assert_equal rue, curator.photographs.first
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }

    henri = curator.add_artist(artist_1)
    ansel = curator.add_artist(artist_2)

    assert_equal [henri, ansel], curator.artists
    assert_equal henri, curator.artists.first
    assert_equal "Henri Cartier-Bresson", curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }

    henri = curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal henri, curator.find_artist_by_id("1")
  end

  def test_it_can_find_photo_by_id
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }

    curator.add_photograph(photo_1)
    moonrise = curator.add_photograph(photo_2)

    assert_equal moonrise, curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    twins = curator.add_photograph(photo_3)
    child = curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")


    assert_equal [twins, child], curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_can_find_artists_with_multiple_photos
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")


    assert_equal [diane_arbus], curator.artists_with_multiple_photographs
    assert_equal 1, curator.artists_with_multiple_photographs.length
    assert diane_arbus == curator.artists_with_multiple_photographs.first
  end

  def test_it_finds_all_artists_by_birthplace
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    ansel = curator.add_artist(artist_2)
    diane = curator.add_artist(artist_3)

    assert_equal [ansel, diane], curator.artists_from("United States")
  end

  def test_it_finds_all_photos_taken_by_artist_birthplace
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    curator = Curator.new
    curator.add_photograph(photo_1)
    moonrise = curator.add_photograph(photo_2)
    twins = curator.add_photograph(photo_3)
    child = curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    assert_equal [moonrise, twins, child], curator.photographs_taken_by_artists_from("United States")
    assert_equal [], curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_load_photographs_from_csv
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_equal 4, curator.photographs.length
    assert_instance_of Photograph, curator.photographs[0]
  end

  def test_it_can_load_artists_from_csv
    curator = Curator.new
    curator.load_artists('./data/artists.csv')

    assert_equal 6, curator.artists.length
    assert_instance_of Artist, curator.artists[0]
  end

  def test_it_can_find_photos_taken_in_range
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_equal 2, curator.photographs_taken_between(1950..1965).length
    assert_instance_of Photograph, curator.photographs_taken_between(1950..1965)[0]
    assert (1950..1965).include?(curator.photographs_taken_between(1950..1965)[0].year.to_i)
  end

  def test_it_can_calculate_artist_age_by_photo
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')
    twins = curator.find_photograph_by_id("3")


    assert_equal 44, curator.calculate_artist_age_by_photo(twins)
  end

  def test_it_can_group_photos_by_artist_age
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')

    diane_arbus = curator.find_artist_by_id("3")

    assert_instance_of Hash, curator.artists_photographs_by_age(diane_arbus)

    expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park", 46=>"Rue Mouffetard, Paris (Boy with Bottles)"}
    assert_equal expected, curator.artists_photographs_by_age(diane_arbus)
  end
end
