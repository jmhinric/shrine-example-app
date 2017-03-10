require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :backgrounding
Shrine.plugin :logging
Shrine.plugin :determine_mime_type

Shrine::Attacher.promote { |data| ImagePromoteWorker.perform_async(data) }
Shrine::Attacher.delete { |data| ImageDeleteWorker.perform_async(data) }
