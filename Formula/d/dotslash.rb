class Dotslash < Formula
  desc "Simplified executable deployment"
  homepage "https://dotslash-cli.com"
  url "https://github.com/facebook/dotslash/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "c8d24060cc0a4ec374ea519133948b2229f0aca6e696fdfc330601d9d9cd5509"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7b087c6a4f0207fd8ca54821c420321a08e684a9fca2486e9400674c5c9747bb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fe3728c3323b332d8e0d6499264dd2f862ca1207e7215d75e3633dd09dece172"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "520f4f4fdbeccaeee23b10d32730bdcdaf65c8aa5da07feb2355a164be0637f4"
    sha256 cellar: :any_skip_relocation, sonoma:         "cf0745d0c6b3ec44bdbcf9018793ffbd4d2394ef90c5f24ce6e572f97cd5ffcc"
    sha256 cellar: :any_skip_relocation, ventura:        "b5d5d689e3b2ee39e322a47a745dee54ab53b7d9f1cc1a00c7072c2761aba3a6"
    sha256 cellar: :any_skip_relocation, monterey:       "bc6de3b7a0a285d83fb751b02171c86f43f3e048285f37f91d9c9de249e01754"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c9ee326d1a8cb00ca1809713537ef10ccea47f18c7680e208efa9ed9b8e124a"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"node").write <<~EOS
      #!/usr/bin/env dotslash

      // Example file from https://dotslash-cli.com/docs/.
      // The URLs in this file were taken from https://nodejs.org/dist/v18.19.0/

      {
        "name": "node-v18.19.0",
        "platforms": {
          "macos-aarch64": {
            "size": 40660307,
            "hash": "blake3",
            "digest": "6e2ca33951e586e7670016dd9e503d028454bf9249d5ff556347c3d98c347c34",
            "format": "tar.gz",
            "path": "node-v18.19.0-darwin-arm64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-darwin-arm64.tar.gz"
              }
            ]
          },
          "macos-x86_64": {
            "size": 42202872,
            "hash": "blake3",
            "digest": "37521058114e7f71e0de3fe8042c8fa7908305e9115488c6c29b514f9cd2a24c",
            "format": "tar.gz",
            "path": "node-v18.19.0-darwin-x64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-darwin-x64.tar.gz"
              }
            ]
          },
          "linux-x86_64": {
            "size": 44694523,
            "hash": "blake3",
            "digest": "72b81fc3a30b7bedc1a09a3fafc4478a1b02e5ebf0ad04ea15d23b3e9dc89212",
            "format": "tar.gz",
            "path": "node-v18.19.0-linux-x64/bin/node",
            "providers": [
              {
                "url": "https://nodejs.org/dist/v18.19.0/node-v18.19.0-linux-x64.tar.gz"
              }
            ]
          }
        }
      }
    EOS
    chmod 0755, testpath/"node"
    assert_match "v18.19.0", shell_output("#{testpath}/node -v")
  end
end
