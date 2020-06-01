require 'pry'

class Artist
    attr_accessor :name
    attr_reader :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def save
        @@all << self
    end

    def add_song(song)
        if !song.artist
            song.artist = self
        end
        if !@songs.include?(song)
            @songs << song
        end
    end

    def songs
       @songs
    end

end