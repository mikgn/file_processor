# File Processor

This application is a command-line tool to extract previews and text from image and PDF files.

## Features

*   Extracts previews from images and PDFs.
*   Extracts text from PDFs.
*   Logs all processing steps.

## Dependencies

The application relies on the following Ruby gems:

*   `mini_magick`: For image processing.
*   `pdf-reader`: For reading PDF files.
*   `thor`: For CLI handling.

It also requires system-level dependencies:

*   `poppler-utils`: For PDF processing (specifically, `pdfimages` and `pdftotext`).
*   `imagemagick`: For image manipulation and PDF preview generation.
*   `ghostscript`: Used by ImageMagick for handling PDFs.

These dependencies are installed within the Docker container using the Dockerfile. If you're running the application directly (without Docker), you'll need to install them on your system.

## Usage

`./bin/cli process -f  <file>  -c  <command>`


*   `-f`: Input file (required).
*   `-c`: Command (`preview`, `text`, `all`). Defaults to `all`.

## Commands

*   `preview`: Extracts a preview image.
*   `text`: Extracts text from PDF.
*   `all`: Extracts preview and text (PDFs only).

## Examples

`./bin/cli process -f data/sample/sample_pdf.pdf -c all  `
`./bin/cli process -f data/sample/sample_jpg.jpg -c preview`


## Docker

`docker compose build`
`docker compose run --rm file_processor -f data/sample/sample_pdf.pdf -c all`

