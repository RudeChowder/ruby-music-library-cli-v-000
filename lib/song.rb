# require_relative './concerns/storage.rb'
require 'pry'

class Song
    # extend Concerns::Storage::ClassMethods
    # include Concerns::Storage::InstanceMethods
    attr_accessor :name, :artist
    @@all = []

    def initialize(name, artist = nil)
        @name = name
        if artist != nil
            self.artist = artist
        end
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
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
end