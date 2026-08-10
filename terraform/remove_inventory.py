import argparse
from pathlib import Path

parser = argparse.ArgumentParser()

parser.add_argument("--inventory", required=True)
parser.add_argument("--hostname", required=True)

args = parser.parse_args()

inventory_path = Path(args.inventory)

content = inventory_path.read_text()

lines = content.splitlines()

# Remove the host entry
lines = [
    line
    for line in lines
    if not line.startswith(f"{args.hostname} ")
]

# Remove excessive blank lines
cleaned_lines = []

for line in lines:
    if line.strip() == "" and (
        not cleaned_lines or cleaned_lines[-1].strip() == ""
    ):
        continue

    cleaned_lines.append(line)

inventory_path.write_text("\n".join(cleaned_lines) + "\n")

print(
    f"Removed {args.hostname} from {inventory_path}"
)