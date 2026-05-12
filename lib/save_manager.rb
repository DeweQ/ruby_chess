require_relative "constants"
require "date"

# Methods related to saving and loading game state
module Chess
  def self.save(string, name = DateTime.now.strftime("%Y_%m_%d:%H-%M-%S"))
    savedir = Constants::SAVES
    Dir.mkdir(savedir) unless Dir.exist?(savedir)
    fname = "#{savedir}/#{name}.save"
    File.new(fname, File::CREAT, 0o755)
    File.write(fname, string)
  end

  def self.load(fname)
    return unless File.exist?(fname)

    str = ""
    File.open(fname) { |f| str = f.readlines }
    str[0]
  end

  def self.list_saves
    Dir["#{Constants::SAVES}/*.save"]
  end
end
