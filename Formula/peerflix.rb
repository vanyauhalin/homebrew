require "language/node"

class Peerflix < Formula
  desc "Streaming torrent client for node.js"
  homepage "https://github.com/mafintosh/peerflix"
  url "https://github.com/mafintosh/peerflix/archive/refs/tags/v0.39.0.zip"
  sha256 "25b8d2a8092c59b751a06fcc855822c2cb3bbbe981dd9667c1c74e9012c0c432"
  license "MIT"
  head "https://github.com/mafintosh/peerflix", branch: "master"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system bin/"peerflix", "-h"
  end
end
