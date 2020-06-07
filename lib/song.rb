# require_relative './concerns/storage.rb'
require_relative './concerns/findable.rb'
require 'pry'

class Song
    extend Concerns::Findable
    # extend Concerns::Storage::ClassMethods
    # include Concerns::Storage::InstanceMethods
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist != nil
            self.artist = artist
        end
        if genre != nil
            self.genre = genre
        end
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def self.split_artist_and_title(filename)
        filename.chomp!(".mp3").split(" - ")
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def self.new_from_filename(filename)
        info = split_artist_and_title(filename)
        if !find_by_name(name)
            artist = Artist.find_or_create_by_name(info[0])
            genre = Genre.find_or_create_by_name(info[2])
            self.new(info[1], artist, genre)
        end
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end
end