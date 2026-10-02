source "https://mirrors.tuna.tsinghua.edu.cn/rubygems/"

# GitHub Pages 兼容依赖（与 remote_theme 搭配）
# 本地预览: bundle exec jekyll serve
gem "github-pages", "~> 232", group: :jekyll_plugins

# Minimal Mistakes remote_theme 需要
gem "jekyll-include-cache", group: :jekyll_plugins

# Ruby 3+ 本地 serve 需要
gem "webrick", "~> 1.8"

# 避免解析到 activesupport 8（会强制编译 bigdecimal 4）
gem "activesupport", ">= 6.0", "< 8.0"

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1", :platforms => [:mingw, :x64_mingw, :mswin]

gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
