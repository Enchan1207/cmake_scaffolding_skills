#!/usr/bin/env bash

set -euo pipefail

skill_name=cmake-scaffold

script_dir="$(dirname "$(realpath "$0")")"
cmake_skill_dir="${script_dir}/skills/${skill_name}"

if [[ -z "${CODEX_HOME:-}" ]]; then
    skills_install_dir="${HOME}/.agents/skills"
else
    skills_install_dir="${CODEX_HOME}/skills"
fi

skill_link="${skills_install_dir}/${skill_name}"

if [[ ! -e "$skill_link" && ! -L "$skill_link" ]]; then
    echo "Not installed: $skill_link"
    exit 0
fi

if [[ ! -L "$skill_link" || "$(readlink "$skill_link")" != "$cmake_skill_dir" ]]; then
    echo "Install destination is not a link to this skill: $skill_link" >&2
    exit 1
fi

rm -- "$skill_link"
echo "Uninstalled: $skill_link"
