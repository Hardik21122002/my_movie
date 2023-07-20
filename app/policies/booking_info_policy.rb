class BookingInfoPolicy < ApplicationPolicy
 
  def show?
    user == record.user ||
      (user.theater_admin? && user.theaters.exists?(record&.theater_id))
  end 

  def edit?
    user.theater_admin? && user.theaters.exists?(record.theater_id)
  end

  def update?
    user.theater_admin? && user.theaters.exists?(record.theater_id)
  end

  def destroy?
    user.theater_admin? && user.theaters.exists?(record.theater_id)
  end
end

