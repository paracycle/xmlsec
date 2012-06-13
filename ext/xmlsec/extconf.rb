require 'mkmf'

unless pkg_config('xmlsec1-openssl')
  root = File.expand_path('../../..', __FILE__)

  Dir.chdir(File.join(root, 'vendor/xmlsec')) do
    system "./configure", "--prefix=#{root}"
    system "make"
    system "make install"
    system "make clean"
  end
end
dir_config('opt', "#{root}/include", "#{root}/lib")
create_makefile('xmlsec/xmlsec_ext')
