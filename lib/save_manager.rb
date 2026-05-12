require_relative "constants"
require "date"

# Methods related to saving and loading game state
module Chess
  def self.save(string, name = "#{DateTime.now.strftime('%Y_%m_%d:%H-%M-%S')}.save")
    savedir = Constants::SAVES
    Dir.mkdir(savedir) unless Dir.exist?(savedir)
    fname = "#{savedir}/#{name}"
    File.new(fname, FILE::CREAT, 0o755)
    File.write(fname, string)
  end

  def self.load(fname)
    return unless File.exist?(fname)

    str = ""
    File.open(path) { |f| str = f.readlines }
    str[0]
  end

  def self.list_saves
    Dir["#{Constants::SAVES}/*.save"]
  end
end
