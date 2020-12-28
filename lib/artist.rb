class Artist
    extend Concerns::Findable 
    attr_accessor :name, :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        artist = self.new(name)
        artist.save
        artist
    end

    #assigns the current artist to the song's 'artist' property (song belongs to artist)
    #does not assign the artist if the song already has an artist
    #adds the song to the current artist's 'songs' collection
    #does not add the song to the current artist's collection of songs if it already exists therein
    def add_song(song)
        songs << song unless songs.include?(song)
        song.artist = self unless song.artist
    end

    #genres (artist has many genres through songs)
    #returns a collection of genres for all of the artist's songs
    #does not return duplicate genres if artist has more than one song in a particular genre
    #collects genres through its songs instead of maintaining its own @genre intance variable
    def genres
        @songs.collect{ |s| s.genre}.uniq
    end
end