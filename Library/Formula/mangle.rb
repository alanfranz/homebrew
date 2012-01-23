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
EOS
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test mangle`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
