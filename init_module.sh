#!/bin/bash
# Usage: ./init_module.sh chapter1_prompt_chaining

set -e

MODULE_DIR="$1"
PY_VERSION=$(pyenv version-name)

if [ -z "$MODULE_DIR" ]; then
  echo "❌ Bitte gib ein Modulverzeichnis an."
  exit 1
fi

mkdir -p "$MODULE_DIR"
cd "$MODULE_DIR"

# 1. Echte venv erstellen
python -m venv .venv

# 2. direnv aktivieren mit klassischem venv
echo 'source .venv/bin/activate' > .envrc
direnv allow

# 3. requirements.txt (optional Beispiel)
if [ ! -f requirements.txt ]; then
  echo "# Beispielpakete" > requirements.txt
  echo "requests" >> requirements.txt
fi

# 4. Pakete installieren
source .venv/bin/activate
pip install -r requirements.txt

# 5. VSCode settings.json
mkdir -p .vscode
cat <<EOF > .vscode/settings.json
{
  "python.defaultInterpreterPath": "\${workspaceFolder}/.venv/bin/python"
}
EOF

echo "✅ Modul '$MODULE_DIR' initialisiert mit echter venv"
echo "🧠 VSCode erkennt nun automatisch die Umgebung"
