import argparse
import json
from pathlib import Path


def mark(data_file, data, name):
    current_dir = str(Path.cwd())
    data[name] = current_dir
    with open(data_file, "w") as f:
        json.dump(data, f, indent=4)
    print("Current directory bookmarked successfully")


def listing(bookmarks):
    if len(bookmarks) == 0:
        print("nothing bookmarked")
    else:
        for name, path in bookmarks.items():
            print(name, ": ", path)


def empty(data_file):
    with open(data_file, "w") as f:
        f.write("{}")


def remove(data_file, data, name):
    if name in data:
        del data[name]
        with open(data_file, "w") as f:
            json.dump(data, f, indent=4)
        print("Bookmark removed successfully")
    else:
        print("Bookmark not found")


def goto(data, name):
    if name in data:
        path = data[name]
        print(path)
        # subprocess.run(["bash", "goto.sh", path])
    else:
        print("Bookmark not found")


def main():
    parser = argparse.ArgumentParser(
        description="Bookmark manager for terminal directory"
    )
    parser.add_argument("--mark", help="Bookmark current directory")
    parser.add_argument("--list", help="List all bookmarks", action="store_true")
    parser.add_argument("--empty", help="Empty bookmarks", action="store_true")
    parser.add_argument("--remove", help="Remove a bookmark by name")
    parser.add_argument("--goto", help="Goto a directory by name")

    args = parser.parse_args()

    data_file = "data.json"

    with open(data_file, "r") as f:
        bookmarks = json.load(f)

    if args.mark:
        mark(data_file, bookmarks, args.mark)

    if args.list:
        listing(bookmarks)

    if args.empty:
        empty(data_file)

    if args.remove:
        remove(data_file, bookmarks, args.remove)


if __name__ == "__main__":
    main()
