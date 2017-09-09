class User < ActiveRecord::Base
  rolify
  include Authority::UserAbilities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :reviews, dependent: :destroy
  has_many :asks, dependent: :destroy
  has_many :joayos
  has_many :stores, :through => :joayos
  
  after_create :set_default_role, if: Proc.new { User.count > 1 }

  private

  def set_default_role
    add_role :user
  end
end
