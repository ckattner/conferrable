#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  class FileUtilities
    class << self

      def resolve(filenames)
        Array(filenames).flatten.map do |filename|
          next unless filename && filename.to_s.length > 0

          if File.exist?(filename) && File.directory?(filename)
            Dir.glob(File.join(filename, '**', '*')).select { |f| !File.directory?(f) }
          elsif File.exist?(filename)
            filename
          else
            raise ArgumentError, "Cannot find file: #{filename} => #{File.expand_path(filename)}"
          end
        end.flatten
      end

      def read(filename)
        YAML.load(ERB.new(IO.read(filename)).result)
      end

    end
  end
end
