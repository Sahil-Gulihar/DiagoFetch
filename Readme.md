# Custom Neofetch Utility

This script is a customized version of the popular `neofetch` utility. It displays system information alongside a custom ASCII art image with specified colors.

## Features

- **Custom Image**: Converts a specified image to ASCII art.
- **Custom Colorscheme**: Allows customization of text and ASCII art colors.
- **System Information**: Displays various system details such as OS, distro, kernel, CPU, GPU, memory, disk usage, uptime, shell, resolution, terminal, and package count.

## Requirements

- `jp2a`: A command-line tool to convert images to ASCII art.
- `xrandr`: Utility to get screen resolution.
- Ensure the script is executed in an environment where these tools are available.

## Installation

1. Install `jp2a` and `xrandr` if not already installed:
   ```sh
   sudo apt-get install jp2a x11-xserver-utils
   ```

2. Save the script to a file, for example, `fetch.sh`.

3. Make the script executable:
   ```sh
   chmod +x fetch.sh
   ```

## Usage

1. Update the `IMAGE` variable in the script to point to your desired image file:
   ```sh
   IMAGE=your_image.png
   ```

2. Customize the colors by updating the `imageColor`, `TextColor`, and `Spec` variables:
   ```sh
   imageColor=$RED
   TextColor=$YELLOW
   Spec=$BROWN_ORANGE
   ```

3. Run the script:
   ```sh
   ./fetch.sh
   ```

**Note:**
Make sure the IMAGE file path is correct and that the image is accessible. Customize the colors as needed to suit your preference.

To add the `fetch.sh` script to your PATH as `diagofetch`:

1. Move the script to a directory in your PATH:
   ```sh
   mv fetch.sh /usr/local/bin/diagofetch
   ```

2. Make it executable:
   ```sh
   chmod +x /usr/local/bin/diagofetch
   ```

3. Now you can use `diagofetch` from any directory.