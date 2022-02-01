# docker for remote backup
This docker image is intended to download a remote set of files and delete them if required.

To run it, some set of environment options required to be filled:
REMOTE_HOST;
REMOTE_DIR;
DELETE_REMOTE - only if you need to delete remote files after sync.
Take a look below at an example to get more details.

In addition, a couple of files should be shared with an instance:
- /tmp/dst:/dst - where the first part should point to the destination folder on the docker node;
- /home/test/.ssh/id_rsa:/home/jobberuser/.ssh/id_rsa - the first part is the path to your ssh private key, it must be passwordless.

By default, the script is running hourly, but that might be changed by the edition the `time` string in `jobfile`. It has the same format as cron. Just in case, here are the official jobber docs.

And last but not least, the remote server must have Rsync installed, and I highly recommend using a separate user on the remote server, just in case of misconfiguration.

## Examples

### Build
```shell
$ docker build . -t welante-remote-backup
```

### Run in interactive mode, e.g. for testing
```shell
$ docker run \
-e REMOTE_HOST="test@host"  \
-e REMOTE_DIR="/home/test/src/" \
-e DELETE_REMOTE=1 \
-v /tmp/dst:/dst \
-v /home/test/.ssh/id_rsa:/home/jobberuser/.ssh/id_rsa \
--rm -ti welante-remote-backup:latest
```
