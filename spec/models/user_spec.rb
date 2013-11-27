require 'spec_helper'

describe User do
  describe '#save_certificate' do
    let(:file_certificate){ 'spec/fixtures/example_certificates/TUMG620310R95/TUMG620310R95_1210241209S.cer' }

    context 'When upload a valid file' do
      before do

      end
      it 'save it in s3 storage service' do
        expect(subject.save_certificate(file_certificate)).to eql('certificates/TUMG620310R95.cer')
      end
    end
  end
end
