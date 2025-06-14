#!/usr/bin/env bash

# Clone a web page including all assets
function clone_page() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <URL>"
        exit 1
    fi

    local url="$1"
    local output_dir="cloned_page"

    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"

    # Use wget to clone the page
    wget --mirror --convert-links --adjust-extension --page-requisites --no-parent -P "$output_dir" "$url"

    echo "Page cloned to $output_dir"
}

# Install as default nginx page
function install_nginx_page() {
    local url="$1"
    if [ -z "$url" ]; then
        echo "Usage: $0 <URL>"
        exit 1
    fi

    clone_page "$url"

    sudo cp -r cloned_page/* /var/www/html/

    # Restart nginx to apply changes
    sudo systemctl restart nginx

    echo "Nginx default page updated with cloned content from $url"
}

install_nginx_page https://ks32.dev/
