class Neopass < Formula
  desc "A simple password manager that uses age encryption."
  homepage "https://github.com/nwehr/neopass"
  version "2.2.0"
  url "https://github.com/nwehr/neopass/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "28a967656df7ccf86fdfb8708f24745eb45b57c88d4fa3c159337d4046fc77ea"
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

