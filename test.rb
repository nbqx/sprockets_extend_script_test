%w(sprockets fileutils).each{|x| require x}

ENV["INDESIGN_VERSION"] = "#target InDesign-7.0"

jsx_main = 'index.jsx'
jsx_folder = './jsx'
build_folder = './build'
files = Dir.glob("#{jsx_folder}/**/*").select{|x| File.file? x}.map{|x| File.basename x}

unless File.exists? build_folder
  FileUtils.mkdir_p build_folder
end

env = Sprockets::Environment.new Dir.pwd
env.register_mime_type 'application/javascript', '.jsx'
env.append_path jsx_folder

manifest = Sprockets::Manifest.new env, build_folder
manifest.compile files

open(jsx_main, "w") do |f| 
  f.write env[jsx_main]
end
