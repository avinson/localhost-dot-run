#!/usr/bin/dumb-init /bin/sh

# Set up key file
KEY_FILE=${SSH_KEY_FILE:=/root/.ssh/autossh_id_rsa}
if [ ! -f "${KEY_FILE}" ]; then
    echo "[INFO] Generating autossh_id_rsa..."
    ssh-keygen -t rsa -b 4096 -C "autossh" -f root/.ssh/autossh_id_rsa -q -N ""
fi
eval $(ssh-agent -s)
cat "${SSH_KEY_FILE}" | ssh-add -k -

# Determine command line flags
INFO_TUNNEL_SRC="${SSH_HOSTUSER:=root}@${SSH_HOSTNAME}:${SSH_TUNNEL_REMOTE:=${DEFAULT_PORT}}"
INFO_TUNNEL_DEST="${SSH_TUNNEL_HOST:=localhost}:${SSH_TUNNEL_LOCAL:=22}"
COMMAND="autossh "\
"-M 0 "\
"-o StrictHostKeyChecking=no "\
"-o ServerAliveInterval=10 "\
"-o ServerAliveCountMax=3 "\
"-o ExitOnForwardFailure=yes "\
"-t -t "\
"-R ${SSH_TUNNEL_REMOTE}:${SSH_TUNNEL_HOST}:${SSH_TUNNEL_LOCAL} "\
"-p ${SSH_HOSTPORT:=22} "\
"${SSH_HOSTUSER}@${SSH_HOSTNAME}"

# Log to stdout
echo "[INFO] Using $(autossh -V)"
echo "[INFO] Tunneling ${INFO_TUNNEL_SRC} to ${INFO_TUNNEL_DEST}"
echo "> ${COMMAND}"

# Run command
AUTOSSH_PIDFILE=/autossh.pid \
AUTOSSH_POLL=30 \
AUTOSSH_GATETIME=30 \
AUTOSSH_FIRST_POLL=30 \
AUTOSSH_LOGLEVEL=0 \
AUTOSSH_LOGFILE=/dev/stdout \
exec ${COMMAND}