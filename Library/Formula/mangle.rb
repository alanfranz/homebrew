require 'formula'

class Mangle < Formula
  url 'https://github.com/downloads/alanfranz/mangle/alanfranz-mangle-61a332c.zip'
  md5 'b03c8977483ca6a2f30e8108620b0876'
  version '20120124'
  head 'git://github.com/alanfranz/mangle.git', :using => :git
  homepage 'http://foosoft.net/mangle'

  depends_on 'pyqt'
  depends_on 'setuptools' => :python

  def install
    ENV.prepend 'PYTHONPATH', "#{HOMEBREW_PREFIX}/lib/python", ':'
    system "python2.7", 'setup.py', 'install'
    File.open("#{HOMEBREW_PREFIX}/bin/mangle", 'w') {|f| 
        f.write("#!/usr/bin/env bash\n")
        f.write("PYTHONPATH=#{HOMEBREW_PREFIX}/lib/python python2.7 -m mangle\n")
    }
    File.chmod(0777, "#{HOMEBREW_PREFIX}/bin/mangle")
  end

  def caveats; <<-EOS
      You need python2.7 in your system in order for this to work.
      If you're running a version of OSX older than 10.7 you'll need to install
      it someway.
EOS
  end

  def test
    system "python2.7 -c 'import mangle'"
  end
end
