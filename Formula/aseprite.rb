class Aseprite < Formula
  desc "Animated sprite editor & pixel art tool (Windows, macOS, Linux)"
  homepage "https://aseprite.org"
  url "https://github.com/aseprite/aseprite/releases/download/v1.2.40/Aseprite-v1.2.40-Source.zip"
  sha256 "cd67eaf34ee19ae5584f9052f3b385dcfa41232f38016baf08723b987ae583fb"
  license "EULA"
  head "https://github.com/aseprite/aseprite", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on arch: :arm64
  depends_on xcode: ["13.1", :build]

  resource "skia" do
    url "https://github.com/aseprite/skia/releases/download/m102-861e4743af/Skia-macOS-Release-arm64.zip"
    sha256 "3eac3a0a5792a38e1b21a429b359316cfbe402d77795861a3d40d52c1a8cb8cd"
  end

  def install
    resource("skia").stage(buildpath/"skia")
    mkdir "build"
    cd "build" do
      system "cmake",
        "-DCMAKE_BUILD_TYPE=RelWithDebInfo",
        "-DCMAKE_MACOSX_RPATH=1",
        "-DCMAKE_OSX_ARCHITECTURES=arm64",
        "-DCMAKE_OSX_DEPLOYMENT_TARGET=11.0",
        "-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk",
        "-DLAF_BACKEND=skia",
        "-DSKIA_DIR=#{buildpath}/skia",
        "-DSKIA_LIBRARY_DIR=#{buildpath}/skia/out/Release-arm64",
        "-DSKIA_LIBRARY=#{buildpath}/skia/out/Release-arm64/libskia.a",
        "-DPNG_ARM_NEON:STRING=on",
        "-G", "Ninja",
        buildpath
      system "ninja", "aseprite"
    end
    libexec.install Dir["build/bin/*"]
    bin.install_symlink Dir[libexec/"*"]
  end

  test do
    system bin/"aseprite", "--help"
  end
end
