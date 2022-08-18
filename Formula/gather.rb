class Gather < Formula
    desc "Gather output from multiple shell commands"
    homepage "https://github.com/nwehr/gather"
    version "1.0.0"
    url "https://github.com/nwehr/gather/archive/refs/tags/v1.0.0.tar.gz"
    sha256 "7ce8bed816101fbac501f2ee5fb1470107219000"
    license "BSD 2-Clause"
  
    depends_on "go@1.18" => :build
  
    def install
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "on"
      ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
      (buildpath/"src/github.com/nwehr/gather").install buildpath.children
      cd "src/github.com/nwehr/gather" do
        system "make", "install"
      end
    end
  
    test do
      system "#{bin}/gather"
    end
  end
  
  