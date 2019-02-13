qemu-system-ppc64 -machine pseries -cpu power9 -nodefaults -nographic -serial stdio -hda $image_path -net nic -net tap,ifname=tap0,script=no
