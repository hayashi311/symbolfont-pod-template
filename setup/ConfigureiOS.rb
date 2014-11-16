module Pod

  class ConfigureIOS
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform

      prefix = nil

      loop do
        prefix = configurator.ask("What is your class prefix")

        if prefix.include?(' ')
          puts 'Your class prefix cannot contain spaces.'.red
        else
          break
        end
      end

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "templates/ios/Example/PROJECT.xcodeproj",
        :platform => :ios,
                                  :remove_demo_project => :yes,
        :prefix => prefix
      }).run

      ["Core/CPDSymbol.h", "Core/CPDSymbol.m", "Core/UIFont+CPDSymbolFont.h", "Core/UIFont+CPDSymbolFont.m", "Core/UIImage+CPDSymbolFont.h", "Core/UIImage+CPDSymbolFont.m", "UI/CPDSymbolImageView.h", "UI/CPDSymbolImageView.m"].each do |file|
        before = "./Pod/Classes/" + file
        s = File.read(before, :encoding => Encoding::UTF_8)
        s.gsub!("CPD", prefix)
        s.gsub!("cpd", prefix.downcase)
        File.write(before, s)
        after = "./Pod/Classes/" + file.gsub("CPD", prefix)
        File.rename before, after
      end

      `mv ./templates/ios/* ./`
    end
  end

end
