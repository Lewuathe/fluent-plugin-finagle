# Fluent Input Plugin for Finagle metric
[![Gem](https://img.shields.io/gem/v/fluent-plugin-finagle.svg)](https://rubygems.org/gems/fluent-plugin-finagle)
======================================

# Usage

```yaml
<source>
  @type finagle

  finagle_host exmaple.com
  finagle_port 9990
  metrics ['finagle/clientregistry/size', 'finagle/timer/pending_tasks.sum']
  run_interval 10
</source>
```

Finagle input plugin forwards selected metrics along replacement of slash '/' with underscore '_'.

# Build

```
$ bundle exec gem build fluent-plugin-finagle.gemspec
```
