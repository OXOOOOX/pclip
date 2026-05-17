# pclip

Pipe text from an SSH session into the local Linux desktop clipboard.

## What

`pclip` reads stdin and writes it to the Linux desktop clipboard — even when
you're connected via SSH from another machine. Copy text on your remote client
(Windows, macOS, another Linux box), paste it into the SSH terminal, press
Ctrl+D, and it lands on the Linux desktop clipboard ready to paste anywhere.

## Why

SSH sessions don't inherit `WAYLAND_DISPLAY` or `DISPLAY`, so clipboard tools
fail. `pclip` auto-detects the running display server (Wayland → X11) and sets
the required environment variables before calling the right backend.

## Install

```bash
sudo curl -o /usr/local/bin/pclip https://raw.githubusercontent.com/OXOOOOX/pclip/main/pclip
sudo chmod +x /usr/local/bin/pclip
```

Requires one of: `wl-clipboard` (Wayland), `xclip`, or `xsel` (X11).

```bash
sudo apt install -y wl-clipboard
```

## Usage

**Interactive (paste from remote):**
```bash
pclip
# paste text now, then press Ctrl+D
```

**Piped:**
```bash
echo "hello" | pclip
cat config.txt | pclip
```

**From Windows PowerShell (SSH to Linux):**
```
ssh user@linux-box
pclip
# paste your Windows clipboard content, then Ctrl+D
# now switch to Linux desktop — text is on the clipboard
```

## Backends (tried in order)

1. `wl-copy` — Wayland (preferred)
2. `xclip -selection clipboard` — X11
3. `xsel --clipboard --input` — X11 fallback

## License

MIT
