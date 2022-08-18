class Neopass < Formula
  desc "A simple password manager that uses age encryption."
  homepage "https://github.com/nwehr/neopass"
  version "1.1.0"
  url "https://github.com/nwehr/neopass/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b14d8eab2d169bf2ef560e92cd8f5cbe5e78844cfb5c5f1753ccd1ee031097bd"
  license "BSD 2-Clause"

  depends_on "go@1.18" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/nwehr/neopass").install buildpath.children
    cd "src/github.com/nwehr/neopass" do
      system "go", "get", "./..."
      system "go", "build", "-ldflags", "-X main.Version="+self.version, "-o", bin/"neopass", "cmd/client/main.go"
    end
  end

  test do
    system "#{bin}/neopass", "version"
  end
end

