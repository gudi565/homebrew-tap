# Homebrew Cask for 流畅对话
#
# 这是「免费发布」方案：ad-hoc 签名、未经 Apple 公证。Homebrew 主仓不收未公证 App，
# 所以走自建 tap：把这个目录放进一个名为 homebrew-<任意> 的 GitHub 仓库的 Casks/ 下，
# 用户即可 `brew tap <user>/homebrew-<name> && brew install --cask fluentspeech`。
#
# 详细见同目录 ../RELEASE.md「Homebrew tap」一节。

cask "fluentspeech" do
  version "0.1.0"
  sha256 "9e1abcc01b5d2b6acaf3ba3a4c59b5c77c2f8bf2c3aea047413ef1e9c9ddd0ac"

  url "https://github.com/gudi565/fluentspeech/releases/download/v#{version}/FluentSpeech-#{version}.dmg"
  name "流畅对话"
  desc "实时中文表达训练（Whisper 设备端转写 + 实时反馈 + 深度报告，自带 API Key）"
  homepage "https://github.com/gudi565/fluentspeech"

  # ad-hoc 签名 → Homebrew 默认带隔离属性 → 首次打开会被 Gatekeeper 拦。caveats 提示用户。
  caveats <<~EOS
    流畅对话为 ad-hoc 签名（未经 Apple 公证），仅支持 Apple Silicon（arm64）。
    首次打开前请剥离隔离属性，否则会被 Gatekeeper 拦截：

      xattr -cr /Applications/FluentSpeech.app

    或安装时直接加 --no-quarantine：

      brew install --cask --no-quarantine fluentspeech
  EOS

  app "FluentSpeech.app"

  # 卸载时清理（brew uninstall --cask --zap）。
  zap trash: [
    "~/Library/Application Support/FluentSpeech",
    "~/Library/Preferences/com.fluentspeech.app.plist",
    "~/Library/Caches/com.fluentspeech.app",
  ]
end
