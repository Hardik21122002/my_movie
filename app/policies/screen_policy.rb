class ScreenPolicy < ApplicationPolicy
    
  def create?
    # user.theater_admin? && user.theater_id == record.theater_id 
    user.theater_admin? && user.theaters.exists?(record.theater_id)
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
