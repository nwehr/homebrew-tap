class Killport < Formula
  desc "Kills a process that has the specified open port"
  homepage "https://github.com/nwehr/killport"
  version "1.0.0"
  url "https://github.com/nwehr/killport/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "85c86170ee67062b6a408e669c77dea957d9452807db65577eeaf286c00a74c3"
  license "BSD 2-Clause"

  def install
    bin.install "killport"
  end
end

