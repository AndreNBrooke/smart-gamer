class Playtime < ApplicationRecord
  belongs_to  :user
  before_save    :update_today_playtime

  private

  def update_today_playtime
    yesterday = user.playtimes.find_by(date: Date.today-1)
    # byebug
    if yesterday
      self.today_playtime = self[:total_playtime] - yesterday[:total_playtime]
    else
      self.today_playtime = 20
    end
  end

end