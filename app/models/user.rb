class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exercises, dependent: :destroy
  has_many :friendships
  # no friends model, use the user model for it (friends is alias of user)
  has_many :friends, through: :friendships, class_name: "User"

  validates :first_name, presence: true
  validates :last_name, presence: true

  # display 10 records per page
  self.per_page = 5

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.size == 1
      where('first_name LIKE ? or last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ?
        or last_name LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
    end
  end

  def follows_or_same?(new_friend)
    # give all the friendships of the user
    # map over friendship (use the friendship association) and gives all the friends of the user
    # check if new friend is included in the friend list
    # or if current_user is this new friend
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end
end
 
