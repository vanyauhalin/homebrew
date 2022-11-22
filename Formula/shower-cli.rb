require "language/node"

class ShowerCli < Formula
  desc "Command line interface for Shower"
  homepage "https://github.com/shower/cli"
  url "https://github.com/shower/cli/archive/refs/tags/v0.3.1.zip"
  sha256 "f26dde8532bd8f3cf1fac5439c5791338bd053e322adf71138955324890df822"
  license "MIT"
  head "https://github.com/shower/cli", branch: "master"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system bin/"shower", "-h"
  end
end
