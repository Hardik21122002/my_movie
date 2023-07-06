class BookingInfoPolicy < ApplicationPolicy

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

