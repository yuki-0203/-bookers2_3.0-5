class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
    has_many :relationships, foreign_key: :following_id , dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  
  has_many :revers_of_relationships, class_name: 'Relationship', foreign_key: :follower_id , dependent: :destroy
  has_many :followers, through: :revers_of_relationships, source: :following
  
  def is_followed_by?(user)
    revers_of_relationships.find_by(following_id: user.id).present?
  end
  
  attachment :profile_image, destroy: false
  validates :introduction,length: {maximum:50} 
  validates :name,length: { in: 2..20 }, uniqueness: true
  
end
