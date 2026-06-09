#!/usr/bin/env bash

previewDirectory() {
    if command -v eza >/dev/null 2>&1; then
        eza -lah --color=always -- "$1"
        return
    fi

    ls -oAh --color=always -- "$1"
}

previewText() {
    batArgs=(
        --style=numbers
        --color=always
        --pager=never
    )

    if command -v bat >/dev/null 2>&1; then
        bat \
            "${batArgs[@]}" \
            -- "$1"
        return
    fi

    if command -v batcat >/dev/null 2>&1; then
        batcat \
            "${batArgs[@]}" \
            -- "$1"
        return
    fi

    cat -- "$1"
}

previewImage() {
    if ! command -v kitty >/dev/null 2>&1; then
        echo "Kitty is required for image previews."
        return
    fi

    kitty +kitten icat \
        --clear \
        --transfer-mode=memory \
        --stdin=no \
        --place "${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" \
        -- "$1"
}

previewFile() {
    local mime
    mime=$(file --mime-type -Lb "$1")

    case "$mime" in
    image/*)
        previewImage "$1"
        ;;
    *)
        previewText "$1"
        ;;
    esac
}

file="$1"
if [[ -d "$file" ]]; then
    previewDirectory "$file"
elif [[ -f "$file" ]]; then
    previewFile "$file"
else
    exit 1
fi
