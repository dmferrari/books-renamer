# BookRenamer

## Introduction

BookRenamer is a Ruby script that automates the renaming of PDF files within a specified directory based on metadata extracted from each file. It uses the title and author information from the PDF metadata to construct new, more descriptive filenames. The script can operate in a dry run mode to display what changes it would make without actually renaming any files.

## Features

- Extracts metadata (title and author) from PDF files.
- Renames PDF files based on extracted metadata.
- Supports dry run mode to preview potential changes without modifying files.
- Uses I18n for transliteration to handle non-ASCII characters in filenames.

## Installation

To run BookRenamer, you'll need Ruby installed on your machine. You will also need to install several dependencies:

```bash
bundle install
```

## Usage

To use BookRenamer, navigate to the directory containing your script and run:

```bash
ruby book_renamer.rb DIRECTORY [--update]
```

Options:

- `DIRECTORY`: The path to the directory containing the PDF files you want to rename.
- `--update`: Optional flag to apply the renaming changes. Without this flag, the script will only perform a dry run.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

To contribute to BookRenamer, follow these steps:

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## Author

Martin Ferrari <dmferrari@gmail.com>

## License

Distributed under the MIT License.

## Acknowledgments

- [PDF-Reader](https://github.com/yob/pdf-reader) - PDF reading library used to extract metadata.
- [I18n](https://github.com/ruby-i18n/i18n) - Library used for transliterating filenames.
