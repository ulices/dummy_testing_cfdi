class User < ActiveRecord::Base
  attr_accessor :encryption_key

  def save_certificate certificate_path
    service = connect_with_service
    service.upload_certificate certificate_path
    certificate_url
  end

  def save_key key_path
    service = connect_with_service
    convert_key_to_pem key_path
    service.upload_key "tmp/#{@uer.rfc}.key.pem"
    key_url
  end

  def get_encryption_key
    self.encryption_key || generate_encryption_key
  end

  def generate_encryption_key
    self.update_attributes(encryption_key: OpenSSL::Cipher.new("AES-256-ECB").random_key)
    self.encryption_key
  end

  private

  def connect_with_service
    UserCredentialService.new self
  end

  def convert_key_to_pem key_path
    puts 'Convert to pem'
    %x{ openssl pkcs8 -inform DER -in #{key_path} -passin pass:somePassword -out tmp/#{@user.rfc}.key.pem }
  end

end
