require "jekyll"
require "jekyll-optional-front-matter-collection/generator"

module JekyllOptionalFrontMatterCollection
  FILENAME_BLACKLIST = %w(
    README
    LICENSE
    LICENCE
    COPYING
    CODE_OF_CONDUCT
    CONTRIBUTING
    ISSUE_TEMPLATE
    PULL_REQUEST_TEMPLATE
  ).freeze
end