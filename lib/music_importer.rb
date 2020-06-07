class MusicImporter
    attr_reader :path

    def initialize(path)
        @path = path
    end

    def files
        Dir["#{path}/**/*.mp3"].collect {|file| File.basename file}
    end

    def import
        filenames = files
        filenames.each {|filename| Song.create_from_filename(filename)}
    end
end