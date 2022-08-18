class Gather < Formula
    desc "Gather output from multiple shell commands"
    homepage "https://github.com/nwehr/gather"
    version "1.0.1"
    url "https://github.com/nwehr/gather/archive/refs/tags/v1.0.1.tar.gz"
    sha256 "84f4d4a63b89e20e5682e7a1f99c39dd01967bcd82610f90f24035148f67cb98"
    license "BSD 2-Clause"
  
    depends_on "go@1.18" => :build
  
    def install
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "on"
      ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
      (buildpath/"src/github.com/nwehr/gather").install buildpath.children
      cd "src/github.com/nwehr/gather" do
        system "go", "build", "-ldflags", "-X main.version="+self.version, "-o", bin/"gather", "main.go"
      end
    end
  
    test do
      system "#{bin}/gather"
    end
  end
  
  