require 'pry'
class MusicImporter

    attr_reader :path

    def initialize(filepath)
        @path = filepath
    end

    #files
    #loads all the MP3 files in the path directory
    #normalizes the filenames to just the mP3 filename with no path
    def files
        @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
    end

    def import 
        files.each{ |f| Song.create_from_filename(f) }
    end
    
end