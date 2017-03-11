require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

s3_options = {
  access_key_id:     '',
  secret_access_key: '',
  region:            'us-east-1',
  bucket:            ''
}

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
  store: Shrine::Storage::S3.new(prefix: 'store', **s3_options) # permanent
}
  # store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'), # permanent

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :backgrounding
Shrine.plugin :logging
Shrine.plugin :determine_mime_type

Shrine::Attacher.promote { |data| ImagePromoteWorker.perform_async(data) }
Shrine::Attacher.delete { |data| ImageDeleteWorker.perform_async(data) }
