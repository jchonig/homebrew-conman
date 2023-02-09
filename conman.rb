class Conman < Formula
  desc "ConMan: The Console Manager"
  homepage "https://github.com/dun/conman"
  url "https://github.com/dun/conman/archive/conman-0.3.0.tar.gz"
  sha256 "51d379187028317784305588ce3770e66d56c201c3d98afbf823eac039f4583c"
  license "GPL-3.0-only"
  depends_on "freeipmi" => :optional

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats
    <<~EOS
      Before starting the conmand service, configure some consoles in #{etc}/conman.conf.
      To use IPMI consoles, be sure to install with --with-freeipmi.
    EOS
  end

  service do
    run [opt_sbin/"conmand", "-F", "-c", etc/"conman.conf"]
    keep_alive true
  end

  test do
    system bin/"conman", "-V"
    system sbin/"conmand", "-V"
  end
end
