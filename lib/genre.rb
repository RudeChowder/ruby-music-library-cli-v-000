require_relative './concerns/findable.rb'

class Genre
    extend Concerns::Findable
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def songs
        @songs
    end

    def add_song(song)
        if !song.genre
            song.genre = self
        end
        if !@songs.include?(song)
            @songs << song
        end
    end

    def artists
        collection = songs.collect do |song|
            if song.genre == self
                song.artist
            end
        end
        collection.uniq
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        genre = self.new(name)
        genre.save
        genre
    end
end