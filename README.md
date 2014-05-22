# rootbuilder

This is a Docker build environment container for buildroot. You can use this container to produce a root fielsystem tar that you can use for building BusyBox containers from scratch. See the example directory for how you'd normally use rootbuilder.

## Using rootbuilder

The rootbuilder container is just a pre-setup build environment with a ready-to-go buildroot directory. Using this, you can put together an easy workflow to configure and build a rootfs. 

As you can see in the example directory, the Dockerfile is used to make buildroot using a configuration file. The Makefile gives you your main workflow tasks. The `config` task just runs `make nconfig` in rootbuild and pulls out the `.config` file. The `build` task then executes docker build from the Dockerfile, which uses the configuration file, resulting in a container that will have a rootfs artifact that the build task extracts.

In other words, you can copy the example directory as a directory in your project, then in it run:

	$ make config

And you'll get an interactive menu to define a buildroot configuration. The configuration will get stored in that directory and used when you run:

	$ make build

Which will take forever to run, but ultimately put a `rootfs.tar` in the directory. And all the messy stuff happens inside Docker.

## Credit

This project is inspired by the [tarmakers](https://github.com/radial/core-busyboxplus) by [Brian Clements](https://github.com/brianclements), itself inspired by the original tarmaker work of the venerable [Jérôme Petazzoni](https://github.com/jpetazzo).

## Sponsor

This project was made possible thanks to [DigitalOcean](http://digitalocean.com).

## License

BSD