# Books Renamer

## Introduction

Books Renamer is a Ruby script that automates the renaming of PDF files within a specified directory based on metadata extracted from each file. It uses the title and author information from the PDF metadata to construct new, more descriptive filenames. The script can operate in a dry run mode to display what changes it would make without actually renaming any files.

## Features

- Extracts metadata (title and author) from PDF files.
- Renames PDF files based on extracted metadata.
- Supports dry run mode to preview potential changes without modifying files.
- Uses I18n for transliteration to handle non-ASCII characters in filenames.

## Installation

To run Books Renamer, you'll need Ruby installed on your machine. You will also need to install several dependencies:

```bash
bundle install
```

## Usage

To use Books Renamer, navigate to the directory containing your script and run:

```bash
ruby book_renamer.rb DIRECTORY [--update]
```

Options:

- `DIRECTORY`: The path to the directory containing the PDF files you want to rename.
- `--update`: Optional flag to apply the renaming changes. Without this flag, the script will only perform a dry run.

### Warning

Using the `--update` flag will permanently replace the file names in the specified directory. Make sure to back up your files or use the dry run mode to review changes before applying this flag.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

To contribute to Books Renamer, follow these steps:

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## Author

Copyright (c) 2024 Martin Ferrari <dmferrari@gmail.com>

## Disclaimer

This software is provided 'as is', without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

## License

Distributed under the MIT License.

## Acknowledgments

- [PDF-Reader](https://github.com/yob/pdf-reader) - PDF reading library used to extract metadata.
- [I18n](https://github.com/ruby-i18n/i18n) - Library used for transliterating filenames.
