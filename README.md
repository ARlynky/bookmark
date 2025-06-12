# BOOKMARK

## ❌ Archived

This project is **archived for now**, as I’ve run into a few limitations that
are either impossible to solve cleanly **with my current toolset**
or would make the project unnecessarily clunky.

I may return to it in the future with better tools or new ideas.

---

## Problems I Faced

### 1. Can't Mark the User's Actual Directory

This script uses:

```python
Path.cwd()
```

to get the current working directory.  
However, the runner script in `.local/bin/` calls:

```bash
cd "$HOME/.local/share/bookmark"
exec python3 bookmark.py "$@"
```

That means the working directory seen by Python is always:

```bash
~/.local/share/bookmark
```

So marking a directory just bookmarks the tool’s own directory -
not where the user *actually* ran the command from.

I could fix this by requiring the user to input the path manually,
but that defeats the point.  
Marking a specific path *should be optional*, not mandatory.

---

### 2. Can’t Actually Change Directory (`--goto`)

Even if I store the correct path, there’s no clean way for
a Python script (or any child process) to change
the **parent shell’s** directory.  
So running:

```bash
bookmark --goto dev
```

doesn’t actually move the user’s terminal to that location.

I tried workarounds like helper scripts (`goto.sh`)
that output the path or `cd` command, which you could wrap in `$(...)`
but those are:

- External
- Hacky
- Not integrated into the main tool

It works, *technically*, but it’s not clean. And I want my tools to be clean.

---

## Original README (Preserved)

> This repo is for **personal use** and not intended for
public consumption (yet!)  
> I’m using it to learn how to share CLI tools and packages like a real developer.

A script that allows you to add, remove, list, and of course *goto* marked
terminal directories.

---

## 🛠 Installation

> ⚠️ Only works on **Linux-based systems** (for now)

To install:

```bash
curl -sSL https://raw.githubusercontent.com/ARlynky/bookmark/main/install.sh | bash
```

This will:

- Clone the repo to `~/.local/share/bookmark/`
- Add a launcher to `~/.local/bin/bookmark`
- Let you run `bookmark` from anywhere (if `~/.local/bin` is in your `PATH`)

---

## Updating

You can re-run the install script to update either from:

- The repo (`~/.local/share/bookmark/install.sh`)
- Or from the web again

> ⚠️ This will reset your bookmarks.

---

### 📦 Status

Archived — might return later when I'm stronger.
