ln -fs ${HOME}/code/osx-tilde-key.plist ${HOME}/Library/LaunchAgents

launchctl enable gui/$UID/net.insignificancegalore.osx-tilde-key
launchctl kickstart gui/$UID/net.insignificancegalore.osx-tilde-key

