class Tuist < Formula
  desc "Create, maintain, and interact with Xcode projects at scale"
  homepage "https://tuist.io"
  url "https://github.com/tuist/tuist/releases/download/3.12.1/tuistenv.zip"
  sha256 "d2cc5496278b8115bd210111b550e54836c9c2c1f7f0e4db2774308269fdc9a0"
  license "MIT"
  head "https://github.com/tuist/tuist", branch: "main"

  def install
    File.rename("tuistenv", "tuist")
    bin.install "tuist"
  end

  test do
    system bin/"tuist", "--help-env"
    system bin/"tuist", "local", "3.12.1"
  end
end
