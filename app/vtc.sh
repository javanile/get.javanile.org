#!/bin/sh

BINARY_URL="https://raw.githubusercontent.com/javanile/vtiger-client/test/bin/vtc.phar"
BINARY_NAME="vtc"

echo "Checking PHP..."

if ! command -v php >/dev/null 2>&1; then
    echo "Error: PHP is not installed or not in PATH."
    echo "Please install PHP and retry."
    exit 1
fi

PHP_VERSION=`php -v 2>/dev/null | head -n 1`
echo "PHP found: $PHP_VERSION"

# Detect install directory
if [ "`id -u`" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
    echo "Running as root (sudo detected)."
else
    if [ -d "$HOME/.local/bin" ]; then
        INSTALL_DIR="$HOME/.local/bin"
    else
        INSTALL_DIR="$HOME/bin"
        if [ ! -d "$INSTALL_DIR" ]; then
            mkdir -p "$INSTALL_DIR" || {
                echo "Error: Cannot create $INSTALL_DIR"
                exit 1
            }
        fi
    fi
fi

echo "Installing $BINARY_NAME to $INSTALL_DIR"

TMP_FILE="${TMPDIR:-/tmp}/${BINARY_NAME}.tmp.$$"

# Download
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$BINARY_URL" -o "$TMP_FILE" || {
        echo "Download failed."
        exit 1
    }
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TMP_FILE" "$BINARY_URL" || {
        echo "Download failed."
        exit 1
    }
else
    echo "Error: neither curl nor wget is installed."
    exit 1
fi

chmod +x "$TMP_FILE" || {
    echo "Error: cannot make binary executable."
    rm -f "$TMP_FILE"
    exit 1
}

mv "$TMP_FILE" "$INSTALL_DIR/$BINARY_NAME" || {
    echo "Error: cannot move binary to $INSTALL_DIR"
    rm -f "$TMP_FILE"
    exit 1
}

echo "Installation complete."

# PATH warning only for non-root installs
if [ "`id -u`" -ne 0 ]; then
    case ":$PATH:" in
        *":$INSTALL_DIR:"*)
            echo "$INSTALL_DIR is already in PATH."
            ;;
        *)
            echo ""
            echo "Warning: $INSTALL_DIR is not in your PATH."
            echo "Add this line to your shell profile (~/.profile, ~/.shrc, ~/.bashrc, etc.):"
            echo ""
            echo "export PATH=\"$INSTALL_DIR:\$PATH\""
            echo ""
            ;;
    esac
fi

echo ""
echo "Run:"
echo "  $BINARY_NAME --help"
echo ""
