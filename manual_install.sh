#!/usr/bin/env bash

set -euo pipefail

# This script is recommended for maintenance purposes only.

skill_name=cmake-scaffold

script_dir="$(dirname "$(realpath "$0")")"
cmake_skill_dir="${script_dir}/skills/${skill_name}"

if [[ ! -f "${cmake_skill_dir}/SKILL.md" ]]; then
    echo "Skill not found: ${cmake_skill_dir}/SKILL.md" >&2
    exit 1
fi

# Use the user skills directory unless a Codex home is specified.
if [[ -z "${CODEX_HOME:-}" ]]; then
    skills_install_dir="${HOME}/.agents/skills"
else
    skills_install_dir="${CODEX_HOME}/skills"
fi

mkdir -p "$skills_install_dir"
skill_link="${skills_install_dir}/${skill_name}"

if [[ -L "$skill_link" && -e "$skill_link" && "$(realpath "$skill_link")" == "$cmake_skill_dir" ]]; then
    echo "Already installed: $skill_link"
    exit 0
fi

if [[ -e "$skill_link" || -L "$skill_link" ]]; then
    echo "Install destination already exists: $skill_link" >&2
    exit 1
fi

ln -s "$cmake_skill_dir" "$skill_link"
echo "Installed: $skill_link"
