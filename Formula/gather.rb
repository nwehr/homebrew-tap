class Gather < Formula
    desc "Gather output from multiple shell commands"
    homepage "https://github.com/nwehr/gather"
    version "1.0.0"
    url "https://github.com/nwehr/gather/archive/refs/tags/v1.0.0.tar.gz"
    sha256 "dc4156435c3fa1bd5a2ace001faff21bb25e0a032f550099b6d329ee42fbe61b"
    license "BSD 2-Clause"
  
    depends_on "go@1.18" => :build
  
    def install
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "on"
      ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
      (buildpath/"src/github.com/nwehr/gather").install buildpath.children
      cd "src/github.com/nwehr/gather" do
        system "go", "build", "-ldflags", "-X main.commit="+self.version, "-o", bin/"gather", "main.go"
      end
    end
  
    test do
      system "#{bin}/gather"
    end
  end
  
  