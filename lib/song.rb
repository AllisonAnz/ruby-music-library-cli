require 'pry'
class Song
    attr_accessor :name
    attr_reader :artist, :genre
    # :name => #retrieves the name of a song,
    # :artist =>assigns an artist to the song
    @@all = []

    def initialize(name, artist = nil, genre = nil) #initialize: accepts a name for the new song, optional second argument for artist
        @name = name #name= retrieves the name of a song
        self.artist = artist if artist # invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization
        self.genre = genre if genre
    end

    def artist=(artist) #writer, invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
        @artist = artist
        artist.add_song(self)
    end

    #genre
    #assigns a genre to the song (song belongs to genre)
    #adds the song to the genre's collection of songs (genre has many songs)
    #does not add the song to the genre's collection of songs if it already exists therein
    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    #.find_by_name
    #finds a song instance in @@all by name property of the song
    def self.find_by_name(name)
        all.detect{|s| s.name == name}
    end

    #find_or_create_by_name
    #returns(does not recreate) an existing song with the provided name if one exists in @@all
    #invokes .find_by_name instead of re-coding
    #creates a song if an existing match is not found
    #invokes .create instead of re-coding
    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        parts = filename.split(" - ")
        artist_name = parts[0]
        song_name = parts[1]
        genre_name = parts[2].split(".mp3").join

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end


end