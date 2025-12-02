# ubiquitous-octo-goggles
test codespaces
## To Get Git to Work with SSH

### WSL Setup
Add the following to your `.bashrc` (or shell config) to start the SSH agent and add your key:

```bash
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
eval $(ssh-agent -a $SSH_AUTH_SOCK) >/dev/null
ssh-add ~/.ssh/id_ed25519
```
### devcontainer.json
In your devcontainer.json, forward the SSH agent so the container can use your keys:
```json
	"mounts": [
    	"source=${localEnv:SSH_AUTH_SOCK},target=/ssh-agent,type=bind"
 	 ],
	"remoteEnv": {
		"SSH_AUTH_SOCK": "/ssh-agent"
	},
	"postStartCommand": [
		"sh",
		"-c",
		"ssh-add -l || echo 'No SSH keys found in agent'; git config --global gpg.format ssh; git config --global user.signingkey \"$(ssh-add -L | head -n1)\"; git config --global commit.gpgsign true"
	]
```