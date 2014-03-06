require 'fileutils'

ROOT   = ARGV.shift || Dir.getwd
DRYRUN = ARGV.shift == '--dry-run' 

Dir.chdir(ROOT) do
  Dir.glob('*').each do |file|
    next unless File.file?(file)
    date = File.mtime(file).strftime('%Y-%m-%d')
    destination = File.join(date, file)
    puts "* %-40s => #{destination} ..." % [file]

    unless DRYRUN
      FileUtils.mkdir_p(date)
      FileUtils.mv(file, destination)
    end
  end
end
