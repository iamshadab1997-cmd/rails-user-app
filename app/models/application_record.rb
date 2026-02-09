class ApplicationRecord < ActiveRecord::Base   # Base class for all models; gives DB features
  primary_abstract_class                         # This class itself has no table; only its subclasses do
end

# Notes:
# 1️⃣ All models inherit from ApplicationRecord to get database methods (CRUD, queries).
# 2️⃣ It is abstract, so Rails won't create a table for it.
# 3️⃣ You can add common methods or scopes here for all models.
