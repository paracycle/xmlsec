require 'mkmf'

#unless pkg_config('xmlsec1-openssl')
  root = File.expand_path('../../..', __FILE__)
  puts("Path is #{root}")

  Dir.chdir(root) do
    puts("Initializing submodules")
    system "git submodule init"
    system "git submodule update"
  end

  Dir.chdir(File.join(root, 'vendor/xmlsec')) do
    puts("Building vendor xmlsec")
    system "./autogen.sh", "--prefix=#{root}", "--without-libxslt"
    #system "./configure", "--prefix=#{root}"
    system "make"
    system "make install"
    system "make clean"
  end
#end
dir_config('xmlsec', "#{root}/include/xmlsec1", "#{root}/lib")
dir_config('libxml2', "/usr/include/libxml2", "/usr/lib")
create_makefile('xmlsec/xmlsec_ext')
