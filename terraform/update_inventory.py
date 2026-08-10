import argparse
from pathlib import Path

parser = argparse.ArgumentParser()

parser.add_argument("--inventory", required=True)
parser.add_argument("--group", required=True)
parser.add_argument("--hostname", required=True)
parser.add_argument("--ip", required=True)
parser.add_argument("--user", required=True)

args = parser.parse_args()

inventory_path = Path(args.inventory)

content = inventory_path.read_text()

new_host = (
    f"{args.hostname} "
    f"ansible_host={args.ip} "
    f"ansible_user={args.user}"
)

lines = content.splitlines()

# Remove existing entry for this hostname
lines = [
    line for line in lines
    if not line.startswith(f"{args.hostname} ")
]

# Find the requested group
group_header = f"[{args.group}]"

for i, line in enumerate(lines):
    if line.strip() == group_header:

        insert_at = i + 1

        # Find the first blank line or next group
        while insert_at < len(lines):
            if lines[insert_at].strip() == "":
                break

            if lines[insert_at].startswith("["):
                break

            insert_at += 1

        # Insert directly before the blank line
        lines.insert(insert_at, new_host)

        break

else:
    raise SystemExit(
        f"ERROR: Inventory group '{args.group}' was not found."
    )

# Clean up excessive blank lines
cleaned_lines = []

for line in lines:
    if line.strip() == "" and (
        not cleaned_lines or cleaned_lines[-1].strip() == ""
    ):
        continue

    cleaned_lines.append(line)

inventory_path.write_text(
    "\n".join(cleaned_lines) + "\n"
)

print(
    f"Updated {inventory_path}: "
    f"{args.hostname} -> [{args.group}]"
)