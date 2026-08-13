#!/usr/bin/env python3

import argparse
import re
from pathlib import Path


def remove_host(lines, hostname, ip):
    """
    Remove existing inventory entries matching either:
      - hostname
      - ansible_host=IP
    """

    result = []

    for line in lines:
        stripped = line.strip()

        # Keep comments and blank lines
        if not stripped or stripped.startswith("#"):
            result.append(line)
            continue

        # Only inspect actual inventory host lines
        if (
            re.search(rf"^{re.escape(hostname)}(?:\s|$)", stripped)
            or re.search(rf"\bansible_host={re.escape(ip)}(?:\s|$)", stripped)
        ):
            continue

        result.append(line)

    return result


def ensure_group(lines, group):
    """
    Make sure [group] exists.
    Returns:
        updated lines
        index of the group header
    """

    header = f"[{group}]"

    for i, line in enumerate(lines):
        if line.strip() == header:
            return lines, i

    # Group doesn't exist → create it at the end
    if lines and lines[-1].strip():
        lines.append("\n")

    lines.append(f"{header}\n")

    return lines, len(lines) - 1


def add_host(lines, group, hostname, ip, user):
    """
    Add host underneath the specified group.
    """

    lines, group_index = ensure_group(lines, group)

    host_line = f"{hostname} ansible_host={ip}"

    if user:
        host_line += f" ansible_user={user}"

    host_line += "\n"

    # Find the end of the group
    insert_at = group_index + 1

    while insert_at < len(lines):
        stripped = lines[insert_at].strip()

        if stripped.startswith("["):
            break

        insert_at += 1

    # Remove trailing blank lines from the group area
    while insert_at > group_index + 1 and not lines[insert_at - 1].strip():
        insert_at -= 1

    lines.insert(insert_at, host_line)

    return lines


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument("--inventory", required=True)
    parser.add_argument("--group", required=True)
    parser.add_argument("--hostname", required=True)
    parser.add_argument("--ip", required=True)
    parser.add_argument("--user", default="")

    args = parser.parse_args()

    inventory = Path(args.inventory)

    if inventory.exists():
        lines = inventory.read_text().splitlines(keepends=True)
    else:
        lines = []

    # 1. Remove old hostname/IP entry
    lines = remove_host(
        lines,
        args.hostname,
        args.ip,
    )

    # 2. Create group if necessary
    # 3. Add the new host
    lines = add_host(
        lines,
        args.group,
        args.hostname,
        args.ip,
        args.user,
    )

    inventory.write_text("".join(lines))

    print(
        f"Inventory updated: "
        f"{args.hostname} -> {args.ip} [{args.group}]"
    )


if __name__ == "__main__":
    main()