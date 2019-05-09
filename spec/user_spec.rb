require 'user'
require 'database_helpers'
require 'bcrypt'

describe User do

  describe '.create' do
    it 'creates a new user' do
      user = User.create(email: 'test@example.com', password: 'password123')

      persisted_data = persisted_data(id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data['id']
      expect(user.email).to eq 'test@example.com'
    end

    it "hashes the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with('password123')

      User.create(email: 'test@example.com', password: 'password123')
    end
  end

  describe '.authenticate' do
    it 'returns a user given the correct username and password, if one exists' do
      user = User.create(email: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')
      expect(authenticated_user.id).to eq(user.id)
    end

    it 'returns nil given an incorrect email address' do
      user = User.create(email: 'test@example.com', password: 'password123')

      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.create(email: 'test@example.com', password: 'password123')
      expect(User.authenticate(email: 'test@example.com', password: 'wrongpassword')).to be_nil
    end
  end


  describe '.find' do
    it 'finds a user by id' do
      user = User.create(email: 'test@example.com', password: 'password123')
      result = User.find(user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end

    it 'returns nil if there is no id given' do
      expect(User.find(nil)).to eq nil
    end
  end

end
