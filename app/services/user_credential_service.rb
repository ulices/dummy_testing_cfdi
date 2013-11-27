class UserCredentialService

  def initialize user
    @user = user
    @bucket = create_bucket
  end

  def get_certificate
    obj = @bucket.objects["certificates/#{@user.rfc}.cer"]
    obj.read(encryption_key: @user.get_encryption_key)
  end

  def get_key
    obj = @bucket.objects["keys/#{@user.rfc}.key.pem"]
    obj.read(encryption_key: @user.get_encryption_key)
  end

  def list_objects
    @bucket.objects
  end

  def upload_certificate certificate_path
    puts 'Uploading the certificate'
    @bucket.objects
    object = @bucket.objects.create "certificates/#{@user.rfc}.cer",
      data: File.open(certificate_path),
      encryption_key: @user.get_encryption_key,
      content_type: 'text/cer',
      content_disposition: 'attachment'
    @user.update_attribute(:certificate_url, object.public_url.to_s)
  end

  def upload_key key_path
    puts 'Uploading the key'
    @bucket.objects
    object = @bucket.objects.create "keys/#{@user.rfc}.key.pem",
      data: File.open(key_path),
      encryption_key: @user.get_encryption_key,
      content_type: 'text/key.pem',
      content_disposition: 'attachment'
    @user.update_attribute(:key_url, object.public_url.to_s)
  end

  private

  def create_bucket
    s3 = AWS::S3.new
    cinuki = s3.buckets['cinuki']
    cinuki
  end
end
