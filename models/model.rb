#model.rb
class SubscriptionsUpdated < ActiveRecord::Base
    self.table_name = "subscriptions_updated"
  end

class Subscription < ActiveRecord::Base
  self.table_name = "subscriptions" 
end

  class PrepaidLate < ActiveRecord::Base
    self.table_name = "prepaid_late"
  end
  
  class Charge < ActiveRecord::Base
  
  end
  
  class Order < ActiveRecord::Base
  
  end
  
  class UpdatePrepaidOrder < ActiveRecord::Base
    self.table_name = "update_prepaid"
  end
  
  
  
  class UpdatePrepaidConfig < ActiveRecord::Base
    self.table_name =  "update_prepaid_config"
  end