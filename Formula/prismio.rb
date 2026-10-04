class Prismio < Formula
  desc "Compiled, statically typed language with compiler-managed memory"
  homepage "https://prismio.org"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/prismio-lang/prismio/releases/download/v#{version}/prismio-#{version}-macos-arm64.tar.gz"
      sha256 "57405fdb40a329a7afc418cd6ef3fa583dfca6268867ac030f183735425f8598"
    else
      odie "Prismio currently publishes macOS binaries for Apple Silicon only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/prismio-lang/prismio/releases/download/v#{version}/prismio-#{version}-linux-arm64.tar.gz"
      sha256 "f3cd7ea606fe2a69ade10208529e72c82941c217b21959b1d634c5cdf17ddbf4"
    elsif Hardware::CPU.intel?
      url "https://github.com/prismio-lang/prismio/releases/download/v#{version}/prismio-#{version}-linux-x64.tar.gz"
      sha256 "9e4c11ca32bed81e1063fa03a5bf5f4ea8201a113040c51410185f57789a3230"
    end
  end

  def install
    archive = Dir["prismio-*"].first
    libexec.install Dir["#{archive}/*"]
    bin.install_symlink libexec/"bin/prismio"
  end

  test do
    assert_match "prismio #{version}", shell_output("#{bin}/prismio --version")
  end
end
