RSpec.describe ImageUploader do
  def uploaded_file(metadata = {})
    Shrine.uploaded_file(
      'id'       => '123',
      'storage'  => 'cache',
      'metadata' => { 'mime_type' => 'image/jpeg', 'size' => 100 }.merge(metadata)
    )
  end

  let(:comment) { build(:comment, image: uploaded_file(metadata).to_json) }
  let(:comment_with_image) { create(:comment, :with_image) }

  let(:metadata) { {} }

  describe 'validations' do
    before(:each) { comment.valid? }

    context 'when image is correct' do
      it 'passes' do
        expect(comment.errors).to be_empty
      end
    end

    context "when extension is correct but MIME types isn't" do
      let(:metadata) { Hash['filename' => 'image.jpg', 'mime_type' => 'text/plain'] }

      it 'fails' do
        error_message = "isn't of allowed type (allowed types: image/jpeg, image/jpg, image/png)"
        expect(comment.errors[:image][0]).to eq(error_message)
      end
    end

    context 'when file is larger than 10MB' do
      let(:metadata) { Hash['size' => 11 * 1024 * 1024] }

      it 'fails' do
        expect(comment.errors[:image].first.to_s).to eq('is too large (max is 10 MB)')
      end
    end
  end
end
