# Roblox Anti-Cheat System

An anticheat I scripted for a game project.
---

## Features
- It can detect speed hacks, jumping hacks, UI removal (tampering alerts included), 
  a tool injection guard, flying monitering, client-server communication checks and auto-
  mates a kick or flag when violation is detected.

### Important Notes

- The Server script watches the behavior of the players and the explots. 
- The Client script sends the state of the player for server checks.
- Remote Event handles client and server reporting. 
- All important detection goes on in the server. Client scripts just detect local tampers like UI and/or scripts.
