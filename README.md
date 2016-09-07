Fluent Input Plugin for Finagle metric
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
