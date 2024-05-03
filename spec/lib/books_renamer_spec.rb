# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/books_renamer'

RSpec.describe BooksRenamer do # rubocop:disable Metrics/BlockLength
  subject(:books_renamer) { described_class.new(directory, update: update_flag) }

  let(:directory) { 'spec/fixtures' }
  let(:update_flag) { false }
  let(:book_title) { 'The Hitchhikers Guide to the Galaxy' }
  let(:book_author) { 'Douglas Adams' }
  let(:file_name) { 'book1.pdf' }
  let(:file_path) { "#{directory}/#{file_name}" }

  before do
    allow_any_instance_of(described_class).to receive(:log)
    allow(File).to receive(:basename).with(file_path).and_return(file_name)
    allow(File).to receive(:extname).with(file_path).and_return('.pdf')
    allow(File).to receive(:exist?).with(file_path).and_return(true)
    allow(books_renamer).to receive(:fetch_metadata).and_return([book_title, book_author])
  end

  describe '#initialize' do
    it 'initializes with the provided directory and update flag' do
      expect(books_renamer.instance_variable_get(:@directory)).to eq(directory)
      expect(books_renamer.instance_variable_get(:@update)).to be false
    end
  end

  describe '#rename_books' do # rubocop:disable Metrics/BlockLength
    context 'when there are PDF files in the directory' do
      before do
        allow(Dir).to receive(:glob).with("#{directory}/*.pdf").and_return([file_path])
      end

      context 'when multiple PDF files are present in the directory' do
        let(:files) { ["#{directory}/book1.pdf", "#{directory}/book2.pdf"] }

        it 'calls process_file for each PDF file' do
          allow(Dir).to receive(:glob).with("#{directory}/*.pdf").and_return(files)
          expect(books_renamer).to receive(:process_file).exactly(files.size).times
          books_renamer.rename_books
        end
      end

      context 'with the update flag set' do
        let(:update_flag) { true }

        context 'when the file has metadata' do
          it 'renames the file' do
            expect(FileUtils).to receive(:mv).with(file_path, "#{directory}/#{book_title} - #{book_author}.pdf")
            books_renamer.rename_books
          end
        end

        context 'when the file is broken or has no metadata' do
          before do
            allow(books_renamer).to receive(:fetch_metadata).and_return([nil, nil])
          end

          it 'skips the file' do
            expect(FileUtils).not_to receive(:mv)
            books_renamer.rename_books
          end
        end
      end

      context 'with the update flag not set' do
        it 'does not rename the file' do
          expect(FileUtils).not_to receive(:mv)
          books_renamer.rename_books
        end
      end
    end

    context 'when there are no PDF files in the directory' do
      it 'does not process any files' do
        allow(Dir).to receive(:glob).with("#{directory}/*.pdf").and_return([])
        expect(books_renamer).not_to receive(:process_file)
        books_renamer.rename_books
      end
    end
  end
end
