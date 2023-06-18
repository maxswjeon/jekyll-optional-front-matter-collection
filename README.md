# Jekyll Optional Front Matter - Collections

A Jekyll plugin to make front matter optional for collection documents

## What it does

Out of the box, Jekyll requires that any markdown file have YAML front matter (key/value pairs separated by two sets of three dashes) in order to be processed and converted to HTML.

While that behavior may be helpful for large, complex sites, sometimes it's easier to simply add a plain markdown file and have it render without fanfare.

This plugin does just that. Any Markdown file in your site's source will be treated as a Page and rendered as HTML, even if it doesn't have YAML front matter.

## Usage

1.  Add the following to your site's `Gemfile`:

    ```ruby
    group :jekyll_plugins do
      gem 'jekyll-optional-front-matter-collections'
    end
    ```

2.  Install the plugin

    - Using Bundler:

          ```bash
          bundle install
          ```

    - Using Gem:

            ```bash
            # Install in your user's home directory.
            gem install --user-install jekyll-optional-front-matter-collections

            # Install for root user.
            sudo gem install jekyll-optional-front-matter-collections
            ```

    Note: If you are using a Jekyll version less than 3.5.0, use the gems key instead of plugins.

## Configuration

You can configure this plugin in `_config.yml` by adding to the `optional_front_matter_collection` key.

### Enable for specific collections

The plugin is only enabled for collections that are listed in the `collections` key. By default, it is enabled for all collections. To enable it for specific collections, add the following to your site's config:

```yml
optional_front_matter_collection:
  collections:
    - my_collection
    - my_other_collection
```

### Removing originals

By default the original markdown files will be included as static pages in the output. To remove them from the output, set the `remove_originals` key to `true`:

```yml
optional_front_matter_collection:
  remove_originals: true
```

### Disabling

Even if the plugin is enabled (e.g., via the `:jekyll_plugins` group in your Gemfile) you can disable it by adding the following to your site's config:

```yml
optional_front_matter_collection:
  enabled: false
```

## Special thanks to

This plugin is based on [benbalter/jekyll-optional-front-matter](https://github.com/benbalter/jekyll-optional-front-matter). Most of the sources are copied from the original repository.
