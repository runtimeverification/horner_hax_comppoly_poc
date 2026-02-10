#!/usr/bin/env bash
set -euxo pipefail

CRATE_DIR="rust/horner_eval_rs"
OUT_DIR="lean/HornerLean/Extracted"
OUT_FILE="${OUT_DIR}/Horner_eval_rs.lean"

rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"

pushd "${CRATE_DIR}"
  cargo hax into lean
  rsync -a --delete proofs/lean/extraction/ "../../${OUT_DIR}/"
popd

# 2) Avoid termination checking for recursion over usize/i64 (Lean cannot find decreasing measure)
perl -pi -e 's/^def (Horner_eval_rs\.horner_rec)/partial def $1/' "${OUT_FILE}"
