## Self-made Docker image

1. Build image from this repo

        git clone https://github.com/DmitrySandalov/docker-zoom.git
        cd docker-zoom
        docker build -t zoom .

2. Start Zoom:

        docker run --net=host --name zoom -d -e DISPLAY=$DISPLAY --device /dev/video0:/dev/video0 -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/`id -u`/pulse:/run/pulse zoom

3. Stop Zoom:

        docker stop zoom; docker rm -v zoom

### Notes

* Note 1. To set up a proxy server, modify the file `conf/zoomus.conf` and rebuild the image

https://zoom.us/

https://support.zoom.us/hc/en-us/articles/204206269-Getting-Started-on-Linux


## obs-studio

```
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [
      (pkgs.linuxPackages_latest.v4l2loopback.overrideAttrs ({ ... }: {
        src = pkgs.fetchFromGitHub {
          owner = "umlaeute";
          repo = "v4l2loopback";
          # master 2020-04-17
          rev = "10b1c7e6bda4255fdfaa187ce2b3be13433416d2";
          sha256 = "0xsn4yzj7lwdg0n7q3rnqpz07i9i011k2pwn06hasd45313zf8j2";
        };
      }))
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label="obs"
    '';
  };
}
```

```
nix-build . -A obs-v4l2sink -A obs-studio
```

```
ln -s $(realpath ./result)/share/obs/obs-plugins/v4l2sink/ ~/.config/obs-studio/plugins/v4l2sink
```

```
./result-2/bin/obs
```
