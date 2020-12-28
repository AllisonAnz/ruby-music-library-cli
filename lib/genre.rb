class Genre
    extend Concerns::Findable 
    attr_accessor :name, :songs
    #song: returns the genre's 'songs' collection
    @@all = []

    def initialize(name)
        @name = name
        @songs = [] #creates a 'songs' property set to an empty array (genre has many songs)#
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
        genre = self.new(name)
        genre.save
        genre
    end

    #artists(has many through)(genre has many artists through songs)
    def artists
        @songs.collect{|s| s.artist}.uniq
    end
end