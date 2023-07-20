class ShowPolicy < ApplicationPolicy
  def create? 
    user.theater_admin? && user.theater_ids.include?(record.screen.theater_id) 
  end

  def edit?
    create?
  end

  def show?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end 

end
