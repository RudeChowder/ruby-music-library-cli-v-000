require 'pry'

class MusicLibraryController
    attr_accessor :path

    def initialize(path = "./db/mp3s")
        self.path = path
        importer = MusicImporter.new(path)
        importer.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = ""
        until input == "exit" do
            input = gets.chomp
            case input
             when 'list songs' then list_songs
             when 'list artists' then list_artists
             when 'list genres' then list_genres
             when 'list artist' then list_songs_by_artist
             when 'list genre' then list_songs_by_genre
             when 'play song' then play_song
            end
        end
    end

    def list_songs
        all_songs = Song.all
        all_songs.sort_by! {|song| song.name}
        all_songs.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        all_artists = Artist.all
        all_artists.sort_by! {|artist| artist.name}
        all_artists.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
    end

    def list_genres
        all_genres = Genre.all
        all_genres.sort_by! {|genre| genre.name}
        all_genres.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        if Artist.find_by_name(input)
            artist = Artist.find_by_name(input)
            songs = artist.songs.sort_by! {|song| song.name}
            songs.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        if Genre.find_by_name(input)
            genre = Genre.find_by_name(input)
            songs = genre.songs.sort_by! {|song| song.name}
            songs.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        all_songs = Song.all
        all_songs.sort_by! {|song| song.name}
        input = gets.chomp
        index = input.to_i - 1
        if index >= 0 && index < all_songs.length
            chosen_song = all_songs[index]
            puts "Playing #{chosen_song.name} by #{chosen_song.artist.name}"
        end
    end
end