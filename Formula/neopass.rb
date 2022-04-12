class Neopass < Formula
  desc "A simple password manager that uses age encryption."
  homepage "https://github.com/nwehr/neopass"
  version "1.0.4"
  url "https://github.com/nwehr/neopass/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "a98f7a3155f5d8426df041f18ca72a8b6b2f7531bf0990138ad7848c99592718"
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

