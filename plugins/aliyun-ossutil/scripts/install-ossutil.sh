#!/usr/bin/env bash
set -euo pipefail

OSSUTIL_VERSION="2.3.0"
OSSUTIL_DOWNLOAD_BASE="https://gosspublic.alicdn.com/ossutil/v2/${OSSUTIL_VERSION}"
CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/ossutil-plugin/${OSSUTIL_VERSION}"
CACHE_BIN="${CACHE_DIR}/ossutil"

log() { printf 'ossutil: %s\n' "$*" >&2; }

sha256_of_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    sha256sum "$1" | awk '{print $1}'
  fi
}

zip_sha256_for() {
  case "$1" in
    mac-arm64) echo "058fd048f321f8c80def8b748030531646eefe3a82837bf16b581ba7d9c84ac7" ;;
    mac-amd64) echo "8437fdd3ef1a3eb12310f61fcf1c00a5bff5cdab47b4fea815527472e7cf896c" ;;
    linux-amd64) echo "3ae4d9fc85a7a6e9f5654d1599766f1a3a42a3692870887b5ae9338d582ef65a" ;;
    linux-arm64) echo "f6c95ba0c2d2ef30290af686ce4d706c701f4734ce8090bee4288a77e3f1d764" ;;
    linux-arm) echo "8aff883c676961a11c89ac98b807fafa54fb424851d0547b1691b9d320324b9e" ;;
    linux-386) echo "29cbd49b6c401c740c2f036cdf9d44ee8da340b16bdb3be71a33bcbebbe35ec5" ;;
    *) return 1 ;;
  esac
}

download_case() {
  case "$(uname -s)/$(uname -m)" in
    Darwin/arm64) echo "mac-arm64" ;;
    Darwin/x86_64) echo "mac-amd64" ;;
    Linux/aarch64|Linux/arm64) echo "linux-arm64" ;;
    Linux/arm|Linux/armv6l|Linux/armv7l) echo "linux-arm" ;;
    Linux/i386|Linux/i686) echo "linux-386" ;;
    Linux/x86_64|Linux/amd64) echo "linux-amd64" ;;
    *) return 1 ;;
  esac
}

extract_zip() {
  local zip_path="$1" workdir extracted
  workdir="$(mktemp -d)"
  if command -v unzip >/dev/null 2>&1; then
    (cd "${workdir}" && unzip -q "${zip_path}")
  elif command -v python3 >/dev/null 2>&1; then
    (cd "${workdir}" && python3 -c 'import sys, zipfile; zipfile.ZipFile(sys.argv[1]).extractall()' "${zip_path}")
  else
    rm -rf "${workdir}"
    log "need unzip or python3 to extract the ossutil archive"
    return 1
  fi
  extracted="$(find "${workdir}" -name ossutil -type f | head -1)"
  if [[ -z "${extracted}" ]]; then
    rm -rf "${workdir}"
    log "ossutil binary not found inside the archive"
    return 1
  fi
  mkdir -p "${CACHE_DIR}"
  mv "${extracted}" "${CACHE_BIN}"
  chmod 755 "${CACHE_BIN}"
  rm -rf "${workdir}"
}

ensure_installed() {
  if [[ -x "${CACHE_BIN}" ]]; then
    return 0
  fi
  local plat zip_name expected_sha zip_path
  plat="$(download_case)" || { log "unsupported platform: $(uname -s)/$(uname -m)"; return 1; }
  zip_name="ossutil-${OSSUTIL_VERSION}-${plat}.zip"
  expected_sha="$(zip_sha256_for "${plat}")"
  if [[ -z "${expected_sha}" ]]; then
    log "no checksum listed for ${zip_name}"
    return 1
  fi
  mkdir -p "${CACHE_DIR}"
  zip_path="${CACHE_DIR}/${zip_name}"
  log "downloading ${zip_name} to ${CACHE_DIR} ..."
  if ! curl -fsSL "${OSSUTIL_DOWNLOAD_BASE}/${zip_name}" -o "${zip_path}"; then
    rm -f "${zip_path}"
    return 1
  fi
  if [[ "$(sha256_of_file "${zip_path}")" != "${expected_sha}" ]]; then
    rm -f "${zip_path}"
    log "checksum mismatch for ${zip_name}; removed the corrupted download"
    return 1
  fi
  extract_zip "${zip_path}" || return 1
  rm -f "${zip_path}"
  log "installed ossutil ${OSSUTIL_VERSION} to ${CACHE_BIN}"
}

ensure_installed
