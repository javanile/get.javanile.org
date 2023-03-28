
-include .env
export $(shell test -f .env && cut -d= -f1 .env)

## ======
## Remote
## ======

remote-init:
	@sshpass -p $${REMOTE_PASSWORD} scp -P $${REMOTE_PORT:-22} contrib/remote-*.sh $${REMOTE_USER}@${REMOTE_HOST}:/tmp/

remote-bash:
	@sshpass -p $${REMOTE_PASSWORD} ssh $${REMOTE_USER}@${REMOTE_HOST} -p $${REMOTE_PORT:-22} -T bash /tmp/remote-bash.sh

remote-sudo-bash: remote-init
	@sshpass -p $${REMOTE_PASSWORD} ssh $${REMOTE_USER}@${REMOTE_HOST} -p $${REMOTE_PORT:-22} -T bash /tmp/remote-sudo-bash.sh "$${REMOTE_PASSWORD}"

## =====
## Tests
## =====

test-docker-remote:
	@cat app/docker.sh | make -s remote-sudo-bash
