class Neopass < Formula
  desc "A simple password manager that uses age encryption."
  homepage "https://github.com/nwehr/neopass"
  version "2.1.0"
  url "https://github.com/nwehr/neopass/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "510a2b1ecd7f910684476292328fb52c818ca540cb17c8728afb2964b5a059e3"
  license "BSD 2-Clause"

  depends_on "go@1.18" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/nwehr/neopass").install buildpath.children
    cd "src/github.com/nwehr/neopass" do
      system "go", "get", "./..."
      system "go", "build", "-ldflags", "-X main.version="+self.version, "-o", bin/"neopass", "cmd/client/main.go"
    end
  end

  test do
    system "#{bin}/neopass", "version"
  end
end

