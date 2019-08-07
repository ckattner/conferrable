# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  # Extra utilities that help, but do not define the domain.
  class FileUtilities
    class << self
      def resolve(filenames)
        Array(filenames).flatten.map do |filename|
          next unless filename && filename.to_s.length.positive?

          list(filename)
        end.flatten
      end

      def read(filename)
        file_content = IO.read(filename)

        pre_processed_content =
          filename.downcase.end_with?(ERB_EXTENSION) ? ERB.new(file_content).result : file_content

        YAML.safe_load(pre_processed_content)
      end

      private

      ERB_EXTENSION = '.erb'
      FILE_MATCHER = /.+\.(ya?ml|ya?ml.erb)\Z/i.freeze
      private_constant :ERB_EXTENSION, :FILE_MATCHER

      def list(filename)
        if File.exist?(filename) && File.directory?(filename)
          glob_files_only(filename)
        elsif File.exist?(filename)
          filename
        else
          raise ArgumentError, "Cannot find file: #{filename} => #{File.expand_path(filename)}"
        end
      end

      def glob_files_only(filename)
        dir_glob = File.join(filename, '**/*')
        Dir.glob(dir_glob).grep(FILE_MATCHER).reject { |f| File.directory?(f) }
      end
    end
  end
end
