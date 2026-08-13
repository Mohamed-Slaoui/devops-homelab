#!/usr/bin/env python3

import argparse
import re
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument("--inventory", required=True)
    parser.add_argument("--hostname", required=True)

    args = parser.parse_args()

    inventory = Path(args.inventory)

    if not inventory.exists():
        print("Inventory does not exist. Nothing to remove.")
        return

    lines = inventory.read_text().splitlines(keepends=True)

    result = []

    pattern = re.compile(
        rf"^{re.escape(args.hostname)}(?:\s|$)"
    )

    for line in lines:
        if pattern.match(line.strip()):
            continue

        result.append(line)

    inventory.write_text("".join(result))

    print(f"Removed {args.hostname} from inventory.")


if __name__ == "__main__":
    main()