# dude
[![Build Status](https://travis-ci.org/sweeperio/chef-dude.svg?branch=master)](https://travis-ci.org/sweeperio/chef-dude)

Installs and configures [dude].

[dude]: https://github.com/sweeperio/dude

## What This Does

* Creates/enables a runit service for [dude]
* Sets the service to run as `node["dude"]["run_as_user"]` (via `chpst`)

_**This cookbook does not clone the repo or handle deployment**_. That is done via capistrano in [dude]. The cap process will restart the service on successful deploys

## Attributes

Attribute|Description|Default
---------|-----------|-------
`node["dude"]["run_as_user"]` | The user to run the service as (via `chpst`) | `dude`
`node["dude"]["install_dir"]` | The folder containing the application. This should generally be `[capistrano's deploy_to]/current` | `/home/dude/service/current`
