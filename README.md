# mounts cryfs at /opt/.exports and shares it via cifs/nfs

```bash
docker run -d -ti --privileged \
-v /path/to/encrypted/folder:/.exports:rw voobscout/cryfs-share <cryfs_password>

```
Bind your own "/etc/samba/smb.conf" and/or "/etc/exports" into this container if additional shares are required
> Don't forget to add the defaults from provided files.

The unencrypted contents are accessible by:

NFS:
sudo mount <docker-machine-IP>:/exports /path/of/your/choosing

CIFS:
sudo mount //<docker-machine-IP>/exports /path/of/your/choosing -o username=cryfs -o password=samba123

> **Bug** Only root can write to cifs mountpoint on client
